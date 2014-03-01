From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm{5102, 5110,
	8997}: Replace codec->control_data with arizona->regmap
Date: Sat,  1 Mar 2014 13:45:32 +0100
Message-ID: <1393677932-17336-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CD4B26531F
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 13:45:10 +0100 (CET)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

With the ongoing component-ization of the ASoC framework and the continuing
migration to using regmap for IO the control_data field of the snd_soc_codec
struct will eventually be removed. Prepare the wm5192, wm5110 and wm8997
drivers for this by using arizona->regmap instead of accessing the CODEC's
control_data field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5102.c | 2 +-
 sound/soc/codecs/wm5110.c | 2 +-
 sound/soc/codecs/wm8997.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 293dffc..3410905 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -582,7 +582,7 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
-	struct regmap *regmap = codec->control_data;
+	struct regmap *regmap = arizona->regmap;
 	const struct reg_default *patch = NULL;
 	int i, patch_size;
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 4de2bf1..d7bf884 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -136,7 +136,7 @@ static int wm5110_sysclk_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
-	struct regmap *regmap = codec->control_data;
+	struct regmap *regmap = arizona->regmap;
 	const struct reg_default *patch = NULL;
 	int i, patch_size;
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 4e6442c..e10f44d 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -86,7 +86,7 @@ static int wm8997_sysclk_ev(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
-	struct regmap *regmap = codec->control_data;
+	struct regmap *regmap = arizona->regmap;
 	const struct reg_default *patch = NULL;
 	int i, patch_size;
 
-- 
1.8.0
