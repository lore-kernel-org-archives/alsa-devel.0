From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Add common pin macros for
	ALC269 family
Date: Wed,  3 Sep 2014 10:23:04 +0200
Message-ID: <1409732585-7614-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E07EC265648
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 10:23:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This will be used in a later patch to make the pin quirk table shorter.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Note: there is a checkpatch error on this one:

ERROR: Macros with complex values should be enclosed in parenthesis

...but in this case I believe checkpatch is wrong, as adding parenthesis around
the "complex values" will cause a compilation error.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 00fc594..b8ff33b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5029,6 +5029,37 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{}
 };
 
+#define ALC255_STANDARD_PINS \
+	{0x18, 0x411111f0}, \
+	{0x19, 0x411111f0}, \
+	{0x1a, 0x411111f0}, \
+	{0x1b, 0x411111f0}, \
+	{0x1e, 0x411111f0}
+
+#define ALC282_STANDARD_PINS \
+	{0x14, 0x90170110}, \
+	{0x18, 0x411111f0}, \
+	{0x1a, 0x411111f0}, \
+	{0x1b, 0x411111f0}, \
+	{0x1e, 0x411111f0}
+
+#define ALC290_STANDARD_PINS \
+	{0x12, 0x99a30130}, \
+	{0x13, 0x40000000}, \
+	{0x16, 0x411111f0}, \
+	{0x17, 0x411111f0}, \
+	{0x19, 0x411111f0}, \
+	{0x1b, 0x411111f0}, \
+	{0x1e, 0x411111f0}
+
+#define ALC292_STANDARD_PINS \
+	{0x14, 0x90170110}, \
+	{0x15, 0x0221401f}, \
+	{0x1a, 0x411111f0}, \
+	{0x1b, 0x411111f0}, \
+	{0x1d, 0x40700001}, \
+	{0x1e, 0x411111f0}
+
 static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x12, 0x40300000},
-- 
1.9.1
