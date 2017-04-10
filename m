From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jack: add snd_soc_codec_set_jack" to
	the asoc tree
Date: Mon, 10 Apr 2017 20:22:36 +0100
Message-ID: <E1cxetY-0005l4-QH@debutante>
References: <1491535601-23808-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA3BC266CCC
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 21:22:54 +0200 (CEST)
In-Reply-To: <1491535601-23808-1-git-send-email-bardliao@realtek.com>
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

   ASoC: jack: add snd_soc_codec_set_jack

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

>From d7344010d183ad62d1ababca3beb9553cf5e1546 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 7 Apr 2017 11:26:41 +0800
Subject: [PATCH] ASoC: jack: add snd_soc_codec_set_jack

There are many codecs with the capability of jack detection. Usually,
we create a jack on machine driver but there is no common function for
machine driver to deliver the jack pointer to codec driver.
snd_soc_codec_set_jack can be used for delivering the jack pointer to
codec driver and enable the jack detection function. To make it work,
codec driver need to define a callback function to receive the jack
pointer and do all necessary procedure for enabling jack detection.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-jack.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1d20abec4995..a6d589c340df 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -434,6 +434,8 @@ int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			     int source, unsigned int freq, int dir);
 int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 			  unsigned int freq_in, unsigned int freq_out);
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+			   struct snd_soc_jack *jack, void *data);
 
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
@@ -908,6 +910,8 @@ struct snd_soc_codec_driver {
 			  int clk_id, int source, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out);
+	int (*set_jack)(struct snd_soc_codec *codec,
+			struct snd_soc_jack *jack,  void *data);
 
 	/* codec IO */
 	struct regmap *(*get_regmap)(struct device *);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index a03dcbb94baf..7daf21fee355 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -23,6 +23,24 @@
 #include <trace/events/asoc.h>
 
 /**
+ * snd_soc_codec_set_jack - configure codec jack.
+ * @codec: CODEC
+ * @jack: structure to use for the jack
+ * @data: can be used if codec driver need extra data for configuring jack
+ *
+ * Configures and enables jack detection function.
+ */
+int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack, void *data)
+{
+	if (codec->driver->set_jack)
+		return codec->driver->set_jack(codec, jack, data);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
+
+/**
  * snd_soc_card_jack_new - Create a new jack
  * @card:  ASoC card
  * @id:    an identifying string for this jack
-- 
2.11.0
