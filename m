From: Daniel Cardenas <Daniel.Car@cox.net>
Subject: Re: Looking for help with dmix plug-in on ARM
Date: Mon, 26 Feb 2007 07:13:12 -0700
Message-ID: <45E2EAF8.9050303@cox.net>
References: <15711510.1170960250793.JavaMail.root@fed1wml07.mgt.cox.net>
	<s5hps8jo7qo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hps8jo7qo.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 8 Feb 2007 10:44:10 -0800,
> <daniel.car@cox.net> wrote:
>> Hi,
>>
>> I'm working on an unannounced SOC audio driver on an ARM system.
>> I have a problem were audio works fine with out dmix, but when I try to use 
>> dmix, no audio data gets to the driver.
>> The dmix plug-in does work when attaching external usb audio device.  Trying 
>> to use dmix so that more then one application can generate audio simultaneously.
>>
>> If I try with version 1.0.11 of ALSA the audio driver doesn't receive any data after the snd_pcm_period_elapsed() function call.

Actually it is before or after.

>> If I try with version 1.0.13 of ALSA, aplay returns an error saying:
>> # aplay -D hw:0,0 pcm48khz_2ch_stereo.wav open_stream success
>>   Playing WAVE 'pcm48khz_2ch_stereo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>>   aplay: set_params:882: Broken configuration for this PCM: no configurations available
>>
>> I'm planning on building a debug version of 1.0.14rc2 and tracing thru the code to see why aplay fails.
>> Is there a better way to debug this?  Are there any tricks for building ALSA with debug info?
> 
> So, actually it's a problem of driver / alsa-lib hw layer rather than
> dmix?  You can get more verbose messages by setting LIBASOUND_DEBUG
> variable.  See alsa-lib/NOTES for details.

I set the environment variable and I did not see additional output.  For version
1.0.13 of the libraries I believe I have a build/install issue that I'm still
investigating.  In the routine
int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
{
       struct snd_pcm_runtime *runtime = substream->runtime;
       struct snd_pcm_hardware *hw = &runtime->hw;
       int err;
       unsigned int mask = 0;

         if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
             mask |= 1 << SNDRV_PCM_ACCESS_RW_INTERLEAVED;
         if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
             mask |= 1 << SNDRV_PCM_ACCESS_RW_NONINTERLEAVED;
       if (hw->info & SNDRV_PCM_INFO_MMAP) {
             if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
                   mask |= 1 << SNDRV_PCM_ACCESS_MMAP_INTERLEAVED;
             if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
                   mask |= 1 << SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED;
             if (hw->info & SNDRV_PCM_INFO_COMPLEX)
                   mask |= 1 << SNDRV_PCM_ACCESS_MMAP_COMPLEX;
       }

       err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_ACCESS, mask);
       snd_assert(err >= 0, return -EINVAL);

hw->info and mask are zero which causes an error.

Switching back to version 1.0.11 I have put in various debug statements in the pcm
layer and dmix.  What I find is that buffer boundary seems incorrectly high:

~ # aplay content/pcm48khz_2ch_stereo.wav
pcm_dmix.c 874: first_instance 1
pcm.c 913, boundary 40000000
pcm.c 5310, boundary 40000000
pcm.c 913, boundary 40000000
pcm_dmix.c 937
Playing WAVE 'content/pcm48khz_2ch_stereo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
pcm.c 913, boundary 40000000
pcm.c 913, boundary 40000000
pcm.c 913, boundary 40000000
pcm_dmix.c 483
pcm_direct.c 1177
pcm.c 5310, boundary 40000000
pcm.c 913, boundary 40000000
pcm.c 913, boundary 40000000
pcm_local.h 305: avail 4000, *pcm->hw.ptr 0, pcm->buffer_size 4000, *pcm->appl.ptr 0, boundary 40000000
pcm_mmap.c 114: offset 0, size 2000
pcm_local.h 305: avail 4000, *pcm->hw.ptr 0, pcm->buffer_size 4000, *pcm->appl.ptr 0, boundary 40000000
pcm_local.h 305: avail 4000, *pcm->hw.ptr 0, pcm->buffer_size 4000, *pcm->appl.ptr 0, boundary 40000000
pcm_local.h 305: avail 4000, *pcm->hw.ptr 0, pcm->buffer_size 4000, *pcm->appl.ptr 0, boundary 40000000
pcm_dmix.c 688: size 2000 state 2
pcm_mmap.c 78: appl_ptr 0, frames 2000


Apologizes for using my personal flavor of debug messages.  I'm still getting use to ALSA code.

So is it obvious that the boundary is not what it should be?  Suggestions and or pointers?

> 
>> Here is how the driver is set up:
>> static snd_pcm_hardware_t snd_oloriver_playback_hw = {
>>  .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
>> 	   SNDRV_PCM_INFO_MMAP_VALID),
>>  .formats 	    = SNDRV_PCM_FMTBIT_S16_LE,
>>   .rates 	    = SNDRV_PCM_RATE_48000,
>>   .rate_min	    = 48000, 
>>   .rate_max	    = 48000,
>>   .channels_min     = 2,
>>   .channels_max     = 2,
>>   .buffer_bytes_max = 65536,
>>   .period_bytes_min = 32768,
>>   .period_bytes_max = 32768,
>>   .periods_min 	    = 2,
>>   .periods_max 	    = 2,
> 
> My rough guess is that the buffer and period size constraints are too
> restrictive.  You can try to pass the exact period/buffer sizes to
> aplay via --period-size=8192 --buffer-size=16384 options.
> 
> Takashi

Thanks!
Daniel




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
