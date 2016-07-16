From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_set_dailink_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:04:26 +0100
Message-ID: <E1bOOKY-0004vm-Px@debutante>
References: <87eg6zn3a5.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87eg6zn3a5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_set_dailink_name()

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

>From 1db3312e3ab1a776ae8f414640dd7c180ce38a75 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:57:14 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_set_dailink_name()

Current simple-card is creating dai_link->name / dai_link->stream_name.
These are based on CPU + Codec name, or "fe.CPU" or "be.Codec" if it
was DPCM.
This patch adds asoc_simple_card_set_dailink_name() and set dailink
name as common method.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  3 +++
 sound/soc/generic/simple-card-utils.c | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 50aa7b22a94c..b88a8dcfe4ba 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -27,5 +27,8 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *codec,
 				  char *prefix,
 				  unsigned int *retfmt);
+int asoc_simple_card_set_dailink_name(struct device *dev,
+				      struct snd_soc_dai_link *dai_link,
+				      const char *fmt, ...);
 
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3f6b72526f71..48c73660b66a 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -52,3 +52,26 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_daifmt);
+
+int asoc_simple_card_set_dailink_name(struct device *dev,
+				      struct snd_soc_dai_link *dai_link,
+				      const char *fmt, ...)
+{
+	va_list ap;
+	char *name = NULL;
+	int ret = -ENOMEM;
+
+	va_start(ap, fmt);
+	name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
+	va_end(ap);
+
+	if (name) {
+		ret = 0;
+
+		dai_link->name		= name;
+		dai_link->stream_name	= name;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_set_dailink_name);
-- 
2.8.1
