From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ASoC: Provide a dummy wrapper of
	snd_soc_set_dmi_name()
Date: Mon, 24 Apr 2017 08:54:41 +0200
Message-ID: <20170424065442.13490-2-tiwai@suse.de>
References: <20170424065442.13490-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A87C22668A2
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 08:54:44 +0200 (CEST)
In-Reply-To: <20170424065442.13490-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For systems without DMI, it makes no sense to have the code.

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h  | 8 ++++++++
 sound/soc/soc-core.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cdfb55f7aede..915c06cb2b32 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -497,7 +497,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt);
 
+#ifdef CONFIG_DMI
 int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour);
+#else
+static inline int snd_soc_set_dmi_name(struct snd_soc_card *card,
+				       const char *flavour)
+{
+	return 0;
+}
+#endif
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2722bb0c5573..aac73ff8a92a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1918,6 +1918,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
 
+#ifdef CONFIG_DMI
 /* Trim special characters, and replace '-' with '_' since '-' is used to
  * separate different DMI fields in the card long name. Only number and
  * alphabet characters and a few separator characters are kept.
@@ -2049,6 +2050,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
+#endif /* CONFIG_DMI */
 
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
-- 
2.11.1
