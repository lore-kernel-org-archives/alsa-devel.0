From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 10/11] ASoC: dapm: Export snd_soc_dapm_new_control
Date: Mon, 27 Jun 2016 09:18:03 +0530
Message-ID: <1466999284-14782-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F2B4C2664F7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:55 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This is useful outside the core, when one dapm element is added
at a time.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h | 3 +++
 sound/soc/soc-dapm.c     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index fffd1f1..6e24f00 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -381,6 +381,9 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
+struct snd_soc_dapm_widget *snd_soc_dapm_new_control(
+		struct snd_soc_dapm_context *dapm,
+		const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ad67647..963c115a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3303,6 +3303,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	mutex_unlock(&dapm->card->dapm_mutex);
 	return w;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
-- 
1.9.1
