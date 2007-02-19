From: tony mancill <tony@mancill.com>
Subject: Re: HDA Intel sound driver fails on Acer notebook -
 UPDATE, PROGRESS!
Date: Mon, 19 Feb 2007 08:51:55 -0800
Message-ID: <45D9D5AB.8020305@mancill.com>
References: <200612030233_MC3-1-D3BB-DE9@compuserve.com>
	<45788D2A.6070405@mancill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from dorf.mancill.com (dorf.mancill.com [207.162.210.177])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2C63179
	for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2007 17:53:17 +0100 (MET)
In-Reply-To: <45788D2A.6070405@mancill.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
List-Id: alsa-devel@alsa-project.org

There is some definite progress with the recent driver snapshots (since
1.0.14rc2).  Using alsa-driver-hg20070217.tar.bz2, amixer and
gnome-alsamixer both work, and after setting up xmms to use the software
mixer, it's working as well.

This is a big step forward - it's the first time I've been able to boot this
laptop and reliably have sound under Linux.  Up until now, it's been
hit-or-miss whether OSS emulation would emit sound, perhaps at a very low
level, etc., and none of the alsa tools worked at all.

To keep those interested from having to browse the thread, this is regarding
an Acer Aspire 5102 WMLi, with a Realtek ALC883, using the hda-intel driver.
 I'm using the stock Debian kernel that's currently in etch (2.6.18-3).

Many thanks to the ALSA developers!
tony

tony mancill wrote:
> FWIW, I'm having problems with this same laptop as well (i386).  Same
> number of interrupts in /proc/interrupts.  Interestingly, OSS output works
> (mostly), but all of the ALSA commands fail:
> 
> tony@maus:~$ amixer -d scontrols
> amixer: Mixer default load error: Invalid argument
> 
> tony@maus:~$ aplay ./test.wav
> ALSA lib confmisc.c:1105:(snd_func_refer) Unable to find definition
> 'defaults.pcm.dmix_format'
> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_refer
> returned error: No such file or directory
> ALSA lib conf.c:3957:(snd_config_expand) Args evaluate error: No such file
> or directory
> ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM dmix:0
> aplay: main:550: audio open error: No such file or directory
> 
> However, this is running 1.0.13.  I have yet to test with the 1.0.14rc1
> pre-packages that were posted earlier today.
> 
> 
> Chuck Ebbert wrote:
>> The HDA Intel sound driver still fails to load on my Acer Aspire 5102
>> notebook (Turion64 X2, ATI chipset):
>>
>> Here is the PCI info while running x86_64.  I tried i386 and x86_64 and it fails
>> on both:
>>
>> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
>>         Subsystem: Acer Incorporated [ALI] Unknown device 009f
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64, Cache Line Size 08
>>         Interrupt: pin ? routed to IRQ 16
>>         Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: [50] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>> 00: 02 10 7b 43 06 00 10 04 01 00 03 04 08 40 00 00
>> 10: 04 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 9f 00
>> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 00 00 00
>> 40: 00 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> On i386 I get this after doing
>>         insmod snd-hda-codec.ko ;  insmod snd-hda-intel.ko
>>
>> Dec  1 17:38:29 ac kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 18
>> Dec  1 17:38:29 ac kernel: codec_mask = 0xb
>> Dec  1 17:38:30 ac kernel: hda_codec: PCI 1025:9f, codec config 5 is selected
>> Dec  1 17:38:31 ac kernel: hda_intel: azx_get_response timeout, switching to polling mode...
>> Dec  1 17:38:32 ac kernel: hda_intel: azx_get_response timeout, switching to single_cmd mode...
>> Dec  1 17:38:32 ac kernel: hda-intel: get_response timeout: IRS=0x0
>> Dec  1 17:38:36 ac last message repeated 24618 times
>> Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
>> Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
>> Dec  1 17:38:36 ac kernel: hda-intel: get_response timeout: IRS=0x0
>> Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
>> Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
>> Dec  1 17:38:36 ac kernel: hda-intel: get_response timeout: IRS=0x0
>>
>> The last three lines repeat many thousands of times, followed by:
>>
>> Dec  1 17:38:39 ac kernel: hda_generic: no proper input path found
>> Dec  1 17:38:39 ac kernel: hda_generic: no proper output path found
>> Dec  1 17:38:39 ac kernel: hda_generic: no PCM found
>>
>> Looking at /proc/interrupts, I see exactly 110 interrupts were processed
>> by the driver while all this was happening:
>>
>>  18:          0        110   IO-APIC-fasteoi   HDA Intel
>>
>> On x86_64 I forgot to enable verbose messages, so there's less information
>> but it fails the same way.
>>
> 
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
