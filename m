From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002191]: No sound on intel8x0 -
	82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller
Date: Wed, 7 Jun 2006 20:35:50 +0200
Message-ID: <0dcf04b430a105e6ea6d550151cbc740@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1083A125
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 20:35:51 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2191> 
======================================================================
Reported By:                kickstart
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2191
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Linux Slackware
Kernel Version:             2.6.16.19 vanilla
======================================================================
Date Submitted:             06-07-2006 20:35 CEST
Last Modified:              06-07-2006 20:35 CEST
======================================================================
Summary:                    No sound on intel8x0 - 82801FB/FBM/FR/FW/FRW (ICH6
Family) AC'97 Audio Controller
Description: 
Hi all,

I've Packard Bell A8810 running linux Slackware current, with the same
problem.

- My lspci:
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
06:01.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
06:01.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
06:01.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
06:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)


With linux kernel 2.6.16.19 vanilla [ alsaconf 1.0.11 ] sound card is
detected and alsaconf reports:

===============================================================================

 Now ALSA is ready to use.
 For adjustment of volumes, use your favorite mixer.

 Have a lot of fun!

but no sound!

lsmod output:

root@albino:~# lsmod
Module                  Size  Used by
snd_seq_dummy           3844  0 
snd_seq_oss            36864  0 
snd_seq_midi_event      7296  1 snd_seq_oss
snd_seq                58832  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          9100  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            61856  0 
snd_mixer_oss          20096  3 snd_pcm_oss
snd_intel8x0           34844  2 
snd_ac97_codec         96928  1 snd_intel8x0
snd_ac97_bus            2304  1 snd_ac97_codec
snd_pcm               101256  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              27524  2 snd_seq,snd_pcm
snd                    60516  10
snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              10336  3 snd
snd_page_alloc         11400  2 snd_intel8x0,snd_pcm
i2c_i801                8972  0 
i2c_core               22288  1 i2c_i801
ipw2200               116268  0 


cat /proc/asound/cards

 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with unknown codec at 0xb0040800, irq 16

- The audio codec seems to be a Conexant 20468-31 AC'97:

http://support.packardbell.com/it/item/index.php?i=spec_sound_cnx20468-31&ppn=PB30Q01306]

- Conexant info:

http://www.conexant.com/products/entry.jsp?id=24

This laptop seems quite similar to NEC Versa s940:

http://forum.hardware.fr/hardwarefr/MiniPCPortablesPDA/Topic-Unique-NEC-Versa-S940-Packard-Bell-EasyNote-A5510-A7715-sujet-17891-1.htm
http://www.nec-online.co.nz/Products/Product_Specs.asp?CID=9&RangeID=15&CatID=30&ModID=79

Since this audio codec family seems to bee supported ( see
sound/pci/ac97/ac97_codec.c ) with id = 0x43585428 Cx20468 , I've
compiled
a vanilla 2.6.16.19 kernel adding my ac97_codec_id taken from:

cat /proc/asound/card0/codec97#0/ac97#0-0+regs

<snip>
0:7c = 4358
0:7e = 5431

My ID = 0x43585431 [ 0:7c + 0:7e value ]

to sound/pci/ac97/ac97_codec.c

<snip>
{ 0x43585421, 0xffffffff, "HSD11246", NULL, NULL }, // SmartMC II
{ 0x43585428, 0xfffffff8, "Cx20468",patch_conexant, NULL }, // SmartAMC
fixme: 
{ 0x43585431, 0xffffffff, "Cx20468-31",patch_conexant, NULL }, // <--
ADDED
{ 0x44543031, 0xfffffff0, "DT0398", NULL, NULL },
<snip>


Now, cat /proc/asound/cards gives:

 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with Cx20468-31 at 0xb0040800, irq 16

but STILL NO SOUND! 


Note: Same problem on FreeBSD 6.1 and OpenBSD 3.9 !

UPDATE: Searching 'CX20468 datasheet' on Google, I've found this
datasheet:

http://www.google.it/url?sa=U&start=10&q=http://www.alsa-project.org/alsa/ftp/manuals/conexant/100965aSmartAMC-AudioModemCodec.pdf&e=15235&ei=k12ARMTmAa-giAKgwvmjDQ

I can provide remote access to my laptop to alsa developers, if needed.



======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 20:35 kickstart      New Issue                                    
06-07-06 20:35 kickstart      Distribution              => Linux Slackware 
06-07-06 20:35 kickstart      Kernel Version            => 2.6.16.19 vanilla
======================================================================
