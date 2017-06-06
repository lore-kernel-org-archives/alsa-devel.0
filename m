From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Fix build by declaring
	snd_kcontrol_new and soc_dai_link.
Date: Tue,  6 Jun 2017 15:45:06 +0100
Message-ID: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id AA5F5266F0E
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:45:19 +0200 (CEST)
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

Both are used within this header so need to be declared.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-topology.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index f9cc7b9271ac..7ea2794e1c6a 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -28,6 +28,8 @@ struct snd_soc_component;
 struct snd_soc_tplg_pcm_fe;
 struct snd_soc_dapm_context;
 struct snd_soc_card;
+struct snd_kcontrol_new;
+struct snd_soc_dai_link;
 
 /* object scan be loaded and unloaded in groups with identfying indexes */
 #define SND_SOC_TPLG_INDEX_ALL	0	/* ID that matches all FW objects */
@@ -116,12 +118,16 @@ struct snd_soc_tplg_ops {
 	int (*widget_load)(struct snd_soc_component *,
 		struct snd_soc_dapm_widget *,
 		struct snd_soc_tplg_dapm_widget *);
+	int (*widget_ready)(struct snd_soc_component *,
+		struct snd_soc_dapm_widget *,
+		struct snd_soc_tplg_dapm_widget *);
 	int (*widget_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* FE DAI - used for any driver specific init */
 	int (*dai_load)(struct snd_soc_component *,
-		struct snd_soc_dai_driver *dai_drv);
+		struct snd_soc_dai_driver *dai_drv,
+		struct snd_soc_tplg_pcm *pcm, struct snd_soc_dai *dai);
 	int (*dai_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
-- 
2.11.0
