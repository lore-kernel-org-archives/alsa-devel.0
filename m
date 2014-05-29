From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: export dapm_kcontrol_set/get_value
	functions
Date: Thu, 29 May 2014 15:32:46 +0530
Message-ID: <1401357767-17907-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C14260851
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 12:19:42 +0200 (CEST)
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

The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So when DAPM
triggers the widget, the DSP needs to know the kcontrol values and pass on to DSP
firmware, so export these for driver use

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h |    3 +++
 sound/soc/soc-dapm.c     |    6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 75020f5..abda467 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -368,6 +368,9 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
 int dapm_clock_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
+bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+			unsigned int value);
+unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 98c1dc6..d831e73 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -327,14 +327,15 @@ static struct list_head *dapm_kcontrol_get_path_list(
 	list_for_each_entry(path, dapm_kcontrol_get_path_list(kcontrol), \
 		list_kcontrol)
 
-static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
+unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
 
 	return data->value;
 }
+EXPORT_SYMBOL_GPL(dapm_kcontrol_get_value);
 
-static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	unsigned int value)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
@@ -349,6 +350,7 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(dapm_kcontrol_set_value);
 
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
-- 
1.7.0.4
