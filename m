From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v5 08/12] ASoC: Export dapm_kcontrol_get_value
Date: Tue,  2 Sep 2014 18:06:03 +0530
Message-ID: <1409661367-19047-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A331F2654FA
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 14:58:46 +0200 (CEST)
In-Reply-To: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DSP driver needs to know widget control value in its event handler for
widgets like mixers. This is required in the subsequent patches

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-dapm.h | 1 +
 sound/soc/soc-dapm.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index aac04ff..6ae0a19 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -432,6 +432,7 @@ int snd_soc_dapm_force_enable_pin_unlocked(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
 void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card);
+unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol);
 
 /* Mostly internal - should not normally be used */
 void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 177bd86..c5b9862 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -326,12 +326,13 @@ static struct list_head *dapm_kcontrol_get_path_list(
 	list_for_each_entry(path, dapm_kcontrol_get_path_list(kcontrol), \
 		list_kcontrol)
 
-static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
+unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
 
 	return data->value;
 }
+EXPORT_SYMBOL_GPL(dapm_kcontrol_get_value);
 
 static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	unsigned int value)
-- 
1.9.0
