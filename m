From: Carlos Pita <cpitaar@yahoo.com.ar>
Subject: Re: a bug? (was: hw/plughw strange behaviour)
Date: Mon, 14 Jun 2004 12:27:47 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406141227.47412.cpitaar@yahoo.com.ar>
References: <Pine.HPX.4.33n.0406141617570.14592-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zPczAlIQnGXMPhK"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406141617570.14592-100000@studcom.urz.uni-halle.de>
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


--Boundary-00=_zPczAlIQnGXMPhK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Please add a call to snd_pcm_hw_params_dump() before
> snd_pcm_hw_params().  What is the difference between the configuration
> that fails and the others?

Ok.  Attached to this email, I'm sending you the output and the code for the 
revised (according to your observations) program.

> > 4) I've attached an example test to this post
>
> It seems the call to set_buffer_size is missing.

Yep. It probably have been erased during a last time editing before posting 
the code. Anyway my binary was compiled from the correct source.

> And it reuses the dir value returned by set_rate_near for the
> set_period_time_near call.

Mmmm. I've fixed this issue setting dir to 1 before calling 
set_period_time_near and set_buffer_time_near.

Anyway, the problem remains.

Regards,
Carlos.

--Boundary-00=_zPczAlIQnGXMPhK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="output"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="output"


Settings params for 'hw:0,0', dir is NULL...
********************************************


Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 2
BUFFER_TIME: 200000
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000

Dump of device setup
--------------------

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8820
period_size  : 4410
period_time  : 100000
tick_time    : 1000

Settings params for 'plughw:0,0', dir is NULL...
************************************************


Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 2
BUFFER_TIME: 200000
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000

Dump of device setup
--------------------

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8820
period_size  : 4410
period_time  : 100000
tick_time    : 1000

Settings params for 'hw:0,0', dir is pointer = 0...
***************************************************


Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 2
BUFFER_TIME: 200000
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000

Dump of device setup
--------------------

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8820
period_size  : 4410
period_time  : 100000
tick_time    : 1000

Settings params for 'plughw:0,0', dir is pointer = 0...
*******************************************************


Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 2
BUFFER_TIME: 200000
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000

Dump of device setup
--------------------

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8820
period_size  : 4410
period_time  : 100000
tick_time    : 1000

Settings params for 'hw:0,0', dir is pointer = 1...
***************************************************


Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 100000
PERIOD_SIZE: 4410
PERIOD_BYTES: 17640
PERIODS: 2
BUFFER_TIME: 200000
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000

Dump of device setup
--------------------

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8820
period_size  : 4410
period_time  : 100000
tick_time    : 1000

Settings params for 'plughw:0,0', dir is pointer = 1...
*******************************************************

Buffer time doesn't match (requested 200000us, get 199999us)
Period time doesn't match (requested 100000us, get 100022us)

Dump of hwparams
----------------

ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: (44100 44101)
PERIOD_TIME: (100022 100023)
PERIOD_SIZE: 4411
PERIOD_BYTES: 17644
PERIODS: (1 2)
BUFFER_TIME: (199999 200000)
BUFFER_SIZE: 8820
BUFFER_BYTES: 35280
TICK_TIME: 1000
Unable to set hw params for playback: Invalid argument

--Boundary-00=_zPczAlIQnGXMPhK
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="test-alsa-4.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test-alsa-4.c"

#include <stdio.h>
#include <alsa/asoundlib.h>

void setparams(char *device, int dir_is_NULL, int dir_value);

int main() {
   printf("\nSettings params for 'hw:0,0', dir is NULL...\n");
   printf("********************************************\n\n");
   setparams("hw:0,0", 1, 0);
   printf("\nSettings params for 'plughw:0,0', dir is NULL...\n");
   printf("************************************************\n\n");
   setparams("plughw:0,0", 1, 0);
   printf("\nSettings params for 'hw:0,0', dir is pointer = 0...\n");
   printf("***************************************************\n\n");
   setparams("hw:0,0", 0, 0);
   printf("\nSettings params for 'plughw:0,0', dir is pointer = 0...\n");
   printf("*******************************************************\n\n");
   setparams("plughw:0,0", 0, 0);
   printf("\nSettings params for 'hw:0,0', dir is pointer = 1...\n");
   printf("***************************************************\n\n");
   setparams("hw:0,0", 0, 1);
   printf("\nSettings params for 'plughw:0,0', dir is pointer = 1...\n");
   printf("*******************************************************\n\n");
   setparams("plughw:0,0", 0, 1);
   return 0;
}

void setparams(char *device, int dir_is_NULL, int dir_value) {
   
   snd_pcm_t *handle;
   snd_pcm_hw_params_t *hwparams;
   snd_pcm_format_t format = SND_PCM_FORMAT_S16;
   unsigned int rate = 44100, rrate = 44100;
   unsigned int channels = 2;
   unsigned int buffer_time = 200000, rbuffer_time = 200000;      /* in us */
   unsigned int period_time = 100000, rperiod_time = 100000;      /* in us */
   int err, dir;
   snd_output_t *output;

   snd_pcm_hw_params_alloca(&hwparams);

   if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
      printf("Playback open error: %s\n", snd_strerror(err));
      exit(err);
   }

   err = snd_pcm_hw_params_any(handle, hwparams);
   if (err < 0) {
      printf("Broken configuration for playback: no configurations available: %s\n",
	     snd_strerror(err));
      exit(err);
   }
  
   err = snd_pcm_hw_params_set_access(handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED);
   if (err < 0) {
      printf("Access type not available for playback: %s\n", snd_strerror(err));
      exit(err);
   }

   err = snd_pcm_hw_params_set_format(handle, hwparams, format);
   if (err < 0) {
      printf("Sample format not available for playback: %s\n", snd_strerror(err));
      exit(err);
   }

   err = snd_pcm_hw_params_set_channels(handle, hwparams, channels);
   if (err < 0) {
      printf("Channels count (%i) not available for playbacks: %s\n", channels, snd_strerror(err));
      exit(err);
   }

   if(dir_is_NULL) {
      err = snd_pcm_hw_params_set_rate_near(handle, hwparams, &rrate, 0);
   } else {
      dir = dir_value;
      err = snd_pcm_hw_params_set_rate_near(handle, hwparams, &rrate, &dir);
   }   
   if (err < 0) {
      printf("Rate %iHz not available for playback: %s\n", rate, snd_strerror(err));
      exit(err);
   }
   if (rrate != rate) {
      printf("Rate doesn't match (requested %iHz, get %iHz)\n", rrate, rate);
   }

   dir = 0;
   err = snd_pcm_hw_params_set_buffer_time_near(handle, hwparams, &buffer_time, &dir);
   if (err < 0) {
      printf("Unable to set buffer time %i for playback: %s\n",
	     buffer_time, snd_strerror(err));
      exit(err);
   }
   if (rbuffer_time != buffer_time) {
      printf("Buffer time doesn't match (requested %ius, get %ius)\n",
	     rbuffer_time, buffer_time);
   }

   dir = 0;
   err = snd_pcm_hw_params_set_period_time_near(handle, hwparams, &period_time, &dir);
   if (err < 0) {
      printf("Unable to set period time %i for playback: %s\n",
	     period_time, snd_strerror(err));
      exit(err);
   }
   if (rperiod_time != period_time) {
      printf("Period time doesn't match (requested %ius, get %ius)\n",
	     rperiod_time, period_time);
   }
  
   snd_output_stdio_attach(&output, stdout, 0);
   printf("\nDump of hwparams\n");
   printf("----------------\n\n");
   snd_pcm_hw_params_dump(hwparams, output);

   err = snd_pcm_hw_params(handle, hwparams);
   if (err < 0) {
      printf("Unable to set hw params for playback: %s\n", snd_strerror(err));
      exit(err);
   }

   printf("\nDump of device setup\n");
   printf("--------------------\n\n");
   snd_pcm_dump_hw_setup(handle, output);

   fflush(stdout);

   snd_pcm_close(handle);

   return;
}

--Boundary-00=_zPczAlIQnGXMPhK--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
