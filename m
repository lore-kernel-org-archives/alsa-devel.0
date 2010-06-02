From: David Fries <david@fries.net>
Subject: [PATCH] regression 2.6.35-rc1+ hda realtek missing
	beep 10ec0883
Date: Tue, 1 Jun 2010 23:31:31 -0500
Message-ID: <20100602043129.GE22327@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SpacedOut.fries.net (SpacedOut.fries.net [67.64.210.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F59924458
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 06:31:50 +0200 (CEST)
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
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

From: David Fries <david@fries.net>

The PC-Spekaer Beep control worked in 2.6.34, but not 2.6.35-rc1, this
is the patch that modified that behavior.
"ALSA: hda - Add parse customize define function for Realtek codecs"
regression in commit da00c24493bf6ae3772dfe7343dca033ebc75955.

Debug output (after this patch),
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
SKU: Nid=0x0 sku_cfg=0x0000140d
SKU: port_connectivity=0x0
SKU: enable_pcbeep=0x0
SKU: check_sum=0x00000000
SKU: customization=0x00000000
SKU: external_amp=0x1
SKU: platform_type=0x1
SKU: swap=0x0
SKU: override=0x1
hda_codec: ALC883: BIOS auto-probing.
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs: mic=0x18, fmic=0x0, line=0x1a, fline=0x0, cd=0x1c, aux=0x0
realtek: Enabling init ASM_ID=0x140d CODEC_ID=10ec0883
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/input/input16

Signed-off-by: David Fries <david@fries.net>
Cc: Kailang Yang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
My patch restores both the Beep volume and mute.  I'll let someone
else determine if this is the correct solution or not.

 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 17d4548..c31c8b9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10611,7 +10611,7 @@ static int patch_alc882(struct hda_codec *codec)
 
 	set_capture_mixer(codec);
 
-	if (spec->cdefine.enable_pcbeep)
+	if (spec->cdefine.enable_pcbeep || codec->vendor_id == 0x10ec0883)
 		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 
 	if (board_config == ALC882_AUTO)
-- 
1.7.1
