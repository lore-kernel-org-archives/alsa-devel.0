From: sachinpandhare@gmail.com
Subject: [PATCH v2] ASoC: wm8962: correct addresses for HPF_C_0/1
Date: Tue, 10 Nov 2015 23:38:02 +0530
Message-ID: <1447178882-12113-1-git-send-email-sachinpandhare@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, axel.lin@ingics.com, jiada_wang@mentor.com, zidan.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Sachin Pandhare <sachinpandhare@gmail.com>

>From datasheet:
R17408 (4400h) HPF_C_1
R17409 (4401h) HPF_C_0
17048 -> 17408 (0x4400)
17049 -> 17409 (0x4401)

Signed-off-by: Sachin Pandhare <sachinpandhare@gmail.com>
---
v1 -> v2: white space removal

 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 39ebd7b..a7e7978 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -365,8 +365,8 @@ static const struct reg_default wm8962_reg[] = {
 	{ 16924, 0x0059 },   /* R16924 - HDBASS_PG_1 */
 	{ 16925, 0x999A },   /* R16925 - HDBASS_PG_0 */

-	{ 17048, 0x0083 },   /* R17408 - HPF_C_1 */
-	{ 17049, 0x98AD },   /* R17409 - HPF_C_0 */
+	{ 17408, 0x0083 },   /* R17408 - HPF_C_1 */
+	{ 17409, 0x98AD },   /* R17409 - HPF_C_0 */

 	{ 17920, 0x007F },   /* R17920 - ADCL_RETUNE_C1_1 */
 	{ 17921, 0xFFFF },   /* R17921 - ADCL_RETUNE_C1_0 */
--
1.9.1
