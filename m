From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 5/6] sound/pci/hda: CX20549 doesn't need pin_amp_workaround.
Date: Thu, 05 Apr 2012 15:30:35 +0200
Message-ID: <1333632635.4159.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

CX20549 (ctx5045) doesn't accept data on index 1 for output pins,
as shown in the following hda-var transaction:

  $ hda-verb /dev/snd/hwC0D0 0x10 set_amp_gain 0xb126
  nid = 0x10, verb = 0x300, param = 0xb126
  value = 0x0
  $ hda-verb /dev/snd/hwC0D0 0x10 get_amp_gain 0x8001
  nid = 0x10, verb = 0xb00, param = 0x8001
  value = 0x0

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 8d7a977..3ab7b25 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1087,7 +1087,6 @@ static int patch_cxt5045(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	codec->pin_amp_workaround = 1;
 
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = ARRAY_SIZE(cxt5045_dac_nids);
-- 
1.7.9.1
