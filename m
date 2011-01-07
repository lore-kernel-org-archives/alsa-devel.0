From: WH Bouterse <bill@bouterse.com>
Subject: Re: Alsa hda-analyzer and Lenovo G560
Date: Fri, 7 Jan 2011 18:04:00 -0500 (EST)
Message-ID: <25205422.22220.1294441440073.JavaMail.root@email.acmecargo.com>
References: <14144027.22218.1294441157622.JavaMail.root@email.acmecargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from email.acmecargo.com (mail.acmecargo.com [204.15.137.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B70B10382C
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 00:04:08 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by email.acmecargo.com (Postfix) with ESMTP id 911A39438002
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 18:04:05 -0500 (EST)
Received: from email.acmecargo.com ([127.0.0.1])
	by localhost (email.acmecargo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33vBZJo52oAR for <alsa-devel@alsa-project.org>;
	Fri,  7 Jan 2011 18:04:00 -0500 (EST)
Received: from email.acmecargo.com (email.acmecargo.com [204.15.137.68])
	by email.acmecargo.com (Postfix) with ESMTP id ABFF19438001
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 18:04:00 -0500 (EST)
In-Reply-To: <14144027.22218.1294441157622.JavaMail.root@email.acmecargo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Lenovo G560
Ubuntu 11.04 (kernel-2.6.37-11-generic)
Linux Mint 10 (kernel-2.6.35-24-generic)
Ubuntu Studio 10.10 

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 05)

hda-analyzer results

Text Dump
-------
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Device: name="CONEXANT Analog", type="Audio", device=0
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
  Amp-In vals: [0x50 0x50] [0x80 0x50] [0x50 0x50] [0x80 0x80]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
  Connection: 4
     0x17 0x18* 0x23 0x24
----------------


Diff for codec 0/1 (0x14f15069):
--- 
+++ 
@@ -51,26 +51,26 @@
     ControlAmp: chs=1, dir=1, idx=0, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=1, idx=0, ofs=0
   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0f, mute=0
   Amp-Out vals: 0x00
 Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
   Device: name="CONEXANT Analog", type="Audio", device=0
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
-  Amp-In vals: [0x50 0x50] [0x80 0x80] [0x50 0x50] [0x80 0x80]
+  Amp-In vals: [0x50 0x50] [0x80 0x50] [0x50 0x50] [0x80 0x80]
   Converter: stream=1, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
   Connection: 4
-     0x17 0x18 0x23* 0x24
+     0x17 0x18* 0x23 0x24
 Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals: [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 2

For my paticular machine the Lenovo G560
The muted "value 3" under Input Amplifier is the key for activation of internal mic.

The ongoing issue of having to reset this each reboot still remains for me ,however;
Latest poitive results from another g560 tester.
He had sent info to alsa-dev recently;
----
kayno wrote on 2010-12-18: 	#46

"I have emailed the alsa-devel mailing list with the hda_analyzer diff and and the output of alsa-info.sh. not sure what they will do, but the hda_analyzer tool's about button said to do that."
https://bugs.launchpad.net/ubuntu/+source/linux-backports-modules-2.6.32/+bug/590756
------
However most recently He has replied to the list;
---------
"looks like this has been fixed in newer versions of alsa - i downloaded
this version: http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa
/alsa-driver/alsa-driver-20101221.tar.gz and compiled and installed
(./configure; make; make install) and now my mic works all the time,
even after a reboot."

http://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg2685418.html
----------

So hopefully this will be functioning soon for those non-programmers like myself !
Thanks to all those unsung heroes of the open-source movement in general and
specifically those working with ALSA.

WHBouterse
