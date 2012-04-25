From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 5/5] ASoC: dpcm: Add API for DAI link substream
	and runtime lookup
Date: Wed, 25 Apr 2012 12:12:53 +0100
Message-ID: <1335352373-5237-5-git-send-email-lrg@ti.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id AA3071048AD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 13:13:51 +0200 (CEST)
Received: by wgbgn7 with SMTP id gn7so1836218wgb.9
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 04:13:49 -0700 (PDT)
In-Reply-To: <1335352373-5237-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Some component drivers will need to be able to look up their
DAI link substream and RTD data. Provide a mechanism for this.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a7f62d5..c573a87 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -349,6 +349,11 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 
+struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
+		const char *dai_link, int stream);
+struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
+		const char *dai_link);
+
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a25ba6f..511e70b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -465,6 +465,35 @@ static inline void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 }
 #endif
 
+struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
+		const char *dai_link, int stream)
+{
+	int i;
+
+	for (i = 0; i < card->num_links; i++) {
+		if (card->rtd[i].dai_link->no_pcm &&
+			!strcmp(card->rtd[i].dai_link->name, dai_link))
+			return card->rtd[i].pcm->streams[stream].substream;
+	}
+	dev_dbg(card->dev, "failed to find dai link %s\n", dai_link);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_dai_substream);
+
+struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
+		const char *dai_link)
+{
+	int i;
+
+	for (i = 0; i < card->num_links; i++) {
+		if (!strcmp(card->rtd[i].dai_link->name, dai_link))
+			return &card->rtd[i];
+	}
+	dev_dbg(card->dev, "failed to find rtd %s\n", dai_link);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
+
 #ifdef CONFIG_SND_SOC_AC97_BUS
 /* unregister ac97 codec */
 static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
-- 
1.7.5.4
