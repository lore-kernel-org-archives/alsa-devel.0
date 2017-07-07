From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Optimize the Jack Type
	detection" to the asoc tree
Date: Fri, 07 Jul 2017 13:52:35 +0100
Message-ID: <E1dTSkN-0002qa-Jr@finisterre>
References: <1499417939-319-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 665FE267214
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:52:45 +0200 (CEST)
In-Reply-To: <1499417939-319-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Optimize the Jack Type detection

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fa8b3b6a5a081697e7158687c7803020040c7d2e Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 7 Jul 2017 16:58:58 +0800
Subject: [PATCH] ASoC: rt5663: Optimize the Jack Type detection

The patch optimizes the Jack Type detection.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 18b3b526b7c5..ebd9ae00e04d 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1508,7 +1508,7 @@ static int rt5663_v2_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 {
 	struct rt5663_priv *rt5663 = snd_soc_codec_get_drvdata(codec);
-	int val, i = 0, sleep_time[5] = {300, 150, 100, 50, 30};
+	int val, i = 0;
 
 	dev_dbg(codec->dev, "%s jack_insert:%d\n", __func__, jack_insert);
 
@@ -1543,17 +1543,22 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
 		snd_soc_update_bits(codec, RT5663_IRQ_1,
 			RT5663_EN_IRQ_JD1_MASK, RT5663_EN_IRQ_JD1_EN);
-		while (i < 5) {
-			msleep(sleep_time[i]);
-			val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) &
-				0x0003;
-			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
-				__func__, val, sleep_time[i]);
-			i++;
-			if (val == 0x1 || val == 0x2 || val == 0x3)
+
+		while (true) {
+			regmap_read(rt5663->regmap, RT5663_INT_ST_2, &val);
+			if (!(val & 0x80))
+				usleep_range(10000, 10005);
+			else
+				break;
+
+			if (i > 200)
 				break;
+			i++;
 		}
+
+		val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) & 0x0003;
 		dev_dbg(codec->dev, "%s val = %d\n", __func__, val);
+
 		switch (val) {
 		case 1:
 		case 2:
-- 
2.13.2
