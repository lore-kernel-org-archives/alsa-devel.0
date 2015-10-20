From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/3] ASoC: dapm: Add
	snd_soc_dapm_kcontrol_widget()
Date: Tue, 20 Oct 2015 22:30:08 +0530
Message-ID: <1445360408-3478-4-git-send-email-vinod.koul@intel.com>
References: <1445360408-3478-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A2026661D
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 18:57:06 +0200 (CEST)
In-Reply-To: <1445360408-3478-1-git-send-email-vinod.koul@intel.com>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Mythri P K <mythri.p.k@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mythri P K <mythri.p.k@intel.com>

Given a kcontrol, we may want to access the parent widget
and it's associated data. So export function to return it.

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h |  3 +++
 sound/soc/soc-dapm.c     | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5abba037d245..7855cfe46b69 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -451,6 +451,9 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
 	struct snd_kcontrol *kcontrol);
 
+struct snd_soc_dapm_widget *snd_soc_dapm_kcontrol_widget(
+		struct snd_kcontrol *kcontrol);
+
 int snd_soc_dapm_force_bias_level(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_bias_level level);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 352cddf84b1f..016eba10b1ec 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -509,6 +509,18 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 }
 
 /**
+ * snd_soc_dapm_kcontrol_widget() - Returns the widget associated to a
+ *   kcontrol
+ * @kcontrol: The kcontrol
+ */
+struct snd_soc_dapm_widget *snd_soc_dapm_kcontrol_widget(
+				struct snd_kcontrol *kcontrol)
+{
+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0];
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_widget);
+
+/**
  * snd_soc_dapm_kcontrol_dapm() - Returns the dapm context associated to a
  *  kcontrol
  * @kcontrol: The kcontrol
-- 
1.9.1
