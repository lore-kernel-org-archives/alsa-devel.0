From: Daniel Cardenas <Daniel.Car@cox.net>
Subject: Re: Looking for help with dmix plug-in on ARM
Date: Fri, 02 Mar 2007 20:54:36 -0700
Message-ID: <45E8F17C.9070405@cox.net>
References: <15711510.1170960250793.JavaMail.root@fed1wml07.mgt.cox.net>	<s5hps8jo7qo.wl%tiwai@suse.de>
	<45E2EAF8.9050303@cox.net> <45E4A1B2.2070207@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45E4A1B2.2070207@cox.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Problem resolved.  In the poll buffer thread which emulates the hardware interrupt it was tracking the application 
pointer (appl_ptr).  When I switched to looking at the hw_ptr things worked with dmix.

Daniel

Daniel Cardenas wrote:
> Results of my latest debug: dmix is reporting an error in routine 
> snd_pcm_dmix_sync_ptr() complaining that the pipe is
> in the running state.  Here is a snippet of code:
> 
> Daniel Cardenas wrote:
>> Takashi Iwai wrote:
>>> At Thu, 8 Feb 2007 10:44:10 -0800,
>>> <daniel.car@cox.net> wrote:
>>>> Hi,
>>>>
>>>> I'm working on an unannounced SOC audio driver on an ARM system.
>>>> I have a problem were audio works fine with out dmix, but when I try 
>>>> to use dmix, no audio data gets to the driver.
>>>> The dmix plug-in does work when attaching external usb audio 
>>>> device.  Trying to use dmix so that more then one application can 
>>>> generate audio simultaneously.
>>>>
>>>> If I try with version 1.0.11 of ALSA the audio driver doesn't 
>>>> receive any data after the snd_pcm_period_elapsed() function call.
>>
>> Actually it is before or after.
>>
>>>
>>> So, actually it's a problem of driver / alsa-lib hw layer rather than
>>> dmix?  You can get more verbose messages by setting LIBASOUND_DEBUG
>>> variable.  See alsa-lib/NOTES for details.
>>
>> I set the environment variable and I did not see additional output.  
>> For version
>>
>>
>>>
>>>> Here is how the driver is set up:
>>>> static snd_pcm_hardware_t snd_oloriver_playback_hw = {
>>>>  .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
>>>>        SNDRV_PCM_INFO_MMAP_VALID),
>>>>  .formats         = SNDRV_PCM_FMTBIT_S16_LE,
>>>>   .rates         = SNDRV_PCM_RATE_48000,
>>>>   .rate_min        = 48000,   .rate_max        = 48000,
>>>>   .channels_min     = 2,
>>>>   .channels_max     = 2,
>>>>   .buffer_bytes_max = 65536,
>>>>   .period_bytes_min = 32768,
>>>>   .period_bytes_max = 32768,
>>>>   .periods_min         = 2,
>>>>   .periods_max         = 2,
>>>
>>> My rough guess is that the buffer and period size constraints are too
>>> restrictive.  You can try to pass the exact period/buffer sizes to
>>> aplay via --period-size=8192 --buffer-size=16384 options.
>>>
>>> Takashi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
