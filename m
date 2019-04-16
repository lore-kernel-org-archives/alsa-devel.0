From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: atmel: tse850: Make some functions static
Date: Tue, 16 Apr 2019 22:47:18 +0800
Message-ID: <20190416144718.25576-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, codrin.ciubotariu@microchip.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

sound/soc/atmel/tse850-pcm5142.c:120:5: warning: symbol 'tse850_get_mix' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:132:5: warning: symbol 'tse850_put_mix' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:154:5: warning: symbol 'tse850_get_ana' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:187:5: warning: symbol 'tse850_put_ana' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/atmel/tse850-pcm5142.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 214adca..ae44518 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -117,8 +117,8 @@ static int tse850_put_mux2(struct snd_kcontrol *kctrl,
 	return snd_soc_dapm_put_enum_double(kctrl, ucontrol);
 }
 
-int tse850_get_mix(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_get_mix(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -129,8 +129,8 @@ int tse850_get_mix(struct snd_kcontrol *kctrl,
 	return 0;
 }
 
-int tse850_put_mix(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_put_mix(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -151,8 +151,8 @@ int tse850_put_mix(struct snd_kcontrol *kctrl,
 	return 1;
 }
 
-int tse850_get_ana(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_get_ana(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -184,8 +184,8 @@ int tse850_get_ana(struct snd_kcontrol *kctrl,
 	return 0;
 }
 
-int tse850_put_ana(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_put_ana(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
-- 
2.7.4
