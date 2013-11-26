From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv1] ASoC: SGTL5000: Fix kernel failed while
	getting regulator consumers
Date: Tue, 26 Nov 2013 17:55:13 +0800
Message-ID: <1385459713-6778-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B3A32608E8
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 11:42:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SGTL5000 codec allows to use the internal LDO instead of VDDD, if the
internal LDO is used, this caused the following kernel failed while trying
to get the external VDDD regulator consumer.

Adding sgtl5000_external_vddd_used() to fix it. And this has been tested on
VF610-TWR board.

sgtl5000 0-000a: Failed to get supply 'VDDD': -19

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

 sound/soc/codecs/sgtl5000.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1f4093f..1a2d35a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1298,6 +1298,20 @@ static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int sgtl5000_external_vddd_used(struct snd_soc_codec *codec)
+{
+	struct regulator *consumer;
+	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
+
+	consumer = regulator_get(codec->dev, sgtl5000->supplies[VDDD].supply);
+	if (IS_ERR(consumer)) {
+		return 0;
+	}
+	regulator_put(consumer);
+
+	return 1;
+}
+
 static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 {
 	int reg;
@@ -1310,9 +1324,7 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
 		sgtl5000->supplies[i].supply = supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	if (!ret)
+	if (sgtl5000_external_vddd_used(codec))
 		external_vddd = 1;
 	else {
 		ret = sgtl5000_replace_vddd_with_ldo(codec);
-- 
1.8.4
