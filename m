From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: move rt5665_set_jack_detect to
	.set_jack" to the asoc tree
Date: Tue, 11 Apr 2017 19:37:34 +0100
Message-ID: <E1cy0fW-0004Ak-Q9@debutante>
References: <1491912467-19241-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD2E4266D8E
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:37:50 +0200 (CEST)
In-Reply-To: <1491912467-19241-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: move rt5665_set_jack_detect to .set_jack

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

>From 97c415a6f6c34b8c3a71b0e6058c89c49bb8285f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 11 Apr 2017 20:07:47 +0800
Subject: [PATCH] ASoC: rt5665: move rt5665_set_jack_detect to .set_jack

Now, we can use .set_jack callback function on codec level. So we
don't need export rt5665_set_jack_detect.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 6 +++---
 sound/soc/codecs/rt5665.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 285ec7495379..4c5f08551e05 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1260,8 +1260,8 @@ static void rt5665_jd_check_handler(struct work_struct *work)
 	}
 }
 
-int rt5665_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hs_jack)
+static int rt5665_set_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
 
@@ -1288,7 +1288,6 @@ int rt5665_set_jack_detect(struct snd_soc_codec *codec,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rt5665_set_jack_detect);
 
 static void rt5665_jack_detect_handler(struct work_struct *work)
 {
@@ -4567,6 +4566,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 	},
 	.set_sysclk = rt5665_set_codec_sysclk,
 	.set_pll = rt5665_set_codec_pll,
+	.set_jack = rt5665_set_jack_detect,
 };
 
 
diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 12f7080a0d3c..d153bba90963 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1984,7 +1984,5 @@ enum {
 
 int rt5665_sel_asrc_clk_src(struct snd_soc_codec *codec,
 		unsigned int filter_mask, unsigned int clk_src);
-int rt5665_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hs_jack);
 
 #endif /* __RT5665_H__ */
-- 
2.11.0
