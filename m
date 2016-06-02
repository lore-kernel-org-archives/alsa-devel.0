From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH] ASoC: sgtl5000: only check VDDD-supply, not revision
Date: Thu,  2 Jun 2016 14:47:24 +0200
Message-ID: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Eric Nelson <eric@nelint.com>, linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: alsa-devel@alsa-project.org

Instead of checking the SGTL5000 chip revision, we should only check if
the VDDD regulator exists and only call sgtl5000_replace_vddd_with_ldo
if the regulator is missing.
Otherwise, the user reads in the kernel log that the internal LDO is
used, even though he did follow the NXP recommendation to use external
VDDD and also specified VDDD-supply in the devicetree.

Also remove the comment, which incorrectly states that external VDDD is
only supported for SGTL5000 chip revisions < 0x11.
Official NXP documentation recommends using external VDDD and not the
internal LDO due to the SGTL5000 erratum ER1. This also applies to
revisions >= 0x11.

Tested on an i.MX6Q board with SGTL5000 rev 0x11 and external VDDD.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 sound/soc/codecs/sgtl5000.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 08b4046..fbad4fb 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1286,17 +1286,14 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
 		sgtl5000->supplies[i].supply = supply_names[i];
 
-	/* External VDDD only works before revision 0x11 */
-	if (sgtl5000->revision < 0x11) {
-		vddd = regulator_get_optional(codec->dev, "VDDD");
-		if (IS_ERR(vddd)) {
-			/* See if it's just not registered yet */
-			if (PTR_ERR(vddd) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-		} else {
-			external_vddd = 1;
-			regulator_put(vddd);
-		}
+	vddd = regulator_get_optional(codec->dev, "VDDD");
+	if (IS_ERR(vddd)) {
+		/* See if it's just not registered yet */
+		if (PTR_ERR(vddd) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		external_vddd = 1;
+		regulator_put(vddd);
 	}
 
 	if (!external_vddd) {
-- 
2.8.3
