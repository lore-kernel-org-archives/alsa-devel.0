From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: mop500_ab8500: Use card DAPM context to
	access widgets
Date: Sat, 11 Apr 2015 13:01:02 +0200
Message-ID: <1428750062-10614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 64E7E260867
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 13:01:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/mop500_ab8500.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index aa65370..b81a7a4c 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -362,7 +362,7 @@ struct snd_soc_ops mop500_ab8500_ops[] = {
 
 int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 	struct device *dev = rtd->card->dev;
 	struct mop500_ab8500_drvdata *drvdata;
 	int ret;
@@ -407,23 +407,23 @@ int mop500_ab8500_machine_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_dapm_disable_pin(&codec->dapm, "Earpiece");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Speaker Left");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Speaker Right");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineOut Left");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineOut Right");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Vibra 1");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Vibra 2");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Mic 1");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "Mic 2");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineIn Left");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "LineIn Right");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 1");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 2");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 3");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 4");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 5");
-	ret |= snd_soc_dapm_disable_pin(&codec->dapm, "DMic 6");
+	ret = snd_soc_dapm_disable_pin(dapm, "Earpiece");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Speaker Left");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Speaker Right");
+	ret |= snd_soc_dapm_disable_pin(dapm, "LineOut Left");
+	ret |= snd_soc_dapm_disable_pin(dapm, "LineOut Right");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Vibra 1");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Vibra 2");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Mic 1");
+	ret |= snd_soc_dapm_disable_pin(dapm, "Mic 2");
+	ret |= snd_soc_dapm_disable_pin(dapm, "LineIn Left");
+	ret |= snd_soc_dapm_disable_pin(dapm, "LineIn Right");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 1");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 2");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 3");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 4");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 5");
+	ret |= snd_soc_dapm_disable_pin(dapm, "DMic 6");
 
 	return ret;
 }
-- 
1.8.0
