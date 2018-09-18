From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 05/15] ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
Date: Tue, 18 Sep 2018 14:33:33 -0400
Message-ID: <1537295625-8082-6-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds the unique writes for the AE-5 on startup to
ca0132_mmio_init. The other cards share some addresses written to, but
use different values.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 61 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7c870c4..51af3dc 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7223,23 +7223,72 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	writel(0x00000000, spec->mem_base + 0x400);
-	writel(0x00000000, spec->mem_base + 0x408);
-	writel(0x00000000, spec->mem_base + 0x40C);
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x400);
+	else
+		writel(0x00000000, spec->mem_base + 0x400);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x408);
+	else
+		writel(0x00000000, spec->mem_base + 0x408);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x40c);
+	else
+		writel(0x00000000, spec->mem_base + 0x40C);
+
 	writel(0x00880680, spec->mem_base + 0x01C);
-	writel(0x00000083, spec->mem_base + 0xC0C);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000080, spec->mem_base + 0xC0C);
+	else
+		writel(0x00000083, spec->mem_base + 0xC0C);
+
 	writel(0x00000030, spec->mem_base + 0xC00);
 	writel(0x00000000, spec->mem_base + 0xC04);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000000, spec->mem_base + 0xC0C);
+	else
+		writel(0x00000003, spec->mem_base + 0xC0C);
+
 	writel(0x00000003, spec->mem_base + 0xC0C);
 	writel(0x00000003, spec->mem_base + 0xC0C);
 	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x000000C1, spec->mem_base + 0xC08);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0xC08);
+	else
+		writel(0x000000C1, spec->mem_base + 0xC08);
+
 	writel(0x000000F1, spec->mem_base + 0xC08);
 	writel(0x00000001, spec->mem_base + 0xC08);
 	writel(0x000000C7, spec->mem_base + 0xC08);
 	writel(0x000000C1, spec->mem_base + 0xC08);
 	writel(0x00000080, spec->mem_base + 0xC04);
+
+	if (spec->quirk == QUIRK_AE5) {
+		writel(0x00000000, spec->mem_base + 0x42c);
+		writel(0x00000000, spec->mem_base + 0x46c);
+		writel(0x00000000, spec->mem_base + 0x4ac);
+		writel(0x00000000, spec->mem_base + 0x4ec);
+		writel(0x00000000, spec->mem_base + 0x43c);
+		writel(0x00000000, spec->mem_base + 0x47c);
+		writel(0x00000000, spec->mem_base + 0x4bc);
+		writel(0x00000000, spec->mem_base + 0x4fc);
+		writel(0x00000600, spec->mem_base + 0x100);
+		writel(0x00000014, spec->mem_base + 0x410);
+		writel(0x0000060f, spec->mem_base + 0x100);
+		writel(0x0000070f, spec->mem_base + 0x100);
+		writel(0x00000aff, spec->mem_base + 0x830);
+		writel(0x00000000, spec->mem_base + 0x86c);
+		writel(0x0000006b, spec->mem_base + 0x800);
+		writel(0x00000001, spec->mem_base + 0x86c);
+		writel(0x0000006b, spec->mem_base + 0x800);
+		writel(0x00000057, spec->mem_base + 0x804);
+		writel(0x00800000, spec->mem_base + 0x20c);
+	}
 }
 
 /*
-- 
2.7.4
