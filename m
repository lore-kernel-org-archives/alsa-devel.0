From: "Peter Carlsson" <peter.carlsson@space.se>
Subject: Re: S/PDIF support for Intel HDA Realtek ALC880?
Date: Wed, 15 Nov 2006 08:45:56 +0100
Message-ID: <D0623A7E119D564AA1966968BC37AE29C32B84@srvsegbg19.space.se>
References: <1163574379.21193.191.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <1163574379.21193.191.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Peter Carlsson <peter.carlsson@space.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Tobin!

Could you please tell me where to put the "model=6stack-digout" option?
On a Debian system I believe it is the /etc/init.d/alsasound script that
takes care of starting/stopping the sound drivers.

htpc:/home/mythtv# head -n 4 /etc/init.d/alsasound 
#!/bin/bash
#
# alsasound     This shell script takes care of starting and stopping
#               the ALSA sound driver.

htpc:/home/mythtv# lspci 
...
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio
(rev a2)
...

htpc:/home/mythtv# lspci -s 00:10 -vn
00:10.0 0604: 10de:026f (rev a2) (prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e9000000-e90fffff
	Prefetchable memory behind bridge: e0000000-e3ffffff
	Capabilities: [b8] Subsystem: 0000:0000
	Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 0403: 10de:026c (rev a2)
	Subsystem: 1458:a102
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
	Memory at e9100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/0 Enable-
	Capabilities: [6c] HyperTransport: MSI Mapping

htpc:/home/mythtv# 

Thanks for the help!

Best regards,
Peter Carlsson

>-----Original Message-----
>From: Tobin Davis [mailto:tdavis@dsl-only.net] 
>Sent: Wednesday, November 15, 2006 8:06 AM
>To: Peter Carlsson
>Cc: alsa-devel@lists.sourceforge.net
>Subject: Re: [Alsa-devel] S/PDIF support for Intel HDA Realtek ALC880?
>
>It's possible that your board has been incorrectly configured as a 6
>stack w/o spdif.  Here's a simple experiment:  Try loading the sound
>drivers with "model=6stack-digout".  If that fixes the SPDIF output,
>then great.
>
>Also, to verify that your board is supported, could you submit the pci
>subsystem ID?  Use lspci to determine what device the 
>soundcard is, then
>lspci -s <pci-id> -vn (where <pci-id> would be the pci device id, i.e.
>0:1b).
>
>Tobin
>
>On Wed, 2006-11-15 at 06:58 +0100, Peter Carlsson wrote:
>> >Hi Peter
>> 
>> Hello Jonathan!
>> 
>> Thanks for the quick response.
>> 
>> >> I am running Debian (testing) on a Gigabyte GA-K8N51PVMT-9
>> >> motherboard with integrated Intel HDA Realtek ALC880 sound.
>> >
>> >I don't have ALC880 hardware - all my work has been done with 
>> >the ALC260.
>> >My ability to answer your question is therefore somewhat diminished.
>> >
>> >> htpc:~# aplay -l
>> >> **** List of PLAYBACK Hardware Devices ****
>> >> card 0: NVidia [HDA NVidia], device 0: ALC880 Analog 
>[ALC880 Analog]
>> >>    Subdevices: 1/1
>> >>    Subdevice #0: subdevice #0
>> >
>> >This suggests there is only one playback device, and that 
>would be the
>> >analog interface.  Therefore by default at least it doesn't 
>appear the
>> >SPDIF interface is made available.
>> >
>> >Are you using any options when loading the ALSA modules or 
>do you just
>> >go with the defaults?
>> 
>> No options and I am using a regular kernel. Any suggestions
>> what options I might add?
>> 
>> mythtv@htpc:~$ uname -a
>> Linux htpc 2.6.16-2-k7 #1 Fri Aug 18 19:48:42 UTC 2006 i686 GNU/Linux
>> 
>> mythtv@htpc:~$ dpkg --list alsa-*
>> Desired=Unknown/Install/Remove/Purge/Hold
>> |
>> 
>Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
>> |/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
>> uppercase=bad)
>> ||/ Name               Version            Description
>> 
>+++-==================-==================-=====================
>=========
>> ======================
>> ii  alsa-base          1.0.13-1           ALSA driver configuration
>> files
>> ii  alsa-oss           1.0.12-1           ALSA wrapper for OSS
>> applications
>> ii  alsa-utils         1.0.13-1           ALSA utilities
>> 
>> >I'll forward your email onto the ALSA developers mailing 
>list for wider
>> >viewing.  That way you may get some thoughts from the 
>> >developers actually working on ALC880 code.
>> 
>> Best regards,
>> Peter Carlsson
>> 
>> 
>---------------------------------------------------------------
>----------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the 
>chance to share your
>> opinions on IT & business topics through brief surveys - and 
>earn cash
>> 
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&
>CID=DEVDEV
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>-- 
>Tobin Davis <tdavis@dsl-only.net>
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
