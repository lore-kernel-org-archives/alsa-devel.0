From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ASoC: pxa: poodle: Fix enum ctl accesses
	in a wrong type
Date: Mon, 29 Feb 2016 17:23:51 +0100
Message-ID: <1456763033-2900-4-git-send-email-tiwai@suse.de>
References: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38899265961
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

"Jack Function" and "Speaker Function" ctls in poodle are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/pxa/poodle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 84d0e2e50808..4b3b714f5ee7 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -138,7 +138,7 @@ static struct snd_soc_ops poodle_ops = {
 static int poodle_get_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = poodle_jack_func;
+	ucontrol->value.enumerated.item[0] = poodle_jack_func;
 	return 0;
 }
 
@@ -147,10 +147,10 @@ static int poodle_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (poodle_jack_func == ucontrol->value.integer.value[0])
+	if (poodle_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	poodle_jack_func = ucontrol->value.integer.value[0];
+	poodle_jack_func = ucontrol->value.enumerated.item[0];
 	poodle_ext_control(&card->dapm);
 	return 1;
 }
@@ -158,7 +158,7 @@ static int poodle_set_jack(struct snd_kcontrol *kcontrol,
 static int poodle_get_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = poodle_spk_func;
+	ucontrol->value.enumerated.item[0] = poodle_spk_func;
 	return 0;
 }
 
@@ -167,10 +167,10 @@ static int poodle_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (poodle_spk_func == ucontrol->value.integer.value[0])
+	if (poodle_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	poodle_spk_func = ucontrol->value.integer.value[0];
+	poodle_spk_func = ucontrol->value.enumerated.item[0];
 	poodle_ext_control(&card->dapm);
 	return 1;
 }
-- 
2.7.2
