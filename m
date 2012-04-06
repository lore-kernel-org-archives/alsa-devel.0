From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 5/6] ALSA: hda - CX20549 doesn't need pin_amp_workaround.
Date: Fri,  6 Apr 2012 15:34:19 +0200
Message-ID: <1333719260-14504-6-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
References: <s5hk41ufe2j.wl%tiwai@suse.de>
 <1333719260-14504-1-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333719260-14504-1-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CX20549 (ctx5045) doesn't accept data on index 1 for output pins,
as shown in the following hda-var transaction:

  $ hda-verb /dev/snd/hwC0D0 0x10 set_amp_gain 0xb126
  nid = 0x10, verb = 0x300, param = 0xb126
  value = 0x0
  $ hda-verb /dev/snd/hwC0D0 0x10 get_amp_gain 0x8001
  nid = 0x10, verb = 0xb00, param = 0x8001
  value = 0x0

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 sound/pci/hda/patch_conexant.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ad5da16..8fe9f9d 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1086,7 +1086,6 @@ static int patch_cxt5045(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	codec->pin_amp_workaround = 1;
 	codec->single_adc_amp = 1;
 
 	spec->multiout.max_channels = 2;
@@ -4443,7 +4442,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	codec->pin_amp_workaround = 1;
 
 	switch (codec->vendor_id) {
 	case 0x14f15045:
@@ -4451,7 +4449,10 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		break;
 	case 0x14f15051:
 		add_cx5051_fake_mutes(codec);
+		codec->pin_amp_workaround = 1;
 		break;
+	default:
+		codec->pin_amp_workaround = 1;
 	}
 
 	apply_pin_fixup(codec, cxt_fixups, cxt_pincfg_tbl);
-- 
1.7.9.1
