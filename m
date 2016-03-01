From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: n810: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:24:08 +0900
Message-ID: <E1aaauu-00088o-5G@finisterre>
References: <1456763182-2986-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AA4F265B93
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:30 +0100 (CET)
In-Reply-To: <1456763182-2986-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap: n810: Fix enum ctl accesses in a wrong type

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From dd90533cd6bbfe075a72ab789b6e9d6f280ba476 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:26:21 +0100
Subject: [PATCH] ASoC: omap: n810: Fix enum ctl accesses in a wrong type

"Jack Function", "Speaker Function" and "Input Select" ctls in n810
driver are enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/n810.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 190f868e78b2..fdecb7043174 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -133,7 +133,7 @@ static struct snd_soc_ops n810_ops = {
 static int n810_get_spk(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = n810_spk_func;
+	ucontrol->value.enumerated.item[0] = n810_spk_func;
 
 	return 0;
 }
@@ -143,10 +143,10 @@ static int n810_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (n810_spk_func == ucontrol->value.integer.value[0])
+	if (n810_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	n810_spk_func = ucontrol->value.integer.value[0];
+	n810_spk_func = ucontrol->value.enumerated.item[0];
 	n810_ext_control(&card->dapm);
 
 	return 1;
@@ -155,7 +155,7 @@ static int n810_set_spk(struct snd_kcontrol *kcontrol,
 static int n810_get_jack(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = n810_jack_func;
+	ucontrol->value.enumerated.item[0] = n810_jack_func;
 
 	return 0;
 }
@@ -165,10 +165,10 @@ static int n810_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (n810_jack_func == ucontrol->value.integer.value[0])
+	if (n810_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	n810_jack_func = ucontrol->value.integer.value[0];
+	n810_jack_func = ucontrol->value.enumerated.item[0];
 	n810_ext_control(&card->dapm);
 
 	return 1;
@@ -177,7 +177,7 @@ static int n810_set_jack(struct snd_kcontrol *kcontrol,
 static int n810_get_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = n810_dmic_func;
+	ucontrol->value.enumerated.item[0] = n810_dmic_func;
 
 	return 0;
 }
@@ -187,10 +187,10 @@ static int n810_set_input(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card =  snd_kcontrol_chip(kcontrol);
 
-	if (n810_dmic_func == ucontrol->value.integer.value[0])
+	if (n810_dmic_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	n810_dmic_func = ucontrol->value.integer.value[0];
+	n810_dmic_func = ucontrol->value.enumerated.item[0];
 	n810_ext_control(&card->dapm);
 
 	return 1;
-- 
2.7.0
