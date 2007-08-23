From: stan <stanl@cox.net>
Subject: Re: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 14:02:56 -0700
Message-ID: <46CDF600.6030509@cox.net>
References: <46CDD5A8.3000006@cox.net> <s5hlkc2yrax.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BB42224396
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 23:02:58 +0200 (CEST)
In-Reply-To: <s5hlkc2yrax.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 23 Aug 2007 11:44:56 -0700,
> stan wrote:
>   
>> Hi,
>>
>> I am unable to use plughw:0,0 as a device string while calling
>> err = snd_pcm_open (&alsa_dev, hw_from_default, SND_PCM_STREAM_PLAYBACK, 0);
>>
>> The same call works with hw_from_default == 'default', but fails when it 
>> is 'plughw:0,0'.
>> The error is
>> cannot open audio device "plughw:0,0" (Device or resource busy)
>>     
>
> Maybe the devce is really in use?
> Try "fuser /dev/snd/*"
>
>   
I don't think so.  Here is the output of fuser /dev/snd/*
/dev/snd/pcmC0D0p:    3069m
/dev/snd/timer:       3069

And I open default just before this in order to get its info so I can 
build the plughw.
Default device number (0)
Default subdevice number (0)
Default stream number (0)
Default card number (-1)
Default id (dmix:0,FORMAT=S32_LE)
Default name (dmix:0,FORMAT=S32_LE)
Default subname (dmix:0,FORMAT=S32_LE)
Default dev_class (0)
Default dev_subclass (0)
Default subdevices_count (1)
Default subdevices_avail (0)
Plughw  plughw:0,0  numchars 10
cannot open audio device "plughw:0,0" (Device or resource busy)

>> I am using the latest snapshot of alsa-lib, alsa-lib20070821.  I tried 
>> debugging but I cannot trace through the macros.  As near as I can tell 
>> there have been no changes to alsa.conf, and this worked just fine 
>> before the latest upgrade alsa package alsa-lib.1.0.14-3
>>
>> Is this a deliberate change in alsa that is known about, and is there a 
>> way to still get the functionality?
>>     
>
> The old library binary might still remain.  Some distros install
> libasound in /lib (or /lib64), instead of /usr/lib (or /usr/lib64).
>
>   
I'm changing  the links to point to the new library, and adding an alsa 
file in /etc/ld.so.conf.d/ so that the cache points to my library.  When 
I run ldd on the binary it points to the library I've compiled.
 ldd discord
        linux-gate.so.1 =>  (0x00110000)
        libm.so.6 => /lib/libm.so.6 (0x00939000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x0096b000)
*        libasound.so.2 => /usr/local/lib/alsa/libasound.so.2 (0x00111000)*
        libncurses.so.5 => /lib/libncurses.so.5 (0x06707000)
        libsndfile.so.1 => /usr/lib/libsndfile.so.1 (0x001f7000)
        libsamplerate.so.0 => /usr/lib/libsamplerate.so.0 (0x00257000)
        libc.so.6 => /lib/libc.so.6 (0x007e2000)
        /lib/ld-linux.so.2 (0x007c3000)
        libdl.so.2 => /lib/libdl.so.2 (0x00964000)
        libtinfo.so.5 => /lib/libtinfo.so.5 (0x066ed000)

> Takashi
>
>   
I can see it call snd_config_search_alias_hooks () in conf.c, but lose 
the debug in the macros, and it comes back from the macros with the 
negative error code.

Thanks for your help.
