From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ASoC: pxa: tosa: Fix enum ctl accesses in
	a wrong type
Date: Mon, 29 Feb 2016 17:23:53 +0100
Message-ID: <1456763033-2900-6-git-send-email-tiwai@suse.de>
References: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B06C265914
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:23:57 +0100 (CET)
In-Reply-To: <1456763033-2900-1-git-send-email-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

"Jack Function" and "Speaker Function" ctls in tosa are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/pxa/tosa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 49518dd642aa..c508f024ecfb 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -95,7 +95,7 @@ static struct snd_soc_ops tosa_ops = {
 static int tosa_get_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = tosa_jack_func;
+	ucontrol->value.enumerated.item[0] = tosa_jack_func;
 	return 0;
 }
 
@@ -104,10 +104,10 @@ static int tosa_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (tosa_jack_func == ucontrol->value.integer.value[0])
+	if (tosa_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	tosa_jack_func = ucontrol->value.integer.value[0];
+	tosa_jack_func = ucontrol->value.enumerated.item[0];
 	tosa_ext_control(&card->dapm);
 	return 1;
 }
@@ -115,7 +115,7 @@ static int tosa_set_jack(struct snd_kcontrol *kcontrol,
 static int tosa_get_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = tosa_spk_func;
+	ucontrol->value.enumerated.item[0] = tosa_spk_func;
 	return 0;
 }
 
@@ -124,10 +124,10 @@ static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (tosa_spk_func == ucontrol->value.integer.value[0])
+	if (tosa_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	tosa_spk_func = ucontrol->value.integer.value[0];
+	tosa_spk_func = ucontrol->value.enumerated.item[0];
 	tosa_ext_control(&card->dapm);
 	return 1;
 }
-- 
2.7.2
