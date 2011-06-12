From: Donn Washburn <n5xwb@comcast.net>
Subject: snd_hda_intel
Date: Sat, 11 Jun 2011 21:10:19 -0500
Message-ID: <4DF4200B.90608@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmta10.westchester.pa.mail.comcast.net
	(qmta10.westchester.pa.mail.comcast.net [76.96.62.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FE2B244A5
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jun 2011 04:10:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Developer elist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Alsa;

This MB is a ASUS M4A87TD and a VIA VT1818 High Definition Audio 8 
channel CODEC which supports192Khz and 24bit BD Lossless Sound

I have a problem with a new motherboard and openSuSE's 11.4 version of 
alsa (alsa-1.0.24.1-3.1.x86_64).  The sound is very good however, all of 
the mixers may be the problem.  The problem is that the pots of a mixer 
are all coming up incorrect.  Like the Line In is showing up as Mic 1 
and Master does work at all.

I am including the output of hwinfo --sound to show modules are mount
19: PCI 14.2: 0403 Audio device
   [Created at pci.318]
   Unique ID: 5Dex.BDUuYMOWyw7
   SysFS ID: /devices/pci0000:00/0000:00:14.2
   SysFS BusID: 0000:00:14.2
   Hardware Class: sound
   Model: "ATI SBx00 Azalia (Intel HDA)"
   Vendor: pci 0x1002 "ATI Technologies Inc"
   Device: pci 0x4383 "SBx00 Azalia (Intel HDA)"
   SubVendor: pci 0x1002 "ATI Technologies Inc"
   SubDevice: pci 0x4383
   Revision: 0x40
   Driver: "HDA Intel"
   Driver Modules: "snd_hda_intel"
   Memory Range: 0xfcef4000-0xfcef7fff (rw,non-prefetchable)
   IRQ: 16 (9521 events)
   Module Alias: "pci:v00001002d00004383sv00001002sd00004383bc04sc03i00"
   Driver Info #0:
     Driver Status: snd_hda_intel is active
     Driver Activation Cmd: "modprobe snd_hda_intel"
   Config Status: cfg=yes, avail=yes, need=no, active=unknown

32: PCI 500.1: 0403 Audio device
   [Created at pci.318]
   Unique ID: 5yAR.MFsh1X_ykN2
   Parent ID: _Znp.ZJmKoWxd6BF
   SysFS ID: /devices/pci0000:00/0000:00:02.0/0000:05:00.1
   SysFS BusID: 0000:05:00.1
   Hardware Class: sound
   Model: "nVidia Audio device"
   Vendor: pci 0x10de "nVidia Corporation"
   Device: pci 0x0bea
   SubVendor: pci 0x3842 "eVga.com. Corp."
   SubDevice: pci 0x1441
   Revision: 0xa1
   Driver: "HDA Intel" 

   Driver Modules: "snd_hda_intel"
   Memory Range: 0xfe97c000-0xfe97ffff (rw,non-prefetchable) 

   IRQ: 19 (211 events) 

   Module Alias: "pci:v000010DEd00000BEAsv00003842sd00001441bc04sc03i00" 

   Driver Info #0: 

     Driver Status: snd_hda_intel is active 

     Driver Activation Cmd: "modprobe snd_hda_intel" 

   Config Status: cfg=yes, avail=yes, need=no, active=unknown 

   Attached to: #9 (PCI bridge)


Sorry about the length of this sound file
I do hope this may offer an idea.  Is there a better module to try.
Or is this all a KDE Kmix (one pot only) or gmixer (about 5 pots) problem.

Please advise!
-- 
73 de Donn Washburn
307 Savoy Street    Email:" n5xwb@comcast.net "
Sugar Land, TX 77478 LL# 1.281.242.3256
Ham Callsign N5XWB   HAMs : " n5xwb@arrl.net "
VoIP via Skype:n5xwbg  BMWMOA #:4146 Ambassador
       " http://counter.li.org " #279316
