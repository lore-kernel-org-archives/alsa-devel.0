From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/2] ASoC: dapm: Add a helper to get the
	platform for DAPM kcontrol
Date: Thu, 29 May 2014 15:33:37 +0530
Message-ID: <1401357817-17942-2-git-send-email-vinod.koul@intel.com>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id AB5DD261687
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 12:20:29 +0200 (CEST)
In-Reply-To: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Kp Jeeja <jeeja.kp@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

commit eee5d7f9 - "ASoC: dapm: Add a helper to get the CODEC for DAPM kcontrol"
introduced helper for getting codec for DAPM kcontrol. For DSPs we need similar
method to get the platform pointer while handling the widgets.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index abda467..247cd5e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -459,6 +459,8 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
+struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
+		struct snd_kcontrol *kcontrol);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d831e73..8a4a733 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -362,6 +362,17 @@ struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_codec);
 
+/**
+ * snd_soc_dapm_kcontrol_platform() - Returns the platform associated to a kcontrol
+ * @kcontrol: The kcontrol
+ */
+struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
+		struct snd_kcontrol *kcontrol)
+{
+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->platform;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_platform);
+
 static void dapm_reset(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
-- 
1.7.0.4
