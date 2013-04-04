From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda/cirrus - Add a quirk for Stumpy
	ChromeBox.
Date: Thu,  4 Apr 2013 15:35:31 -0700
Message-ID: <1365114931-6614-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f202.google.com (mail-ob0-f202.google.com
 [209.85.214.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 758E7265F34
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 00:37:25 +0200 (CEST)
Received: by mail-ob0-f202.google.com with SMTP id wd20so770524obb.3
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 15:37:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The Stumpy ChromeBox needs its pin configs fixed up.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_cirrus.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 0d9c58f..bd8d46c 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -68,6 +68,7 @@ enum {
 enum {
 	CS421X_CDB4210,
 	CS421X_SENSE_B,
+	CS421X_STUMPY,
 };
 
 /* Vendor-specific processing widget */
@@ -538,6 +539,7 @@ static int patch_cs420x(struct hda_codec *codec)
 /* CS4210 board names */
 static const struct hda_model_fixup cs421x_models[] = {
 	{ .id = CS421X_CDB4210, .name = "cdb4210" },
+	{ .id = CS421X_STUMPY, .name = "stumpy" },
 	{}
 };
 
@@ -559,6 +561,17 @@ static const struct hda_pintbl cdb4210_pincfgs[] = {
 	{} /* terminator */
 };
 
+/* Stumpy ChromeBox */
+static const struct hda_pintbl stumpy_pincfgs[] = {
+	{ 0x05, 0x022120f0 },
+	{ 0x06, 0x901700f0 },
+	{ 0x07, 0x02a120f0 },
+	{ 0x08, 0x77a70037 },
+	{ 0x09, 0x77a6003e },
+	{ 0x0a, 0x434510f0 },
+	{} /* terminator */
+};
+
 /* Setup GPIO/SENSE for each board (if used) */
 static void cs421x_fixup_sense_b(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action)
@@ -578,7 +591,11 @@ static const struct hda_fixup cs421x_fixups[] = {
 	[CS421X_SENSE_B] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs421x_fixup_sense_b,
-	}
+	},
+	[CS421X_STUMPY] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stumpy_pincfgs,
+	},
 };
 
 static const struct hda_verb cs421x_coef_init_verbs[] = {
-- 
1.8.1.3.605.g02339dd
