From: Carlos Pita <cpitaar@yahoo.com.ar>
Subject: Re: a bug? (was: hw/plughw strange behaviour)
Date: Sun, 13 Jun 2004 23:33:23 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406132333.23830.cpitaar@yahoo.com.ar>
References: <20040610171635.95104.qmail@web50406.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z5QzAyKIIZmHuY8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040610171635.95104.qmail@web50406.mail.yahoo.com>
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


--Boundary-00=_z5QzAyKIIZmHuY8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Playing a little with the code that produced the strange behaviour I
reported in my previous posts in this thread I discovered this potential bug
(in my code or in alsalib?, that's the question):

1) In alsa/pcm.h, snd_pcm_hw_params_set_rate_near is declared as:

int snd_pcm_hw_params_set_rate_near(snd_pcm_t *pcm,
    				    snd_pcm_hw_params_t *params,
				    unsigned int *val,
				    int *dir);

(Here I'm not sure if dir is an output, an input or an inout param. Doxygen
doc is rather vague about this.)

2) When handle corresponds to the "hw:0,0" device any of the next
invocations work fine:

  a) dir is NULL:
     snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, 0);
  b) dir is an int = 0:
     snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, &dir);
  c) dir is an int = 1:
     snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, &dir);

3) But when handle corresponds to the "plughw:0,0" device the third
invocation fails (well, to be precise, it doesn't fail until
snd_pcm_hw_params is called -see my previous posts in this thread-).

4) I've attached an example test to this post which tries to
snd_pcm_hw_params using any of the following 6 combinations:

    device is         dir is         dir value is
  -------------------------------------------------
    hw:0,0            NULL               ?
    plughw:0,0        NULL               ?
    hw:0,0            a pointer          0
    plughw:0,0        a pointer          0
    hw:0,0            a pointer          1
    plughw:0,0        a pointer          1
    
The output of running it is:

Settings params for 'hw:0,0', dir is NULL...
Settings params for 'plughw:0,0', dir is NULL...
Settings params for 'hw:0,0', dir is pointer = 0...
Settings params for 'plughw:0,0', dir is pointer = 0...
Settings params for 'hw:0,0', dir is pointer = 1...
Settings params for 'plughw:0,0', dir is pointer = 1...
Buffer time doesn't match (requested 100000us, get 100022us)
Unable to set hw params for playback: Invalid argument

Just to be sure, I asked for 100022us of buffer. Then I didn't get
the buffer time mismatch, but still:

Settings params for 'hw:0,0', dir is NULL...
Settings params for 'plughw:0,0', dir is NULL...
Settings params for 'hw:0,0', dir is pointer = 0...
Settings params for 'plughw:0,0', dir is pointer = 0...
Settings params for 'hw:0,0', dir is pointer = 1...
Settings params for 'plughw:0,0', dir is pointer = 1...
Unable to set hw params for playback: Invalid argument

Thank you in advance.

Regards,
Carlos.


--Boundary-00=_z5QzAyKIIZmHuY8
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
   printf("Settings params for 'hw:0,0', dir is NULL...\n");
   setparams("hw:0,0", 1, 0);
   printf("Settings params for 'plughw:0,0', dir is NULL...\n");
   setparams("plughw:0,0", 1, 0);
   printf("Settings params for 'hw:0,0', dir is pointer = 0...\n");
   setparams("hw:0,0", 0, 0);
   printf("Settings params for 'plughw:0,0', dir is pointer = 0...\n");
   setparams("plughw:0,0", 0, 0);
   printf("Settings params for 'hw:0,0', dir is pointer = 1...\n");
   setparams("hw:0,0", 0, 1);
   printf("Settings params for 'plughw:0,0', dir is pointer = 1...\n");
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

   if (err < 0) {
      printf("Unable to set buffer time %i for playback: %s\n",
	     buffer_time, snd_strerror(err));
      exit(err);
   }
   if (rbuffer_time != buffer_time) {
      printf("Buffer time doesn't match (requested %ius, get %ius)\n",
	     rbuffer_time, buffer_time);
   }

   err = snd_pcm_hw_params_set_period_time_near(handle, hwparams, &period_time, &dir);
   if (err < 0) {
      printf("Unable to set period time %i for playback: %s\n",
	     period_time, snd_strerror(err));
      exit(err);
   }
   if (rperiod_time != period_time) {
      printf("Buffer time doesn't match (requested %ius, get %ius)\n",
	     rperiod_time, period_time);
   }
  
   err = snd_pcm_hw_params(handle, hwparams);
   if (err < 0) {
      printf("Unable to set hw params for playback: %s\n", snd_strerror(err));
      exit(err);
   }

   snd_pcm_close(handle);

   return;
}

--Boundary-00=_z5QzAyKIIZmHuY8--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
