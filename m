From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: add soc_pcm_components_open()"
	to the asoc tree
Date: Mon, 13 May 2019 13:30:26 +0100 (BST)
Message-ID: <20190513123026.470341129233@debutante.sirena.org.uk>
References: <87lfzaalpn.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1698F89633
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87lfzaalpn.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: add soc_pcm_components_open()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From e7ecfdb794fef1f6c91f62a40fd6aa3d4d8d2471 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:08:33 +0900
Subject: [PATCH] ASoC: soc-pcm: add soc_pcm_components_open()

soc-pcm.c has soc_pcm_components_close() but not have its open()
side function. This kind of unbalance function is very unreadable.

And, current error handling is not correct.
Because it is using for_each_rtdcom() loop, we need to call
soc_pcm_components_close() anyway even though
CPU DAI .startup() failed.

This patch adds soc_pcm_components_open(), and fixup error
handling issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 63 ++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2dcc44c73f6c..74c7d38af2c6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -446,6 +446,42 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
 }
 
+static int soc_pcm_components_open(struct snd_pcm_substream *substream,
+				   struct snd_soc_component **last)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_component *component;
+	int ret = 0;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+		*last = component;
+
+		if (!component->driver->ops ||
+		    !component->driver->ops->open)
+			continue;
+
+		if (component->driver->module_get_upon_open &&
+		    !try_module_get(component->dev->driver->owner)) {
+			dev_err(component->dev,
+				"ASoC: can't get module %s\n",
+				component->name);
+			return -ENODEV;
+		}
+
+		ret = component->driver->ops->open(substream);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"ASoC: can't open component %s: %d\n",
+				component->name, ret);
+			return ret;
+		}
+	}
+	*last = NULL;
+	return 0;
+}
+
 static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 				    struct snd_soc_component *last)
 {
@@ -510,28 +546,9 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->ops ||
-		    !component->driver->ops->open)
-			continue;
-
-		if (component->driver->module_get_upon_open &&
-		    !try_module_get(component->dev->driver->owner)) {
-			ret = -ENODEV;
-			goto module_err;
-		}
-
-		ret = component->driver->ops->open(substream);
-		if (ret < 0) {
-			dev_err(component->dev,
-				"ASoC: can't open component %s: %d\n",
-				component->name, ret);
-			goto component_err;
-		}
-	}
-	component = NULL;
+	ret = soc_pcm_components_open(substream, &component);
+	if (ret < 0)
+		goto component_err;
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
 		if (codec_dai->driver->ops->startup) {
@@ -638,7 +655,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 
 component_err:
 	soc_pcm_components_close(substream, component);
-module_err:
+
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 out:
-- 
2.20.1
