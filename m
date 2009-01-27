From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Very faint sound on Dell Latitude E6500
Date: Tue, 27 Jan 2009 16:51:56 +0100
Message-ID: <200901271651.56181.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A0BC1037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 16:52:04 +0100 (CET)
Content-Disposition: inline
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

Hi everybody,

I've received a brand new Dell Latitude E6500 and found out that the sound 
card wasn't exactly well supported by ALSA.

Sound is barely audible (so faint that I'm not even sure if the proper sound 
is output or if I just get garbage), with some loud noise here and there that 
seem to correspond to the saturated audio data  parts.

The sound card is an HDA-Intel with an IDT 92HD71B7X codec. Hardware 
information can be found at 
http://www.alsa-project.org/db/?f=30cac30e5b1ddd9c842481a830c250cc3e593b0d. A 
bug report including the Windows driver .ini file is available at 
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=4306.

When loading the snd_hda_intel driver compiled with verbose debug mode, the 
following messages are printed to the kernel log.

HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA sound/pci/hda/hda_intel.c:2209: chipset global capabilities = 0x4401
ALSA sound/pci/hda/hda_intel.c:775: codec_mask = 0x5
ALSA sound/pci/hda/hda_codec.c:2367: hda_codec: model 'dell-m4-1' is selected 
for config 1028:24f (unknown Dell)
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0a pin config 
0421101f
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0b pin config 
04a11221
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0c pin config 
40f000f0
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0d pin config 
90170110
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0e pin config 
23a1902e
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 0f pin config 
23014250
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 14 pin config 
40f000f0
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 18 pin config 
90a000f0
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 19 pin config 
40f000f0
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 1e pin config 
4f0000f0
ALSA sound/pci/hda/patch_sigmatel.c:2247: hda_codec: pin nid 1f pin config 
4f0000f0
ALSA sound/pci/hda/hda_codec.c:3055: autoconfig: line_outs=1 
(0xf/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3059:    speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3063:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:3064:    mono: mono_out=0x0
ALSA sound/pci/hda/hda_codec.c:3072:    inputs: mic=0xb, fmic=0xe, line=0x0, 
fline=0x0, cd=0x0, aux=0x0
ALSA sound/pci/hda/patch_sigmatel.c:2693: stac92xx_add_dyn_out_pins: total dac 
count=2
ALSA sound/pci/hda/hda_generic.c:679: hda_generic: no proper input path found
ALSA sound/pci/hda/hda_generic.c:284: Skip Digital OUT node 2
ALSA sound/pci/hda/hda_generic.c:427: hda_generic: no proper output path found
ALSA sound/pci/hda/hda_generic.c:1022: hda_generic: no PCM found
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Surround Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Center Playback Volume, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave LFE Playback Volume, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Side Playback Volume, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Speaker Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave External Speaker 
Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Speaker2 Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Surround Playback 
Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Center Playback Switch, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave LFE Playback Switch, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Side Playback Switch, 
skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Speaker Playback 
Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave External Speaker 
Playback Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave Speaker2 Playback 
Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1127: Cannot find slave IEC958 Playback Switch, 
skipped

I tried forcing the model to dell-m4-1, dell-m4-2, dell-m4-3 and ref without 
any luck. I also tried upgrading to alsa-driver 1.0.19 and results were 
identical.

Could anyone help me ? I can patch and recompile the driver is required.

Best regards,

Laurent Pinchart
