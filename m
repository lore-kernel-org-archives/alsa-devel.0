From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: dapm: Add a helper to get the
	platform for DAPM kcontrol
Date: Mon, 26 May 2014 17:38:56 +0530
Message-ID: <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E26F2650F2
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 14:25:29 +0200 (CEST)
In-Reply-To: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
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

commit eee5d7f9 introduced helper for getting codec for DAPM kcontrol, for DSPs
we need similar stuff for platforms as well

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9e826e9..9f47dee 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -460,6 +460,8 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
+struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
+		struct snd_kcontrol *kcontrol);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b7dfa1a..f37ca16 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -373,6 +373,17 @@ struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
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
