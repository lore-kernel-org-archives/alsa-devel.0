From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: intel8x0 with ICH5 and ALC650 multichannel problems.
Date: Mon, 25 Aug 2003 16:00:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4A2486.9040001@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a Motherboard with the ICH5 and ALC650 so I use the intel8x0 alsa 
kernel driver. (Currently the version from 2.6.0-test4.)
I have managed to get SPDIF passthru working. (I posted the patch some 
time ago, and it is now in 2.6.0-test4)
I cannot get multichannel working.
The motherboard has 5 audio jacks. mic, line-in, front, rear, center-lfe.
If I output just 2 channels, the sound comes out perfectly from the 
"front" jack.
If I output in 4 or 6 channels, the sound fails on all channels.
Sometime I hear a short burst of sound on the front channel, but hardly 
ever.
I am pretty sure that this is a buffer/period size problem.
My application has code is (see below)
Which function in intel8x0.c interacts with the buffer and period sizes?
The "snd_pcm_hw_params_set_buffer_time_near" gets full buffer_time for 
stereo, but for 6 channels it does not, and has to reduce the buffer 
size to some limits determined by the hardware. I think it is this 
"limiting/contraint" code that is not working correctly.
Can anyone provide me with pointers so that I could fix this bug ?

Cheers
James


/* set the ring-buffer time [us] (large enough for x us|y samples ...) */
   dir=0;
   err = snd_pcm_hw_params_set_buffer_time_near(this->audio_fd, params, 
&buffer_time, &dir); /* buffer_time before call = 1000000 */
   if (err < 0) {
     printf ("audio_alsa_out: buffer time not available\n");
     goto __close;
   }
   printf ("audio_alsa_out: Got %d buffer_time, wanted 
%d\n",buffer_time, BUFFER_TIME);
   err = snd_pcm_hw_params_get_buffer_size(params, &(this->buffer_size));
   /* set the period time [us] (interrupt every x us|y samples ...) */
   dir=0;
   period_size=this->buffer_size/8;
   err = snd_pcm_hw_params_set_period_size_near(this->audio_fd, params, 
&period_size, &dir);
   if (err < 0) {
     printf ("audio_alsa_out: period time not available");
     goto __close;
   }
   dir=0;
   err = snd_pcm_hw_params_get_period_size(params, &period_size, &dir);
   if (2*period_size > this->buffer_size) {
     printf ("audio_alsa_out: buffer to small, could not use. 
period_size=%ld, buffer_size=%ld\n", period_size, this->buffer_s
ize);
     goto __close;
   }




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
