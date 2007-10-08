From: Veli-Matti Lintu <veli-matti.lintu@opinsys.fi>
Subject: Patch for Intel-HDA ALC262 on FSC Lifebook C1410
Date: Mon, 8 Oct 2007 13:59:41 +0300 (EEST)
Message-ID: <23182792.17541191841181316.JavaMail.root@intra>
References: <32444606.17521191841076426.JavaMail.root@intra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.opinsys.fi (59ec6c11.adsl.tnnet.fi [89.236.108.17])
	by alsa0.perex.cz (Postfix) with ESMTP id BA3051038B2
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Oct 2007 13:01:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.opinsys.fi (Postfix) with ESMTP id AD1FA94089
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Oct 2007 13:59:46 +0300 (EEST)
Received: from mail.opinsys.fi ([127.0.0.1])
	by localhost (mail.opinsys.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOl-XOzI4XMj for <alsa-devel@alsa-project.org>;
	Mon,  8 Oct 2007 13:59:41 +0300 (EEST)
Received: from mail.opinsys.fi (intra.opinsys.fi [10.246.131.35])
	by mail.opinsys.fi (Postfix) with ESMTP id 714BB94085
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Oct 2007 13:59:41 +0300 (EEST)
In-Reply-To: <32444606.17521191841076426.JavaMail.root@intra>
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

Hello,

After error and trial I got sound working on Fujitsu-Siemens Computers Lifebook C1410. Attached is a patch that works for me, but probably needs some cleaning.

The laptop uses an ALC262 chip that is also used on other FSC models, but the needed settings seem to be somewhat different from the existing Fujitsu-settings in patch_realtek.c. If I understand correctly, the chips use same subsystem ids, so the patch does not automatically detect the correct chipset. Maybe someone more knowledgeable can help with this? The patch names the internal mic as Int Mic and external mic that can be plugged in as Ext Mic.

There's some more background information in Ubuntu's Launchpad:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/125790


The patch is tested with kernel 2.6.22.9. I am not really familiar with alsa development, so I cannot say which version of the alsa drivers that kernel version uses. The environment where the testing was done is running Ubuntu 7.04 with alsa version 1.0.13. Only updated component is the kernel.


The patch needs model=fujitsu-c1410 parameter to be passed to the module:

/etc/modprobe.d/alsa-base:
options snd-hda-intel model=fujitsu-c1410


The subsystem 10cf:1397 is mapped in patch_realtek.c alc262_cfg_tbl to ALC262_FUJITSU and ALC262_FUJITSU_C1410 would need to be mapped to same ids:

-------------------------------------------------------------------
sound/pci/hda/patch_realtek.c:
        SND_PCI_QUIRK(0x10cf, 0x1397, "Fujitsu", ALC262_FUJITSU),
-------------------------------------------------------------------
lspci -nv (on C1410)

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 10cf:1397
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at f0640000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
-------------------------------------------------------------------

I hope someone with more knowledge about alsa drivers could have a look at this. The patch has been in internal use for a few weeks and people seem to be happy with it, so I hope also others can get their sound working.

The patch and hw information follow:

---------------------------------------------------------------------------------------------
--- linux-2.6.22.9/sound/pci/hda/patch_realtek.c.orig	2007-09-26 21:03:01.000000000 +0300
+++ linux-2.6.22.9/sound/pci/hda/patch_realtek.c	2007-10-07 13:28:12.000000000 +0300
@@ -89,6 +89,7 @@
 	ALC262_HIPPO,
 	ALC262_HIPPO_1,
 	ALC262_FUJITSU,
+	ALC262_FUJITSU_C1410,
 	ALC262_HP_BPC,
 	ALC262_HP_BPC_D7000_WL,
 	ALC262_HP_BPC_D7000_WF,
@@ -7068,6 +7069,15 @@
 	},
 };
 
+static struct hda_input_mux alc262_fujitsu_c1410_capture_source = {
+	.num_items = 3,
+	.items = {
+                { "Ext Mic", 0x0 },
+                { "Int Mic", 0x1 },
+                { "CD", 0x4 },
+	},
+};
+
 static struct hda_input_mux alc262_HP_capture_source = {
 	.num_items = 5,
 	.items = {
@@ -7182,6 +7192,43 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc262_fujitsu_c1410_mixer[] = {
+  {
+    .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+    .name = "Master Playback Volume",
+    .info = snd_hda_mixer_amp_volume_info,
+    .get = snd_hda_mixer_amp_volume_get,
+    .put = alc262_fujitsu_master_vol_put,
+    .tlv = { .c = snd_hda_mixer_amp_tlv },
+    .private_value = HDA_COMPOSE_AMP_VAL(0x0c, 3, 0, HDA_OUTPUT),
+  },
+  {
+    .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+    .name = "Master Playback Switch",
+    .info = snd_hda_mixer_amp_switch_info,
+    .get = snd_hda_mixer_amp_switch_get,
+    .put = alc262_fujitsu_master_sw_put,
+    .private_value = HDA_COMPOSE_AMP_VAL(0x0d, 3, 0, HDA_OUTPUT),
+  },
+
+  HDA_CODEC_VOLUME("Headphones Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+  HDA_CODEC_MUTE("Headphones Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+  HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+  HDA_CODEC_MUTE("Speaker Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+
+  HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
+  HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+
+  HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+  HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+  HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+  HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+
+  HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+  HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+  { } /* end */
+};
+
 /* additional init verbs for Benq laptops */
 static struct hda_verb alc262_EAPD_verbs[] = {
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
@@ -7581,6 +7628,7 @@
 	[ALC262_HIPPO]		= "hippo",
 	[ALC262_HIPPO_1]	= "hippo_1",
 	[ALC262_FUJITSU]	= "fujitsu",
+	[ALC262_FUJITSU_C1410]	= "fujitsu-c1410",
 	[ALC262_HP_BPC]		= "hp-bpc",
 	[ALC262_HP_BPC_D7000_WL]= "hp-bpc-d7000",
 	[ALC262_BENQ_ED8]	= "benq",
@@ -7659,6 +7707,18 @@
 		.input_mux = &alc262_fujitsu_capture_source,
 		.unsol_event = alc262_fujitsu_unsol_event,
 	},
+	[ALC262_FUJITSU_C1410] = {
+	        .mixers = { alc262_fujitsu_c1410_mixer },
+                .init_verbs = { alc262_init_verbs, alc262_EAPD_verbs, alc262_fujitsu_unsol_verbs },
+                .num_dacs = ARRAY_SIZE(alc262_dac_nids),
+		.dac_nids = alc262_dac_nids,
+		.hp_nid = 0x03,
+		.dig_out_nid = ALC262_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc262_modes),
+		.channel_mode = alc262_modes,
+		.input_mux = &alc262_fujitsu_c1410_capture_source,
+		.unsol_event = alc262_fujitsu_unsol_event,
+	},
 	[ALC262_HP_BPC] = {
 		.mixers = { alc262_HP_BPC_mixer },
 		.init_verbs = { alc262_HP_BPC_init_verbs },
---------------------------------------------------------------------------------------------

ALSA Audio Debug v0.1.0 - su 7.10.2007 15:13:09 +0300
http://alsa.opensrc.org/aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux oppilas 2.6.22.9-c1410 #2 SMP Sun Oct 7 11:57:15 EEST 2007 i686 GNU/Linux

Loaded Modules --------------------------------------------
snd_hda_intel         257560  1 
snd_pcm_oss            44928  0 
snd_mixer_oss          17664  1 snd_pcm_oss
snd_pcm                80772  2 snd_hda_intel,snd_pcm_oss
snd_seq_dummy           4740  0 
snd_seq_oss            33408  0 
snd_seq_midi            9600  0 
snd_rawmidi            25856  1 snd_seq_midi
snd_seq_midi_event      8448  2 snd_seq_oss,snd_seq_midi
snd_seq                53360  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              24196  2 snd_pcm,snd_seq
snd_seq_device          9356  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    54916  11 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
snd_page_alloc         11400  2 snd_hda_intel,snd_pcm

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31 09:03:25 2007 UTC).
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf0640000 irq 22
  2:        : timer
  3:        : sequencer
  4: [ 0- 6]: digital audio playback
  5: [ 0- 6]: digital audio capture
  6: [ 0- 2]: digital audio capture
  7: [ 0- 1]: digital audio playback
  8: [ 0- 0]: digital audio playback
  9: [ 0- 0]: digital audio capture
 10: [ 0]   : control
00-06: Si3054 Modem : Si3054 Modem : playback 1 : capture 1
00-02: ALC262 Analog : ALC262 Analog : capture 2
00-01: ALC262 Digital : ALC262 Digital : playback 1
00-00: ALC262 Analog : ALC262 Analog : playback 1 : capture 2
Client info
  cur  clients : 3
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 15:0
Client  14 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
Client  15 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0p  pcmC0D2c  pcmC0D6p  timer
pcmC0D0c   pcmC0D1p  pcmC0D6c  seq

CPU -------------------------------------------------------
model name	: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz
cpu MHz		: 1000.000
model name	: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz
cpu MHz		: 1000.000

RAM -------------------------------------------------------
MemTotal:      1026252 kB
SwapTotal:     2441872 kB

Hardware --------------------------------------------------
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller AHCI (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8055 PCI-E Gigabit Ethernet Controller (rev 12)
05:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
08:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
08:03.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08)
08:03.2 Generic system peripheral [0805]: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 17)

00:00.0 0600: 8086:27a0 (rev 03)
	Subsystem: 10cf:1378
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:27a2 (rev 03) (prog-if 00 [VGA])
	Subsystem: 10cf:1381
	Flags: bus master, fast devsel, latency 0, IRQ 19
	Memory at f0300000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1800 [size=8]
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Memory at f0400000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [d0] Power Management version 2

00:02.1 0380: 8086:27a6 (rev 03)
	Subsystem: 10cf:1381
	Flags: bus master, fast devsel, latency 0
	Memory at f0380000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 2

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 10cf:1397
	Flags: bus master, fast devsel, latency 0, IRQ 22
	Memory at f0640000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:27d0 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f0000000-f00fffff
	Prefetchable memory behind bridge: 0000000054000000-00000000540fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 10cf:138b
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 0604: 8086:27d2 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 10cf:138b
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 0604: 8086:27d4 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=0
	Memory behind bridge: 54100000-541fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 10cf:138b
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:27c8 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 10cf:1389
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 1820 [size=32]

00:1d.1 0c03: 8086:27c9 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 10cf:1389
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 1840 [size=32]

00:1d.2 0c03: 8086:27ca (rev 02) (prog-if 00 [UHCI])
	Subsystem: 10cf:1389
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 1860 [size=32]

00:1d.3 0c03: 8086:27cb (rev 02) (prog-if 00 [UHCI])
	Subsystem: 10cf:1389
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1880 [size=32]

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20 [EHCI])
	Subsystem: 10cf:138a
	Flags: bus master, medium devsel, latency 0, IRQ 20
	Memory at f0644000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=08, subordinate=0c, sec-latency=32
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f0200000-f02fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000053ffffff
	Capabilities: [50] Subsystem: 10cf:1383

00:1f.0 0601: 8086:27b9 (rev 02)
	Subsystem: 10cf:1384
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: 10cf:1385
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at 1810 [size=16]

00:1f.2 0106: 8086:27c5 (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: 10cf:1387
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 220
	I/O ports at 18d0 [size=8]
	I/O ports at 18c4 [size=4]
	I/O ports at 18c8 [size=8]
	I/O ports at 18c0 [size=4]
	I/O ports at 18b0 [size=16]
	Memory at f0644400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [70] Power Management version 2

00:1f.3 0c05: 8086:27da (rev 02)
	Subsystem: 10cf:1388
	Flags: medium devsel, IRQ 11
	I/O ports at 18e0 [size=32]

02:00.0 0200: 11ab:4363 (rev 12)
	Subsystem: 10cf:139a
	Flags: bus master, fast devsel, latency 0, IRQ 219
	Memory at f0000000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 2000 [size=256]
	[virtual] Expansion ROM at 54000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 3
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

05:00.0 0280: 8086:4222 (rev 02)
	Subsystem: 8086:1001
	Flags: bus master, fast devsel, latency 0, IRQ 21
	Memory at 54100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number b5-ec-71-ff-ff-77-1b-00

08:03.0 0607: 1180:0476 (rev b3)
	Subsystem: 10cf:1254
	Flags: bus master, medium devsel, latency 168, IRQ 19
	Memory at f0201000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=08, secondary=09, subordinate=0c, sec-latency=176
	Memory window 0: 50000000-53fff000 (prefetchable)
	Memory window 1: 58000000-5bfff000
	I/O window 0: 00003000-000030ff
	I/O window 1: 00003400-000034ff
	16-bit legacy interface ports at 0001

08:03.1 0c00: 1180:0552 (rev 08) (prog-if 10 [OHCI])
	Subsystem: 10cf:1255
	Flags: bus master, medium devsel, latency 32, IRQ 22
	Memory at f0200000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2

08:03.2 0805: 1180:0822 (rev 17)
	Subsystem: 10cf:1323
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at f0200800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
---------------------------------------------------------------------------------------------

Veli-Matti Lintu
