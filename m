From: Carlos Pita <cpitaar@yahoo.com.ar>
Subject: hw/plughw strange behaviour
Date: Thu, 10 Jun 2004 02:19:58 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406100219.58760.cpitaar@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have a problem using the plughw device with slave the hw:0,0 device: a pcm 
in an AWE 64 Gold. When invoking snd_pcm_hw_params on plughw:0,0 I get an 
'Invalid argument' error (-22). However, running the same program directly on 
hw:0,0 works fine. Also, both versions run without complaints in another PC 
with a VIA686A (but when adding a simple sinusoidal wave playback test, hw 
and plughw sound with different pitch, suggesting a problem with frequencies 
perhaps due to conversions having place in plughw). Both PCs are running 
Mandrake 10, which provides:

linux-2.6.3-7mdk
libalsa2-1.0.2-3mdk

Below are the source code for the program and the output of running it, first 
with hw:0,0, then using plughw:0,0, for the AWE 64 Gold.

Thank you in advace.
Regards,
Carlos.

test-alsa.c
-----------

#include <stdio.h>
#include <alsa/asoundlib.h>

int main() {
   
   snd_pcm_t *handle;          
   snd_pcm_hw_params_t *hwparams;

   #define device "hw:0,0"
   //#define device "plughw:0,0"
   
   #define requested_rate 44100
   int rate = requested_rate;
   int dir = 1; /* exact_rate > rate  => dir = 1 */
  
   #define numchannels 2
   #define numperiods 2
   #define periodsize (8192 / 4)
   #define requested_buffersize (numperiods * periodsize)
   snd_pcm_uframes_t buffersize = requested_buffersize;
  
   int errnum;
   snd_output_t *output;
      
   snd_pcm_open(&handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0);
   
   /* set hw params */
   snd_pcm_hw_params_malloc(&hwparams);
   snd_pcm_hw_params_any(handle, hwparams);   
   snd_pcm_hw_params_set_access(handle, hwparams, 
SND_PCM_ACCESS_RW_INTERLEAVED);
   snd_pcm_hw_params_set_format(handle, hwparams, SND_PCM_FORMAT_S16_LE);
   snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, &dir);
   printf("Rate = %d, requested rate = %d.\n", rate, requested_rate);
   snd_pcm_hw_params_set_channels(handle, hwparams, numchannels);
   snd_pcm_hw_params_set_periods(handle, hwparams, numperiods, 0);
   snd_pcm_hw_params_set_buffer_size_near(handle, hwparams, &buffersize);
   printf("Buffer size: %d, requested buffer size: %d.\n", buffersize, 
requested_buffersize);   
   if ((errnum = snd_pcm_hw_params(handle, hwparams)) < 0) {
      fprintf(stderr, "Error (%d) setting parameters: %s.\n", errnum, 
snd_strerror(errnum));
      return(-1);
   }
   snd_pcm_hw_params_free(hwparams);

   /* dump device */
   snd_output_stdio_attach(&output, stdout, 0);
   snd_pcm_dump_hw_setup(handle, output);
   fflush(stdout);

   // play(handle, periodsize);

   snd_pcm_close(handle);
}

Output for hw:0,0
-----------------

Rate = 44100, requested rate = 44100.
Buffer size: 4096, requested buffer size: 4096.
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 4096
period_size  : 2048
period_time  : 46439
tick_time    : 1000

Output for plughw:0,0
---------------------

Rate = 44100, requested rate = 44100.
Buffer size: 4096, requested buffer size: 4096.
Error (-22) setting parameters: Invalid argument.




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
