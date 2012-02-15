From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Convert pin switches to use
	snd_soc_card
Date: Tue, 14 Feb 2012 17:12:20 -0800
Message-ID: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C075510392F
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 02:12:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the addition of the non-CODEC control adds card controls like the
DAPM pin switch have been broken as they are expecting the private data
for the control to be the CODEC but it's now the card. Fix that for the
pin switches, an audit of other drivers is required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6fc488e..9b796e3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2644,15 +2644,15 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_info_pin_switch);
 int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&card->mutex);
 
 	ucontrol->value.integer.value[0] =
-		snd_soc_dapm_get_pin_status(&codec->dapm, pin);
+		snd_soc_dapm_get_pin_status(&card->dapm, pin);
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 
 	return 0;
 }
@@ -2667,19 +2667,19 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_switch);
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&card->mutex);
 
 	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_enable_pin(&codec->dapm, pin);
+		snd_soc_dapm_enable_pin(&card->dapm, pin);
 	else
-		snd_soc_dapm_disable_pin(&codec->dapm, pin);
+		snd_soc_dapm_disable_pin(&card->dapm, pin);
 
-	snd_soc_dapm_sync(&codec->dapm);
+	snd_soc_dapm_sync(&card->dapm);
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 
 	return 0;
 }
-- 
1.7.9.rc1
