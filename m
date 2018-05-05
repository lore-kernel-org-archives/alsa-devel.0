From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH v3 3/9] ALSA: hda/ca0132: Add PCI region2 iomap
	for SBZ
Date: Sat,  5 May 2018 15:03:14 -0400
Message-ID: <1525547001-17588-4-git-send-email-conmanx360@gmail.com>
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B3E2675F1
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 21:04:11 +0200 (CEST)
Received: by mail-io0-f195.google.com with SMTP id d11-v6so29283055iof.11
 for <alsa-devel@alsa-project.org>; Sat, 05 May 2018 12:04:11 -0700 (PDT)
In-Reply-To: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, Connor McAdams <conmanx360@gmail.com>, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

This patch adds iomapping for the region2 section of memory on the SBZ.
This memory region is used in later patches for setting inputs and
outputs. If the mapping fails, the quirk is changed back to QUIRK_NONE
to avoid attempts to write to uninitialized memory.

It also adds a new exit sequence to unmap the iomem for the SBZ.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 02238fe..78d2c26 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -29,6 +29,9 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <sound/core.h>
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -760,6 +763,11 @@ struct ca0132_spec {
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
+	/*
+	 * Sound Blaster Z PCI region 2 iomem, used for input and output
+	 * switching, and other unknown commands.
+	 */
+	void __iomem *mem_base;
 };
 
 /*
@@ -4696,6 +4704,8 @@ static void ca0132_free(struct hda_codec *codec)
 	snd_hda_sequence_write(codec, spec->base_exit_verbs);
 	ca0132_exit_chip(codec);
 	snd_hda_power_down(codec);
+	if (spec->mem_base)
+		iounmap(spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
@@ -4911,6 +4921,15 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
+	/* Setup BAR Region 2 for Sound Blaster Z */
+	if (spec->quirk == QUIRK_SBZ) {
+		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
+		if (spec->mem_base == NULL) {
+			codec_warn(codec, "pci_iomap failed!");
+			codec_info(codec, "perhaps this is not an SBZ?");
+			spec->quirk = QUIRK_NONE;
+		}
+	}
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 	spec->mixers[0] = ca0132_mixer;
-- 
2.7.4
