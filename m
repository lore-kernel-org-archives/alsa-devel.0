From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: pcm: Staticise non-exported functions
Date: Wed,  9 May 2012 21:47:30 +0100
Message-ID: <1336596450-28653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C239103E5D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 22:56:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They pollute the global namespace and cause sparse to complain.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a3ea8a7..82766af 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -632,7 +632,8 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream, int cmd)
+static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
+				   int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
@@ -1087,7 +1088,7 @@ unwind:
 	return err;
 }
 
-void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
+static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -1247,7 +1248,7 @@ static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 	return 0;
 }
 
-int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
+static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	int err, stream = substream->stream;
@@ -1354,8 +1355,8 @@ unwind:
 	return ret;
 }
 
-int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
-				    struct snd_pcm_hw_params *params)
+static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	int ret, stream = substream->stream;
@@ -1404,7 +1405,8 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 	return ret;
 }
 
-int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream, int cmd)
+static int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
+			       int cmd)
 {
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
@@ -1497,7 +1499,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream, int cmd)
 }
 EXPORT_SYMBOL_GPL(dpcm_be_dai_trigger);
 
-int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
+static int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	int stream = substream->stream, ret;
@@ -1605,7 +1607,7 @@ static int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 	return ret;
 }
 
-int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
+static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	int stream = substream->stream, ret = 0;
@@ -1935,7 +1937,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 	return 0;
 }
 
-int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
+static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 {
 	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
 	struct snd_soc_dpcm *dpcm;
@@ -1972,7 +1974,7 @@ int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	return ret;
 }
 
-int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
+static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 {
 	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
 	struct snd_soc_dpcm *dpcm;
-- 
1.7.10
