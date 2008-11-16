From: "Andrei Tanas" <andrei@tanas.ca>
Subject: Re: digital audio on ASUS P5QL-EM motherboard
Date: Sun, 16 Nov 2008 01:29:46 -0500
Message-ID: <003801c947b4$b857ffb0$2907ff10$@ca>
References: <6d799ca1be9af898f664f82ade06d669@localhost>
	<20081115002724.GA5073@mail.ustc.edu.cn>
	<002f01c94770$adeba2a0$09c2e7e0$@ca>
	<20081116021525.GA7795@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 08043103817
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 07:29:38 +0100 (CET)
In-Reply-To: <20081116021525.GA7795@localhost>
Content-Language: en-ca
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Wu Fengguang' <fengguang.wu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> It seems that there are two problems:
> - the SPDIF output PID for you board is 0x10 instead of 0x06
You are right about this, it works with the patch you provided, with one
caveat: ALC1200 uses ALC883 patch, so instead of changing ALC882_DIGOUT_NID,
I changed ALC883_DIGOUT_NID.
How did you find out that it's 0x10 instead of 0x06? Has documentation on
ALC1200 become available?

> - codec#1 is not probed properly
I was responsible for the confusion with the missing codec. I set
probe_mask=1 parameter (as suggested in some forum as a troubleshooting
option for ALC1200) without trying to understand what it does. The probing
actually seems to work correctly.

Model autodetection:
lspci -nn -vvv shows:
00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD
Audio Controller [8086:3a3e]
        Subsystem: ASUSTeK Computer Inc. Device [1043:82fe]

So this SND_PCI_QUIRK fixes it (except that it's currently relying on the
temporary hack)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8206,6 +8206,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] = {
        SND_PCI_QUIRK(0x103c, 0x2a4f, "HP Samba", ALC888_3ST_HP),
        SND_PCI_QUIRK(0x103c, 0x2a60, "HP Lucknow", ALC888_3ST_HP),
        SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
+       SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q", ALC883_6ST_DIG),
        SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
        SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI",
ALC883_3ST_6ch_DIG),
        SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_ASUS_EEE1601),


Thank you.

---------------------- aplay -l ----------------------
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC1200 Digital [ALC1200 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: INTEL HDMI [INTEL HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

---------------------- aplay -L (with model=6stack-dig)
----------------------
front:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Digital
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

---------------------- aplay -L (default options) ----------------------
front:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)

---------------------- dmesg (with model=6stack-dig ) ----------------------
[    8.442560] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) ->
IRQ 22
[    8.442686] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    8.442690] ALSA sound/pci/hda/hda_intel.c:2196: chipset global
capabilities = 0x4401
[    8.466673] ALSA sound/pci/hda/hda_intel.c:779: codec_mask = 0x3
[    8.466753] ALSA sound/pci/hda/hda_intel.c:1256: max_slots = 4,
codec_mask = 3, codec_probe_mask = -1
[    8.466889] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #0
probed OK
[    8.467018] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #1
probed OK
[    8.490429] usb 3-1: reset full speed USB device using uhci_hcd and
address 2
[    8.637617] lirc_dev: lirc_register_plugin: sample_rate: 0
[    8.641615] lirc_mceusb2[2]: Philips eHome Infrared Transceiver on usb3:2
[    8.641689] usbcore: registered new interface driver lirc_mceusb2
[    9.470007] ALSA sound/pci/hda/hda_intel.c:627: hda_intel:
azx_get_response timeout, switching to polling mode: last cmd=0x200f0000
[   10.473336] ALSA sound/pci/hda/hda_intel.c:1271: hda_intel: Codec #2
probe error; disabling it...
[   11.503338] ALSA sound/pci/hda/hda_intel.c:1271: hda_intel: Codec #3
probe error; disabling it...
[   11.531911] ALSA sound/pci/hda/hda_codec.c:2587: hda_codec: model
'6stack-dig' is selected
[   11.558144] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Headphone Playback Volume, skipped
[   11.558237] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Volume, skipped
[   11.558330] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Volume, skipped
[   11.558422] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Line-Out Playback Volume, skipped
[   11.558514] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave PCM
Playback Volume, skipped
[   11.558610] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Switch, skipped
[   11.558702] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Switch, skipped
************** playback on **************
[  159.960545] ALSA sound/pci/hda/hda_intel.c:1473: azx_pcm_prepare:
bufsize=0x10000, format=0x11
[  159.960567] ALSA sound/pci/hda/hda_codec.c:841: hda_codec_setup_stream:
NID=0x10, stream=0x5, channel=0, format=0x11
[  161.613092] ALSA sound/pci/hda/hda_codec.c:853: hda_codec_cleanup_stream:
NID=0x10
[  161.613168] ALSA sound/pci/hda/hda_codec.c:853: hda_codec_cleanup_stream:
NID=0x10
************** playback off **************



---------------------- dmesg (no parameters) ----------------------
[    8.972060] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) ->
IRQ 22
[    8.972187] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    8.972191] ALSA sound/pci/hda/hda_intel.c:2196: chipset global
capabilities = 0x4401
[    8.996673] ALSA sound/pci/hda/hda_intel.c:779: codec_mask = 0x3
[    8.996754] ALSA sound/pci/hda/hda_intel.c:1256: max_slots = 4,
codec_mask = 3, codec_probe_mask = -1
[    8.996896] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #0
probed OK
[    8.997016] ALSA sound/pci/hda/hda_intel.c:1206: hda_intel: codec #1
probed OK
[   10.000009] ALSA sound/pci/hda/hda_intel.c:627: hda_intel:
azx_get_response timeout, switching to polling mode: last cmd=0x200f0000
[   11.003343] ALSA sound/pci/hda/hda_intel.c:1271: hda_intel: Codec #2
probe error; disabling it...
[   12.033342] ALSA sound/pci/hda/hda_intel.c:1271: hda_intel: Codec #3
probe error; disabling it...
[   12.061914] hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS...
[   12.062480] ALSA sound/pci/hda/hda_codec.c:3303: autoconfig: line_outs=4
(0x14/0x15/0x16/0x17/0x0)
[   12.062482] ALSA sound/pci/hda/hda_codec.c:3307:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   12.062484] ALSA sound/pci/hda/hda_codec.c:3311:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   12.062485] ALSA sound/pci/hda/hda_codec.c:3312:    mono: mono_out=0x0
[   12.062487] ALSA sound/pci/hda/hda_codec.c:3320:    inputs: mic=0x18,
fmic=0x19, line=0x1a, fline=0x0, cd=0x0, aux=0x0
[   12.092487] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Headphone Playback Volume, skipped
[   12.092581] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Volume, skipped
[   12.092673] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Volume, skipped
[   12.092764] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Line-Out Playback Volume, skipped
[   12.092856] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave PCM
Playback Volume, skipped
[   12.092953] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave
Speaker Playback Switch, skipped
[   12.093043] ALSA sound/pci/hda/hda_codec.c:1276: Cannot find slave Mono
Playback Switch, skipped
