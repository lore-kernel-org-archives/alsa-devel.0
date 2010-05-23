From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 100/199] Documentation/sound/oss/README.OSS: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:50 +0200
Message-ID: <1274644376-24176-8-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/README.OSS:25: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:87: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:108: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:158: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:159: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:190: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:201: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:234: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:236: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:266: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:277: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:284: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:312: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:322: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:323: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:380: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:467: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:468: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:473: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:487: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:488: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:515: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:546: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:559: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:571: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:612: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:618: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:632: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:645: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:647: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:685: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:701: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:702: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:725: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:766: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:798: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:803: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:819: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:825: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:836: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:843: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:922: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:952: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:959: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:963: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:984: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1062: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1071: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1095: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1139: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1248: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1255: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1261: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1262: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1363: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1373: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1376: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1382: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1390: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1391: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1414: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1415: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1417: ERROR: trailing whitespace
Documentation/sound/oss/README.OSS:1419: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/README.OSS |  128 ++++++++++++++++++------------------
 1 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/Documentation/sound/oss/README.OSS b/Documentation/sound/oss/README.OSS
index fd42b05..e56a64a 100644
--- a/Documentation/sound/oss/README.OSS
+++ b/Documentation/sound/oss/README.OSS
@@ -22,7 +22,7 @@ document can be still interesting and very helpful.
 OSS/Free version 3.8 release notes
 ----------------------------------
 
-Please read the SOUND-HOWTO (available from sunsite.unc.edu and other Linux FTP 
+Please read the SOUND-HOWTO (available from sunsite.unc.edu and other Linux FTP
 sites). It gives instructions about using sound with Linux. It's bit out of
 date but still very useful. Information about bug fixes and such things
 is available from the web page (see above).
@@ -84,7 +84,7 @@ contributors. (I could have forgotten some names.)
 	James Hightower Spotting a tiny but important bug in CS423x support.
 	Denis Sablic	OPTi 82C924 specific enhancements (non PnP mode)
 	Tim MacKenzie	Full duplex support for OPTi 82C930.
-	
+
 	Please look at lowlevel/README for more contributors.
 
 There are probably many other names missing. If you have sent me some
@@ -105,7 +105,7 @@ sending me patches relative to production kernels.
 Sponsors etc.
 -------------
 
-The following companies have greatly helped development of this driver 
+The following companies have greatly helped development of this driver
 in form of a free copy of their product:
 
 Novell, Inc.		UnixWare personal edition + SDK
@@ -155,8 +155,8 @@ The following errors are likely with /dev/dsp and /dev/audio.
 	device file or the sound driver has been compiled without support for
 	this particular device. For example /dev/audio and /dev/dsp will not
 	work if "digitized voice support" was not enabled during "make config".
-	
-	- "Device or resource busy". Probably the IRQ (or DMA) channel 
+
+	- "Device or resource busy". Probably the IRQ (or DMA) channel
 	required by the sound card is in use by some other device/driver.
 
 	- "I/O error". Almost certainly (99%) it's an IRQ or DMA conflict.
@@ -187,7 +187,7 @@ IMPORTANT!	Read this if you are installing a separately
   sources). Remove old version of linux/drivers/sound directory before
   installing new files.
 
-- To build the device files you need to run the enclosed shell script 
+- To build the device files you need to run the enclosed shell script
   (see below). You need to do this only when installing sound driver
   first time or when upgrading to much recent version than the earlier
   one.
@@ -198,7 +198,7 @@ IMPORTANT!	Read this if you are installing a separately
   contains card specific instructions for configuring this driver for
   use with various sound cards.
 
-Boot time configuration (using lilo and insmod) 
+Boot time configuration (using lilo and insmod)
 -----------------------------------------------
 
 This information has been removed. Too many users didn't believe
@@ -231,9 +231,9 @@ Configuring version 3.8 (for Linux) with some common sound cards
 
 This document describes configuring sound cards with the freeware version of
 Open Sound Systems (OSS/Free). Information about the commercial version
-(OSS/Linux) and its configuration is available from 
+(OSS/Linux) and its configuration is available from
 http://www.opensound.com/linux.html. Information presented here is
-not valid for OSS/Linux. 
+not valid for OSS/Linux.
 
 If you are unsure about how to configure OSS/Free
 you can download the free evaluation version of OSS/Linux from the above
@@ -263,7 +263,7 @@ Sound Blaster. Only the cards made by Creative Technology or which have
 one or more chips labeled by Creative are SB compatible. In addition there
 are few sound chipsets which are SB compatible in Linux such as ESS1688 or
 Jazz16. Note that SB compatibility in DOS/Windows does _NOT_ mean anything
-in Linux. 
+in Linux.
 
 IF YOU REALLY ARE 150% SURE YOU HAVE A SOUND BLASTER YOU CAN SKIP THE REST OF
 THIS CHAPTER.
@@ -274,14 +274,14 @@ in SB mode but in general it's a complete waste of time. There are several
 problems which you will encounter by using SB mode with cards that are not
 truly SB compatible:
 
-- The SB emulation is at most SB Pro (DSP version 3.x) which means that 
+- The SB emulation is at most SB Pro (DSP version 3.x) which means that
 you get only 8 bit audio (there is always an another ("native") mode which
 gives the 16 bit capability). The 8 bit only operation is the reason why
 many users claim that sound quality in Linux is much worse than in DOS.
 In addition some applications require 16 bit mode and they produce just
 noise with a 8 bit only device.
 - The card may work only in some cases but refuse to work most of the
-time. The SB compatible mode always requires special initialization which is 
+time. The SB compatible mode always requires special initialization which is
 done by the DOS/Windows drivers. This kind of cards work in Linux after
 you have warm booted it after DOS but they don't work after cold boot
 (power on or reset).
@@ -309,7 +309,7 @@ appended to it (sometimes not). This causes major confusion since the non-PnP
 model works with Linux but the PnP one doesn't.
 
 You should carefully check if "Plug & Play" or "PnP" is mentioned in the name
-of the card or in the documentation or package that came with the card. 
+of the card or in the documentation or package that came with the card.
 Everything described in the rest of this document is not necessarily valid for
 PnP models of sound cards even you have managed to wake up the card properly.
 Many PnP cards are simply too different from their non-PnP ancestors which are
@@ -319,8 +319,8 @@ covered by this document.
 Cards that are not (fully) supported by this driver
 ===================================================
 
-See http://www.opensound.com/ossfree for information about sound cards 
-to be supported in future. 
+See http://www.opensound.com/ossfree for information about sound cards
+to be supported in future.
 
 
 How to use sound without recompiling kernel and/or sound driver
@@ -377,7 +377,7 @@ versions of isapnptools so at least version 1.6 is required with sound cards.
 
 Yet another way to use PnP cards is to use (commercial) OSS/Linux drivers.  See
 http://www.opensound.com/linux.html for more info. This is probably the way you
-should do it if you don't want to spend time recompiling the kernel and 
+should do it if you don't want to spend time recompiling the kernel and
 required tools.
 
 
@@ -464,13 +464,13 @@ MPU-401	and compatibles
 	in the list of supported cards before enabling MPU401.
 
 Windows Sound System (MSS/WSS)
-	Even when Microsoft has discontinued their own Sound System card 
-	they managed to make it a standard. MSS compatible cards are based on 
+	Even when Microsoft has discontinued their own Sound System card
+	they managed to make it a standard. MSS compatible cards are based on
 	a codec chip which is easily available from at least two manufacturers
 	(AD1848 by Analog Devices and CS4231/CS4248 by Crystal Semiconductor).
 	Currently most sound cards are based on one of the MSS compatible codec
 	chips. The CS4231 is used in the high quality cards such as GUS MAX,
-	MediaTrix AudioTrix Pro and TB Tropez (GUS MAX is not MSS compatible). 
+	MediaTrix AudioTrix Pro and TB Tropez (GUS MAX is not MSS compatible).
 
 	Having a AD1848, CS4248 or CS4231 codec chip on the card is a good
 	sign. Even if the card is not MSS compatible, it could be easy to write
@@ -484,8 +484,8 @@ Windows Sound System (MSS/WSS)
 Yamaha FM synthesizers (OPL2, OPL3 (not OPL3-SA) and OPL4)
 	Most sound cards have a FM synthesizer chip. The OPL2 is a 2
 	operator chip used in the original AdLib card. Currently it's used
-	only in the cheapest (8 bit mono) cards. The OPL3 is a 4 operator 
-	FM chip which provides better sound quality and/or more available 
+	only in the cheapest (8 bit mono) cards. The OPL3 is a 4 operator
+	FM chip which provides better sound quality and/or more available
 	voices than the OPL2. The OPL4 is a new chip that has an OPL3 and
 	a wave table synthesizer packed onto the same chip. The driver supports
 	just the OPL3 mode directly. Most cards with an OPL4 (like
@@ -512,7 +512,7 @@ Yamaha OPL3-SA1
 	(not used in OSS/Free) in addition to the OPL3 FM synth.
 
 	There are also chips called OPL3-SA2, OPL3-SA3, ..., OPL3SA-N. They
-	are PnP chips and will not work with the OPL3-SA1 driver. You should 
+	are PnP chips and will not work with the OPL3-SA1 driver. You should
 	use the standard MSS, MPU401 and OPL3 options with these chips and to
 	activate the card using isapnptools.
 
@@ -543,7 +543,7 @@ Yamaha OPL3-SA1
 	SoftOSS keeps the samples loaded on the system's RAM so much RAM is
 	required. SoftOSS should never be used on machines with less than 16 MB
 	of RAM since this is potentially dangerous (you may accidentally run out
-	of memory which probably crashes the machine). 
+	of memory which probably crashes the machine).
 
 	SoftOSS implements the wave table API originally designed for GUS. For
 	this reason all applications designed for GUS should work (at least
@@ -556,7 +556,7 @@ Yamaha OPL3-SA1
 	sites.
 
         *********************************************************************
-	IMPORTANT NOTICE! The original patch set distributed with the Gravis 
+	IMPORTANT NOTICE! The original patch set distributed with the Gravis
 	Ultrasound card is not in public domain (even though it's available from
 	some FTP sites). You should contact Voice Crystal (www.voicecrystal.com)
 	if you like to use these patches with SoftOSS included in OSS/Free.
@@ -568,7 +568,7 @@ PSS based cards (AD1848 + ADSP-2115 + Echo ESC614 ASIC)
 	for emulation of SB Pro, FM and General MIDI/MT32.
 
 	There are several cards based on this architecture. The most known
-	ones are Orchid SW32 and Cardinal DSP16. 
+	ones are Orchid SW32 and Cardinal DSP16.
 
 	The driver supports downloading DSP algorithms to these cards.
 
@@ -609,13 +609,13 @@ OPTi MAD16 and Mozart based cards
 	(without need to use isapnptools or DOS to initialize it). All OPTi
 	chips are supported by OSS/Linux (both in PnP and non-PnP modes).
 
-Audio Excel DSP16 
+Audio Excel DSP16
 	Support for this card was written by Riccardo Faccetti
 	(riccardo@cdc8g5.cdc.polimi.it). The AEDSP16 driver included in
 	the lowlevel/ directory. To use it you should enable the
 	"Additional low level drivers" option.
 
-Crystal CS4232 and CS4236 based cards such as AcerMagic S23, TB Tropez _Plus_ and 
+Crystal CS4232 and CS4236 based cards such as AcerMagic S23, TB Tropez _Plus_ and
 	many PC motherboards (Compaq, HP, Intel, ...)
 	CS4232 is a PnP multimedia chip which contains a CS3231A codec,
 	SB and MPU401 emulations. There is support for OPL3 too.
@@ -629,7 +629,7 @@ Crystal CS4232 and CS4236 based cards such as AcerMagic S23, TB Tropez _Plus_ an
 
 Turtle Beach Maui and Tropez "classic"
 	This driver version supports sample, patch and program loading commands
-	described in the Maui/Tropez User's manual. 
+	described in the Maui/Tropez User's manual.
 	There is now full initialization support too. The audio side of
 	the Tropez is based on the MAD16 chip (see above).
 	NOTE! Tropez Plus is different card than Tropez "classic" and will not
@@ -642,9 +642,9 @@ Jumpers and software configuration
 
 Some of the earliest sound cards were jumper configurable. You have to
 configure the driver use I/O, IRQ and DMA settings
-that match the jumpers. Just few 8 bit cards are fully jumper 
+that match the jumpers. Just few 8 bit cards are fully jumper
 configurable (SB 1.x/2.x, SB Pro and clones).
-Some cards made by Aztech have an EEPROM which contains the 
+Some cards made by Aztech have an EEPROM which contains the
 config info. These cards behave much like hardware jumpered cards.
 
 Most cards have jumper for the base I/O address but other parameters
@@ -682,7 +682,7 @@ listed above. Also look at the end of this file for list of unsupported
 cards and the ones which could be supported later.
 
 The last resort is to send _exact_ name and model information of the card
-to me together with a list of the major IC chips (manufactured, model) to 
+to me together with a list of the major IC chips (manufactured, model) to
 me. I could then try to check if your card looks like something familiar.
 
 There are many more cards in the world than listed above. The first thing to
@@ -698,8 +698,8 @@ should work OK.
 Configuring sound driver (with Linux)
 =====================================
 
-The sound driver is currently distributed as part of the Linux kernel. The 
-files are in /usr/src/linux/drivers/sound/. 
+The sound driver is currently distributed as part of the Linux kernel. The
+files are in /usr/src/linux/drivers/sound/.
 
 ****************************************************************************
 *	ALWAYS USE THE SOUND DRIVER VERSION WHICH IS DISTRIBUTED WITH	   *
@@ -722,7 +722,7 @@ To configure the driver, run "make config" in the kernel source directory
 (after the questions about mouse, CD-ROM, ftape, etc. support).  Questions
 about options for sound will then be asked.
 
-After configuring the kernel and sound driver and compile the kernel 
+After configuring the kernel and sound driver and compile the kernel
 following instructions in the kernel README.
 
 The sound driver configuration dialog
@@ -763,7 +763,7 @@ select some options automatically as well.
 	  or a full 100% hardware compatible clone (like Thunderboard or
 	  SM Games). If your card was in the list of supported cards (above),
 	  please look at the card specific instructions later in this file
-	  before answering this question. For an unknown card you may answer 
+	  before answering this question. For an unknown card you may answer
 	  'y' if the card claims to be SB compatible.
 	 Enable this option also with PAS16 (changed since v3.5-beta9).
 
@@ -795,12 +795,12 @@ select some options automatically as well.
 	  sound card to work.
 	  Support for the MPU401 compatible MIDI port of SB16, ESS1688
 	  and MV Jazz16 cards is included in the SB driver. Use it instead
-	  of this separate MPU401 driver with these cards. As well 
+	  of this separate MPU401 driver with these cards. As well
 	  Soundscape, PSS and Maui drivers include their own MPU401
 	  options.
 
 	  It's safe to answer 'y' if you have a true MPU401 MIDI interface
-	  card. 
+	  card.
   "6850 UART Midi support",
 	- It's safe to answer 'n' to this question in all cases. The 6850
 	  UART interface is so rarely used.
@@ -816,13 +816,13 @@ select some options automatically as well.
 	- Answer 'y' only if you have a GUS MAX.
   "Microsoft Sound System support",
 	- Again think carefully before answering 'y' to this question. It's
-	  safe to answer 'y' in case you have the original Windows Sound 
+	  safe to answer 'y' in case you have the original Windows Sound
 	  System card made by Microsoft or Aztech SG 16 Pro (or NX16 Pro).
 	  Also you may answer 'y' in case your card was not listed earlier
 	  in this file. For cards having native support in the driver, consult
 	  the card specific instructions later in this file. Some drivers
 	  have their own MSS support and enabling this option will cause a
-	  conflict. 
+	  conflict.
 	  Note! The MSS driver permits configuring two DMA channels. This is a
 	  "nonstandard" feature and works only with very few cards (if any).
 	  In most cases the second DMA channel should be disabled or set to
@@ -833,14 +833,14 @@ select some options automatically as well.
 	- Answer 'y' if you have a sound card based on the Ensoniq SoundScape
 	  chipset. Such cards are being manufactured at least by Ensoniq,
 	  Spea and Reveal (note that Reveal makes other cards also).  The oldest
-	  cards made by Spea don't work properly with Linux. 
+	  cards made by Spea don't work properly with Linux.
 	  Soundscape PnP as well as Ensoniq VIVO work only with the commercial
 	  OSS/Linux version.
   "MediaTrix AudioTrix Pro support",
 	- Answer 'y' if you have the AudioTrix Pro.
   "Support for MAD16 and/or Mozart based cards",
 	- Answer y if your card has a Mozart (OAK OTI-601) or MAD16
-	  (OPTi 82C928, 82C929, 82C924/82C925 or 82C930) audio interface chip. 
+	  (OPTi 82C928, 82C929, 82C924/82C925 or 82C930) audio interface chip.
 	  These chips are
 	  currently quite common so it's possible that many no-name cards
 	  have one of them. In addition the MAD16 chip is used in some
@@ -919,7 +919,7 @@ SB2_BASE, SB2_IRQ, SB2_DMA and SB2_DMA2 for the second one. You can't get
 the OPL3, MIDI and EMU8000 devices of the second card to work. If you are
 going to use two PnP Sound Blasters, ensure that they are of different model
 and have different PnP IDs. There is no way to get two cards with the same
-card ID and serial number to work. The easiest way to check this is trying 
+card ID and serial number to work. The easiest way to check this is trying
 if isapnptools can see both cards or just one.
 
 NOTE!	Don't enable the SM Games option (asked by the configuration program)
@@ -949,18 +949,18 @@ the following way:
 	  card should work.
 
 If your card is both SB and MSS compatible, I recommend using the MSS mode.
-Most cards of this kind are not able to work in the SB and the MSS mode 
+Most cards of this kind are not able to work in the SB and the MSS mode
 simultaneously. Using the MSS mode provides 16 bit recording and playback.
 
 ProAudioSpectrum 16 and compatibles
 -----------------------------------
 
 PAS16 has a SB emulation chip which can be used together with the native
-(16 bit) mode of the card. To enable this emulation you should configure 
+(16 bit) mode of the card. To enable this emulation you should configure
 the driver to have SB support too (this has been changed since version
 3.5-beta9 of this driver).
 
-With current driver versions it's also possible to use PAS16 together with 
+With current driver versions it's also possible to use PAS16 together with
 another SB compatible card. In this case you should configure SB support
 for the other card and to disable the SB emulation of PAS16 (there is a
 separate questions about this).
@@ -981,7 +981,7 @@ to select the channel as a recording source and to use volume above 10%.
 
 GUS 3.7 has a hardware mixer.
 
-GUS MAX and the 16 bit sampling daughtercard have a CS4231 codec chip which 
+GUS MAX and the 16 bit sampling daughtercard have a CS4231 codec chip which
 also contains a mixer.
 
 Configuring GUS is simple. Just enable the GUS support and GUS MAX or
@@ -1059,7 +1059,7 @@ enable these options when configuring the driver. The configuration
 program handles these options itself. (You may use the SB, MPU and MSS options
 together with PSS if you have another card on the system).
 
-The PSS driver enables MSS and MPU401 modes of the card. SB is not enabled 
+The PSS driver enables MSS and MPU401 modes of the card. SB is not enabled
 since it doesn't work concurrently with MSS. The driver loads also a
 DSP algorithm which is used to for the general MIDI emulation. The
 algorithm file (.ld) is read by the config program and written to a
@@ -1068,7 +1068,7 @@ program asks if you want to download the file. Use the genmidi.ld file
 distributed with the DOS/Windows drivers of the card (don't use the mt32.ld).
 With some cards the file is called 'synth.ld'. You must have access to
 the file when configuring the driver. The easiest way is to mount the DOS
-partition containing the file with Linux. 
+partition containing the file with Linux.
 
 It's possible to load your own DSP algorithms and run them with the card.
 Look at the directory pss_test of snd-util-3.0.tar.gz for more info.
@@ -1092,7 +1092,7 @@ Also the ATP has a microcontroller for the General MIDI emulation (OPL4).
 For this reason the driver asks for the name of a file containing the
 microcode (TRXPRO.HEX). This file is usually located in the directory
 where the DOS drivers were installed. You must have access to this file
-when configuring the driver. 
+when configuring the driver.
 
 If you have the effects daughtercard, it must be initialized by running
 the setfx program of snd-util-3.0.tar.gz package. This step is not required
@@ -1136,7 +1136,7 @@ The SoundScape card has a Motorola microcontroller which must initialized
 _after_ boot (the driver doesn't initialize it during boot).
 The initialization is done by running the 'ssinit' program which is
 distributed in the snd-util-3.0.tar.gz package. You have to edit two
-defines in the ssinit.c and then compile the program. You may run ssinit 
+defines in the ssinit.c and then compile the program. You may run ssinit
 manually (after each boot) or add it to /etc/rc.d/rc.local.
 
 The ssinit program needs the microcode file that comes with the DOS/Windows
@@ -1245,21 +1245,21 @@ versions (pre 3.5-alpha8)).
 
 NOTE!	Don't answer 'y' when the driver asks about SM Games support
 	(the next question after the MIDI0001.BIN name). However
-	answering 'y' doesn't cause damage your computer so don't panic. 
+	answering 'y' doesn't cause damage your computer so don't panic.
 
 Sound Galaxies
 --------------
 
 There are many different Sound Galaxy cards made by Aztech. The 8 bit
 ones are fully SB or SB Pro compatible and there should be no problems
-with them. 
+with them.
 
 The older 16 bit cards (SG Pro16, SG NX Pro16, Nova and Lyra) have
 an EEPROM chip for storing the configuration data. There is a microcontroller
 which initializes the card to match the EEPROM settings when the machine
 is powered on. These cards actually behave just like they have jumpers
-for all of the settings. Configure driver for MSS, MPU, SB/SB Pro  and OPL3 
-supports with these cards. 
+for all of the settings. Configure driver for MSS, MPU, SB/SB Pro  and OPL3
+supports with these cards.
 
 There are some new Sound Galaxies in the market. I have no experience with
 them so read the card's manual carefully.
@@ -1360,7 +1360,7 @@ strength value. See aci.[ch] and miropcm20*.[ch] for more details.
 
 The following configuration parameters have worked fine for the PCM12
 in Markus Kuhn's system, many other configurations might work, too:
-CONFIG_MAD16_BASE=0x530, CONFIG_MAD16_IRQ=11, CONFIG_MAD16_DMA=3, 
+CONFIG_MAD16_BASE=0x530, CONFIG_MAD16_IRQ=11, CONFIG_MAD16_DMA=3,
 CONFIG_MAD16_DMA2=0, CONFIG_MAD16_MPU_BASE=0x330, CONFIG_MAD16_MPU_IRQ=10,
 DSP_BUFFSIZE=65536, SELECTED_SOUND_OPTIONS=0x00281000.
 
@@ -1370,16 +1370,16 @@ differs in: CONFIG_MAD16_IRQ=7, CONFIG_MAD16_DMA=1, CONFIG_MAD16_MPU_IRQ=9
 Compaq Deskpro XL
 -----------------
 
-The builtin sound hardware of Compaq Deskpro XL is now supported. 
+The builtin sound hardware of Compaq Deskpro XL is now supported.
 You need to configure the driver with MSS and OPL3 supports enabled.
 In addition you need to manually edit linux/drivers/sound/local.h and
-to add a line containing "#define DESKPROXL" if you used 
+to add a line containing "#define DESKPROXL" if you used
 make menuconfig/xconfig.
 
 Others?
 -------
 
-Since there are so many different sound cards, it's likely that I have 
+Since there are so many different sound cards, it's likely that I have
 forgotten to mention many of them. Please inform me if you know yet another
 card which works with Linux, please inform me (or is anybody else
 willing to maintain a database of supported cards (just like in XF86)?).
@@ -1387,8 +1387,8 @@ willing to maintain a database of supported cards (just like in XF86)?).
 Cards not supported yet
 =======================
 
-Please check the version of sound driver you are using before 
-complaining that your card is not supported. It's possible you are 
+Please check the version of sound driver you are using before
+complaining that your card is not supported. It's possible you are
 using a driver version which was released months before your card was
 introduced.
 
@@ -1411,12 +1411,12 @@ Adding support for a new card requires much work and increases time
 required in maintaining the driver (some changes need to be done
 to all low level drivers and be tested too, maybe with multiple
 operating systems). For this reason I have made a decision to not support
-obsolete cards. It's possible that someone else makes a separately 
-distributed driver (diffs) for the card. 
+obsolete cards. It's possible that someone else makes a separately
+distributed driver (diffs) for the card.
 
-Writing a driver for a new card is not possible if there are no 
+Writing a driver for a new card is not possible if there are no
 programming information available about the card. If you don't
-find your new card from this file, look from the home page 
+find your new card from this file, look from the home page
 (http://www.opensound.com/ossfree). Then please contact
 manufacturer of the card and ask if they have (or are willing to)
 released technical details of the card. Do this before contacting me. I
-- 
1.7.1.251.gf80a2

