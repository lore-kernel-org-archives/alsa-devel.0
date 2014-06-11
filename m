From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Convert snd_kcontrol_chip to
	snd_soc_kcontrol_codec
Date: Wed, 11 Jun 2014 12:50:58 +0100
Message-ID: <1402487458-18957-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A819E265278
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 13:58:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Controls for shaping the ultrasonic frequency response were introduced
in this commit:

commit 720630c002ffc7b0fa2ed5b3f4bfb36fd8f87ca6
ASoC: wm5102: Add controls to allow shaping of ultrasonic response

However, they mistakenly used snd_kcontrol_chip instead of
snd_soc_kcontrol_codec, which has replaced it now the framework is
moving to componentisation. This patch fixes this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 8613504..fa24d55 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -615,7 +615,7 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 	uint16_t data;
 
@@ -630,7 +630,7 @@ static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
 static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
 	mutex_lock(&codec->mutex);
@@ -645,7 +645,7 @@ static int wm5102_out_comp_coeff_put(struct snd_kcontrol *kcontrol,
 static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
 	mutex_lock(&codec->mutex);
@@ -658,7 +658,7 @@ static int wm5102_out_comp_switch_get(struct snd_kcontrol *kcontrol,
 static int wm5102_out_comp_switch_put(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
 
 	mutex_lock(&codec->mutex);
-- 
1.7.2.5
