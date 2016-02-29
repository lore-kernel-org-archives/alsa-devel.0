From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ASoC: pxa: corgi: Fix enum ctl accesses in
	a wrong type
Date: Mon, 29 Feb 2016 17:23:49 +0100
Message-ID: <1456763033-2900-2-git-send-email-tiwai@suse.de>
References: <1456763033-2900-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 544902659FF
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

"Jack Function" and "Speaker Function" ctls in corgi are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/pxa/corgi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index c97dc13d3608..dcbb7aa9830c 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -163,7 +163,7 @@ static struct snd_soc_ops corgi_ops = {
 static int corgi_get_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = corgi_jack_func;
+	ucontrol->value.enumerated.item[0] = corgi_jack_func;
 	return 0;
 }
 
@@ -172,10 +172,10 @@ static int corgi_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (corgi_jack_func == ucontrol->value.integer.value[0])
+	if (corgi_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	corgi_jack_func = ucontrol->value.integer.value[0];
+	corgi_jack_func = ucontrol->value.enumerated.item[0];
 	corgi_ext_control(&card->dapm);
 	return 1;
 }
@@ -183,7 +183,7 @@ static int corgi_set_jack(struct snd_kcontrol *kcontrol,
 static int corgi_get_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = corgi_spk_func;
+	ucontrol->value.enumerated.item[0] = corgi_spk_func;
 	return 0;
 }
 
@@ -192,10 +192,10 @@ static int corgi_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (corgi_spk_func == ucontrol->value.integer.value[0])
+	if (corgi_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	corgi_spk_func = ucontrol->value.integer.value[0];
+	corgi_spk_func = ucontrol->value.enumerated.item[0];
 	corgi_ext_control(&card->dapm);
 	return 1;
 }
-- 
2.7.2
