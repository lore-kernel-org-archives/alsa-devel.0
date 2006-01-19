From: David Vrabel <dvrabel@cantab.net>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
 approach
Date: Thu, 19 Jan 2006 19:13:24 +0000
Message-ID: <43CFE4D4.2020900@cantab.net>
References: <20060119174600.GT19398@stusta.de>	<1137694944.32195.1.camel@mindpipe>	<20060119182859.GW19398@stusta.de>	<1137696885.32195.12.camel@mindpipe> <s5hk6cw9h07.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rutherford.zen.co.uk (rutherford.zen.co.uk [212.23.3.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 009A715E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 20:13:40 +0100 (MET)
In-Reply-To: <s5hk6cw9h07.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 19 Jan 2006 13:54:45 -0500,
> Lee Revell wrote:
> 
>>On Thu, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
>>
>>>On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
>>>
>>>>On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
>>>>
>>>>>3. no ALSA drivers for the same hardware
>>>>>
>>>>>SOUND_SB 
>>>>
>>>>ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
>>>>ESS, Jazz16)", it would be a joke if it didn't...
>>>
>>>That's not the problem, I should have added an explanation:
>>>
>>>SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)
>>>
>>
>>Hmm.  From sound/oss/kahlua.c:
>>
>>/*
>> *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
>> *
>> *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
>> *
>>
>>Why was a new OSS driver written and accepted at such a late date, when
>>OSS was already deprecated?
> 
> 
> You'll find out that it must be pretty easy to write kahlua driver for
> ALSA, too, if you look at kahlua.c.  Just need a hardware to certify
> if this is really demanded...

Is this the audio on the Cyrix MediaGX (later National Semiconductor 
Geode GXm)?  I have access to hardware with that CPUs that I can test 
with if someone wants to write an ALSA driver. Er... though I'm not sure 
what VSA version the BIOS has.

I seem to recall that the Soundblaster 16 emulation provided by the VSA 
code worked fine so perhaps this can be dropped entirely.  I've not 
touched a MediaGX based board in many years so I may be remembering 
incorrectly.  The Soundblaster 16 emulation does work fine on AMD Geode 
GX1 boards.

David Vrabel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
