From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: dmix bugs. sounds very broken up.
Date: Tue, 02 Sep 2003 00:08:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F53D15B.3090507@superbug.demon.co.uk>
References: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010707050402070208010408"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010707050402070208010408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav Kysela wrote:
> On Mon, 1 Sep 2003, James Courtier-Dutton wrote:
> 
> 
>>I have found two problems with using the dmix alsa device name.
>>1) snd_pcm_hw_params_can_pause (params)  causes alsa-lib to assert!
>>
>>2) Sound is broken up.
>>a) It can only function with 2 periods, why is that? Having 8 periods
>>might be better, although "front" works fine with 2 periods, but "dmix"
>>with 2 periods fails.

See attachment dmix-fail.c
compile with
gcc -g -DDEBUG -lasound a.c

Shows problem (1) and (2)

>>b) Of the 2 periods, it sounds like sound is only being played from one
>>of the periods, with silence for the other period.
>>
I don't have a small compilable example for this yet. The problem 
application is the latest xine cvs. (xine.sf.net)

>>Summary: -
>>If I use device name "front", there are no problems with sound output.
>>If I use device name "dmix", there are the above problems.
> 
> 
> Show me your code, please (compilable example).
> 
> 						Jaroslav
> 

Cheers
James

--------------010707050402070208010408
Content-Type: text/plain;
 name="dmix-fail.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmix-fail.c"

/* 
 * Copyright (C) 2000-2002 the xine project
 * 
 * This file is part of xine, a free video player.
 * 
 * xine is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * xine is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA
 *
 * Credits go 
 * - for the SPDIF A/52 sync part
 * - frame size calculation added (16-08-2001)
 * (c) 2001 Andy Lo A Foe <andy@alsaplayer.org>
 * for initial ALSA 0.9.x support.
 *     adding MONO/STEREO/4CHANNEL/5CHANNEL/5.1CHANNEL analogue support.
 * (c) 2001 James Courtier-Dutton <James@superbug.demon.co.uk>
 *
 * 
 * $Id: audio_alsa_out.c,v 1.106 2003/09/01 04:08:41 jcdutton Exp $
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <math.h>
#include <alloca.h>

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>

#include <sys/ioctl.h>
#include <inttypes.h>
#include <pthread.h>

/*
#define ALSA_LOG
*/
/*
#define LOG_DEBUG
*/

#define AO_OUT_ALSA_IFACE_VERSION 7

#define BUFFER_TIME               1000*1000
#define PERIOD_TIME               100*1000
#define GAP_TOLERANCE             5000

#define MIXER_MASK_LEFT           (1 << 0)
#define MIXER_MASK_RIGHT          (1 << 1)
#define MIXER_MASK_STEREO         (MIXER_MASK_LEFT|MIXER_MASK_RIGHT)

typedef struct alsa_driver_s {

  snd_pcm_t         *audio_fd;
  int                capabilities;
  int                open_mode;
  int		     has_pause_resume;

  int32_t            output_sample_rate, input_sample_rate;
  double             sample_rate_factor;
  uint32_t           num_channels;
  uint32_t           bits_per_sample;
  uint32_t           bytes_per_frame;
  uint32_t           bytes_in_buffer;      /* number of bytes writen to audio hardware   */
  snd_pcm_uframes_t  buffer_size;
  int32_t            mmap; 

} alsa_driver_t;

static snd_output_t *jcd_out;

/*
 * open the audio device for writing to
 */
int main (int argc, char **argv) {
  
  alsa_driver_t         variables;
  alsa_driver_t         *this = &variables;
  char                 *pcm_device;
  snd_pcm_stream_t      direction = SND_PCM_STREAM_PLAYBACK; 
  snd_pcm_hw_params_t  *params;
  snd_pcm_sw_params_t  *swparams;
  snd_pcm_access_mask_t *mask;
  snd_pcm_uframes_t     period_size;
  uint32_t              periods;
  uint32_t              buffer_time=BUFFER_TIME;
  int                   err, dir;
  int                 open_mode=1; /* NONBLOCK */
  /* int                   open_mode=0;  BLOCK */
  int rate = 48000;
  int bits = 16;

  snd_pcm_hw_params_alloca(&params);
  snd_pcm_sw_params_alloca(&swparams);
  err = snd_output_stdio_attach(&jcd_out, stdout, 0);
 
  pcm_device = "dmix"; 

#ifdef ALSA_LOG
  printf("audio_alsa_out: Audio Device name = %s\n",pcm_device);
  printf("audio_alsa_out: Number of channels = %d\n",this->num_channels);
#endif

  this->audio_fd = NULL;

  this->open_mode              = open_mode;
  this->input_sample_rate      = rate;
  this->bits_per_sample        = bits;
  this->num_channels        = 2;
  this->bytes_in_buffer        = 0;
  /*
   * open audio device
   */
  err=snd_pcm_open(&this->audio_fd, pcm_device, direction, open_mode);      
  if(err <0 ) {                                                           
    printf ("audio_alsa_out: snd_pcm_open() of %s failed: %s\n", pcm_device, snd_strerror(err));               
    printf ("audio_alsa_out: >>> check if another program don't already use PCM <<<\n");     
    return 0;
  }
  /* printf ("audio_alsa_out: snd_pcm_open() opened %s\n", pcm_device); */ 
  /* We wanted non blocking open but now put it back to normal */
  //snd_pcm_nonblock(this->audio_fd, 0);
  snd_pcm_nonblock(this->audio_fd, 1);
  /*
   * configure audio device
   */
  err = snd_pcm_hw_params_any(this->audio_fd, params);
  if (err < 0) {
    printf ("audio_alsa_out: broken configuration for this PCM: no configurations available\n");
    goto __close;
  }
  /* set interleaved access */
  if (this->mmap != 0) {
    mask = alloca(snd_pcm_access_mask_sizeof());
    snd_pcm_access_mask_none(mask);
    snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
    snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
    snd_pcm_access_mask_set(mask, SND_PCM_ACCESS_MMAP_COMPLEX);
    err = snd_pcm_hw_params_set_access_mask(this->audio_fd, params, mask);
    if (err < 0) {
      printf ("audio_alsa_out: mmap not availiable, falling back to compatiblity mode\n");
      this->mmap=0;
      err = snd_pcm_hw_params_set_access(this->audio_fd, params,
                                     SND_PCM_ACCESS_RW_INTERLEAVED);
    }
  } else {
    err = snd_pcm_hw_params_set_access(this->audio_fd, params,
                                     SND_PCM_ACCESS_RW_INTERLEAVED);
  }
      
  if (err < 0) {
    printf ("audio_alsa_out: access type not available\n");
    goto __close;
  }
  /* set the sample format ([SU]{8,16{LE,BE}})*/
  err = snd_pcm_hw_params_set_format(this->audio_fd, params, (bits == 16) ?
#ifdef WORDS_BIGENDIAN
		  SND_PCM_FORMAT_S16_BE
#else
		  SND_PCM_FORMAT_S16_LE
#endif
		  : SND_PCM_FORMAT_U8);
  if (err < 0) {
    printf ("audio_alsa_out: sample format non available\n");
    goto __close;
  }
  /* set the number of channels */
  err = snd_pcm_hw_params_set_channels(this->audio_fd, params, this->num_channels);
  if (err < 0) {
    printf ("audio_alsa_out: Cannot set number of channels to %d (err=%d)\n", this->num_channels, err);
    goto __close;
  }
  /* set the stream rate [Hz] */
  dir=0;
  err = snd_pcm_hw_params_set_rate_near(this->audio_fd, params, &rate, &dir);
  if (err < 0) {
    printf ("audio_alsa_out: rate not available\n");
    goto __close;
  }
  this->output_sample_rate = (uint32_t)rate;
  if (this->input_sample_rate != this->output_sample_rate) {
    printf ("audio_alsa_out: audio rate : %d requested, %d provided by device/sec\n",
	    this->input_sample_rate, this->output_sample_rate);
  }

  /* Set period to buffer size ratios at 8 periods to 1 buffer */
  dir=-1;
  periods=8;
  err = snd_pcm_hw_params_set_periods_near(this->audio_fd, params, &periods ,&dir);
  if (err < 0) {
    printf ("audio_alsa_out: unable to set any periods\n");
    goto __close;
  }
  printf ("audio_alsa_out: Requested 8 periods, got %d\n", periods);

  /* set the ring-buffer time [us] (large enough for x us|y samples ...) */
  dir=0;
  err = snd_pcm_hw_params_set_buffer_time_near(this->audio_fd, params, &buffer_time, &dir);
  if (err < 0) {
    printf ("audio_alsa_out: buffer time not available\n");
    goto __close;
  }
  err = snd_pcm_hw_params_get_buffer_size(params, &(this->buffer_size));

#if 0
  /* set the period time [us] (interrupt every x us|y samples ...) */
  dir=0;
  period_size=this->buffer_size/8;
  err = snd_pcm_hw_params_set_period_size_near(this->audio_fd, params, &period_size, &dir);
  if (err < 0) {
    printf ("audio_alsa_out: period time not available");
    goto __close;
  }
#endif
  dir=0;
  err = snd_pcm_hw_params_get_period_size(params, &period_size, &dir);
  if (2*period_size > this->buffer_size) {
    printf ("audio_alsa_out: buffer to small, could not use\n");
    goto __close;
  }
  
  /* write the parameters to device */
  err = snd_pcm_hw_params(this->audio_fd, params);
  if (err < 0) {
    printf ("audio_alsa_out: pcm hw_params failed: %s\n", snd_strerror(err));
    goto __close;
  }
  /* Check for pause/resume support */
  this->has_pause_resume = ( snd_pcm_hw_params_can_pause (params)
			    && snd_pcm_hw_params_can_resume (params) );
  this->sample_rate_factor = (double) this->output_sample_rate / (double) this->input_sample_rate;
  this->bytes_per_frame = snd_pcm_frames_to_bytes (this->audio_fd, 1);
  /*
   * audio buffer size handling
   */
  /* Copy current parameters into swparams */
  err = snd_pcm_sw_params_current(this->audio_fd, swparams);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to determine current swparams: %s\n", snd_strerror(err));
    goto __close;
  }
  /* align all transfers to 1 sample */
  err = snd_pcm_sw_params_set_xfer_align(this->audio_fd, swparams, 1);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to set transfer alignment: %s\n", snd_strerror(err));
    goto __close;
  }
  /* allow the transfer when at least period_size samples can be processed */
  err = snd_pcm_sw_params_set_avail_min(this->audio_fd, swparams, period_size);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to set available min: %s\n", snd_strerror(err));
    goto __close;
  }
  /* start the transfer when the buffer contains at least period_size samples */
  err = snd_pcm_sw_params_set_start_threshold(this->audio_fd, swparams, period_size);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to set start threshold: %s\n", snd_strerror(err));
    goto __close;
  }

  /* never stop the transfer, even on xruns */
  err = snd_pcm_sw_params_set_stop_threshold(this->audio_fd, swparams, this->buffer_size);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to set stop threshold: %s\n", snd_strerror(err));
    goto __close;
  }

  /* Install swparams into current parameters */
  err = snd_pcm_sw_params(this->audio_fd, swparams);
  if (err < 0) {
    printf ("audio_alsa_out: Unable to set swparams: %s\n", snd_strerror(err));
    goto __close;
  }
#ifdef ALSA_LOG
  snd_pcm_dump_setup(this->audio_fd, jcd_out); 
  snd_pcm_sw_params_dump(swparams, jcd_out);
#endif
  
//  return this->output_sample_rate;

__close:
  snd_pcm_close (this->audio_fd);
  this->audio_fd=NULL;
  return 0;
}


--------------010707050402070208010408--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
