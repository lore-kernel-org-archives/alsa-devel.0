From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Add helper functions for
	component open/free" to the asoc tree
Date: Thu, 26 Apr 2018 12:53:14 +0100
Message-ID: <E1fBfSc-0007cj-Mh@debutante>
References: <20180424153903.7693-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 78717267847
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:53:21 +0200 (CEST)
In-Reply-To: <20180424153903.7693-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Add helper functions for component open/free

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1e57b82891ade3fd71c030077901808a6e5376ab Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 24 Apr 2018 16:39:03 +0100
Subject: [PATCH] ASoC: compress: Add helper functions for component open/free

There are 2 loops calling open and 4 loops calling free for all the
components on a DAI link. Factor out these loops into helper functions
to make the code a little clearer.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 141 +++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 79 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index abc00c6cc2d7..ba56f87f96d4 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -26,26 +26,14 @@
 #include <sound/initval.h>
 #include <sound/soc-dpcm.h>
 
-static int soc_compr_open(struct snd_compr_stream *cstream)
+static int soc_compr_components_open(struct snd_compr_stream *cstream,
+				     struct snd_soc_component **last)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
-
-	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
-		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
-		if (ret < 0) {
-			dev_err(cpu_dai->dev,
-				"Compress ASoC: can't open interface %s: %d\n",
-				cpu_dai->name, ret);
-			goto out;
-		}
-	}
-
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -58,10 +46,61 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 			dev_err(component->dev,
 				"Compress ASoC: can't open platform %s: %d\n",
 				component->name, ret);
-			goto machine_err;
+
+			*last = component;
+			return ret;
+		}
+	}
+
+	*last = NULL;
+	return 0;
+}
+
+static int soc_compr_components_free(struct snd_compr_stream *cstream,
+				     struct snd_soc_component *last)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		if (component == last)
+			break;
+
+		if (!component->driver->compr_ops ||
+		    !component->driver->compr_ops->free)
+			continue;
+
+		component->driver->compr_ops->free(cstream);
+	}
+
+	return 0;
+}
+
+static int soc_compr_open(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret;
+
+	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
+		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
+		if (ret < 0) {
+			dev_err(cpu_dai->dev,
+				"Compress ASoC: can't open interface %s: %d\n",
+				cpu_dai->name, ret);
+			goto out;
 		}
 	}
-	component = NULL;
+
+	ret = soc_compr_components_open(cstream, &component);
+	if (ret < 0)
+		goto machine_err;
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
 		ret = rtd->dai_link->compr_ops->startup(cstream);
@@ -80,18 +119,7 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	return 0;
 
 machine_err:
-	for_each_rtdcom(rtd, rtdcom) {
-		struct snd_soc_component *err_comp = rtdcom->component;
-
-		if (err_comp == component)
-			break;
-
-		if (!err_comp->driver->compr_ops ||
-		    !err_comp->driver->compr_ops->free)
-			continue;
-
-		err_comp->driver->compr_ops->free(cstream);
-	}
+	soc_compr_components_free(cstream, component);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -106,7 +134,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	struct snd_pcm_substream *fe_substream =
 		 fe->pcm->streams[cstream->direction].substream;
 	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
@@ -130,22 +157,9 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->open)
-			continue;
-
-		ret = component->driver->compr_ops->open(cstream);
-		if (ret < 0) {
-			dev_err(component->dev,
-				"Compress ASoC: can't open platform %s: %d\n",
-				component->name, ret);
-			goto machine_err;
-		}
-	}
-	component = NULL;
+	ret = soc_compr_components_open(cstream, &component);
+	if (ret < 0)
+		goto machine_err;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
@@ -199,18 +213,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
-	for_each_rtdcom(fe, rtdcom) {
-		struct snd_soc_component *err_comp = rtdcom->component;
-
-		if (err_comp == component)
-			break;
-
-		if (!err_comp->driver->compr_ops ||
-		    !err_comp->driver->compr_ops->free)
-			continue;
-
-		err_comp->driver->compr_ops->free(cstream);
-	}
+	soc_compr_components_free(cstream, component);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -252,8 +255,6 @@ static void close_delayed_work(struct work_struct *work)
 static int soc_compr_free(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int stream;
@@ -278,15 +279,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
 
-	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
+	soc_compr_components_free(cstream, NULL);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
@@ -316,8 +309,6 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_soc_component *component;
-	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	int stream, ret;
@@ -355,15 +346,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
 
-	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
-
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
-			continue;
-
-		component->driver->compr_ops->free(cstream);
-	}
+	soc_compr_components_free(cstream, NULL);
 
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
 		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
-- 
2.17.0
