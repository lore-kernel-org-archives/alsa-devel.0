From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: core: Add API for configuration of DAI FS
Date: Fri, 13 Sep 2013 18:09:48 +0100
Message-ID: <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2412610B8
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:10:05 +0200 (CEST)
In-Reply-To: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some codec drivers when running in slave mode require that FS is explicitly
set by the machine driver as it may not be exactly BCLK/rate.

Extend the DAI API by adding :-

int snd_soc_dai_set_fs(struct snd_soc_dai *dai, unsigned int fs);

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dai.h |  3 +++
 sound/soc/soc-core.c    | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ae9a227..06d2ce5 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -105,6 +105,8 @@ int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
 int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 	int pll_id, int source, unsigned int freq_in, unsigned int freq_out);
 
+int snd_soc_dai_set_dfs(struct snd_soc_dai *dai, unsigned int fs);
+
 /* Digital Audio interface formatting */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
 
@@ -131,6 +133,7 @@ struct snd_soc_dai_ops {
 	int (*set_pll)(struct snd_soc_dai *dai, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out);
 	int (*set_clkdiv)(struct snd_soc_dai *dai, int div_id, int div);
+	int (*set_dfs)(struct snd_soc_dai *dai, unsigned int fs);
 
 	/*
 	 * DAI format configuration
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 09e341d..90b86cc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3380,6 +3380,22 @@ int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
 
 /**
+ * snd_soc_dai_set_dfs - configure DAI FS.
+ * @dai: DAI
+ * @fs Ration of BCLK to Sample rate
+ *
+ * Configures the DAI for a preset FS.
+ */
+int snd_soc_dai_set_dfs(struct snd_soc_dai *dai, unsigned int fs)
+{
+	if (dai->driver && dai->driver->ops->set_dfs)
+		return dai->driver->ops->set_dfs(dai, fs);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_dfs);
+
+/**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
  * @fmt: SND_SOC_DAIFMT_ format value.
-- 
1.8.1.2
