From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: add api for dapm kcontrol
	configiuration
Date: Mon, 26 May 2014 17:38:55 +0530
Message-ID: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EFE382650E4
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 14:25:28 +0200 (CEST)
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

For DSPs we need to set and get the value for snd_kcontrol. This is currently
done by dapm_kcontrol_set/get_value, so create a wrapper
snd_soc_dapm_kcontrol_get/set_value APIs to let drivers use this

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h |    4 ++++
 sound/soc/soc-dapm.c     |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 75020f5..9e826e9 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -368,6 +368,10 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
 int dapm_clock_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
+bool snd_soc_dapm_kcontrol_set_value(
+		const struct snd_kcontrol *kcontrol, unsigned int value);
+unsigned int snd_soc_dapm_kcontrol_get_value(
+		const struct snd_kcontrol *kcontrol);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 98c1dc6..b7dfa1a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -333,6 +333,12 @@ static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
 
 	return data->value;
 }
+unsigned int snd_soc_dapm_kcontrol_get_value(
+	const struct snd_kcontrol *kcontrol)
+{
+	dapm_kcontrol_get_value(kcontrol);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_get_value);
 
 static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	unsigned int value)
@@ -350,6 +356,13 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	return true;
 }
 
+bool snd_soc_dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+	unsigned int value)
+{
+	return dapm_kcontrol_set_value(kcontrol, value);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_set_value);
+
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
-- 
1.7.0.4
