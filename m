From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: snd_soc_get_dai_name() become non static" to the asoc tree
Date: Fri, 11 Nov 2016 15:28:59 +0000
Message-ID: <E1c5DlD-0002Ab-8P@finisterre>
References: <87h98b4c30.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h98b4c30.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Guennadi <g.liakhovetski@gmx.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: snd_soc_get_dai_name() become non static

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

>From 1ad8ec535b997ed36c0f32c2616206725258dd30 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2016 01:19:28 +0000
Subject: [PATCH] ASoC: soc-core: snd_soc_get_dai_name() become non static

snd_soc_get_dai_name() is used from snd_soc_of_get_dai_name(),
and it is assuming that DT is using "sound-dai" / "#sound-dai-cells".
But graph base DT is using "remote-endpoint". This patch makes
snd_soc_get_dai_name() non static for graph support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 2 ++
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 148bf553d598..6dffa9540a30 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1666,6 +1666,8 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 				     const char *prefix,
 				     struct device_node **bitclkmaster,
 				     struct device_node **framemaster);
+int snd_soc_get_dai_name(struct of_phandle_args *args,
+			 const char **dai_name);
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name);
 int snd_soc_of_get_dai_link_codecs(struct device *dev,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ec881b8825b6..81b604151f26 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3787,7 +3787,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_daifmt);
 
-static int snd_soc_get_dai_name(struct of_phandle_args *args,
+int snd_soc_get_dai_name(struct of_phandle_args *args,
 				const char **dai_name)
 {
 	struct snd_soc_component *pos;
@@ -3839,6 +3839,7 @@ static int snd_soc_get_dai_name(struct of_phandle_args *args,
 	mutex_unlock(&client_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_get_dai_name);
 
 int snd_soc_of_get_dai_name(struct device_node *of_node,
 			    const char **dai_name)
-- 
2.10.2
