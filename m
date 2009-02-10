From: Alfs Kurmis <kallipygos@inbox.lv>
Subject: Re: using ALSA one call
Date: Wed, 11 Feb 2009 00:47:35 +0200
Message-ID: <1234306055.499204078ce73@mail.inbox.lv>
References: <1234269014.49917356f0157@mail.inbox.lv>
	<49919765.4000706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shark3.inbox.lv (shark3.inbox.lv [89.111.3.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F94424400
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 23:47:36 +0100 (CET)
Received: from localhost (w10 [10.0.1.20])
	by shark3-plain-b64d2.inbox.lv (Postfix) with ESMTP id 98FE2570
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 00:47:35 +0200 (EET)
In-Reply-To: <49919765.4000706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Moin Meister

Quoting Clemens Ladisch <clemens@ladisch.de>:
> > but only if  samplerate = 48000;
> > if  samplerate = 44100 - then not :(
> > 44k file play in 48k mode :D  it sounds funnee :D
> >
> > i gotta this :
> > ALSA lib pcm.c:7160:(snd_pcm_set_params) Rate doesn't match (requested
> 44100Hz, get 0Hz)
>
> Please show the source code of your program.

see below


I have on my notebook 2 sound cards
* built in
$ lspci
...
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
...
and
second on USB wire  - Edirol by Roland ...
I have switch em to 44,1k

As given here
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#g6aa164ed37308d66bcc079f5cd265a09
latency         required overall latency in us (0 = optimum latency for players)
i have try to set  optimum latency = 0;

snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE, SND_PCM_ACCESS_RW_INTERLEAVED,
                                channelz, samplerate ,  0, 0)


./pcm_min01  '/mnt/hda2/Booty Luv - Shine/Booty Luv - Boogie 2nite (DJ Teddy-o remix).wav'
Now playing to USB device "hw:1,0"
gotta this :
Short write (expected 4096, wrote 360)
Short write (expected 4096, wrote 360)
Short write (expected 4096, wrote 2427)
wery fragmentary sound

with latency = 500000 us USB play is OK.

But why i can not play my wave on notebook sound device "hw:0,0" ??


Tnx in advance

Alf

/*
 *  This extra small demo sends a random samples to your speakers.
 */

#include "alsa/asoundlib.h"

#include <stdio.h>
#include <fcntl.h>     //
#include <unistd.h>    //
#include <sys/types.h> //

//static char *device = "default";                        /* playback device */
//static char *device = "hw:0,0";
static char *device = "hw:1,0";

snd_output_t *output = NULL;
//unsigned char buffer[16*1024];                          /* some random data */
/*unsigned*/ short buffer[/*4*1024*/8192];

int main( int argc, char *argv[] )
{
  int err;    
  unsigned int i;   int channelz, bytes_per_sample, samplerate;
  snd_pcm_t *handle;
  snd_pcm_sframes_t frames , frames_2_write;
         int einfd ;  int  rdstatus ;

//  samplerate = 48000;
  samplerate = 44100;
  channelz =2;
  bytes_per_sample = 2;
  frames_2_write = sizeof(buffer) / (channelz * bytes_per_sample);
  //for (i = 0; i < (4*1024) ; i++){  buffer[i] = random() & 0xffff; }
      einfd = open( argv[1] , O_RDONLY );  lseek(einfd, 48L ,SEEK_SET);

  if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
          printf("Playback open error: %s\n", snd_strerror(err));  exit(EXIT_FAILURE);
  }
  if ((err = snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE, SND_PCM_ACCESS_RW_INTERLEAVED,
                                channelz, samplerate ,  0, 500000)) < 0) {   /* 500000  0.5sec */
          printf("Playback open error: %s\n", snd_strerror(err)); exit(EXIT_FAILURE);
  }

  for (i = 0; i < 128; i++) {
                rdstatus  =  read(einfd,&buffer[0],sizeof(buffer));
          frames = snd_pcm_writei(handle, buffer, frames_2_write );
          if (frames < 0)
                  frames = snd_pcm_recover(handle, frames, 1);
          if (frames < 0) {
                  printf("snd_pcm_writei failed: %s\n", snd_strerror(err));
                  /*break;*/  goto yuck_off;  }
          if (frames > 0 && frames < (long) frames_2_write)
                  printf("Short write (expected %li, wrote %li)\n", (long) frames_2_write, frames);
  }


yuck_off:
  close(einfd);
  snd_pcm_close(handle);
  return 0;
}









----
