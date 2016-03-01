From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: rx51: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:42 +0900
Message-ID: <E1aaauU-00088C-LF@finisterre>
References: <1456763182-2986-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1322A265964
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:17 +0100 (CET)
In-Reply-To: <1456763182-2986-3-git-send-email-tiwai@suse.de>
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

   ASoC: omap: rx51: Fix enum ctl accesses in a wrong type

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

>From f4d438eec7fe56d55998195e08dfaa5aa3e08f0c Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:26:22 +0100
Subject: [PATCH] ASoC: omap: rx51: Fix enum ctl accesses in a wrong type

"Speaker Function", "Input Select" and "Jack Function" ctls in rx51
driver are enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/rx51.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 5e21f08579d8..54949242bc70 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -132,7 +132,7 @@ static struct snd_soc_ops rx51_ops = {
 static int rx51_get_spk(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = rx51_spk_func;
+	ucontrol->value.enumerated.item[0] = rx51_spk_func;
 
 	return 0;
 }
@@ -142,10 +142,10 @@ static int rx51_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (rx51_spk_func == ucontrol->value.integer.value[0])
+	if (rx51_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	rx51_spk_func = ucontrol->value.integer.value[0];
+	rx51_spk_func = ucontrol->value.enumerated.item[0];
 	rx51_ext_control(&card->dapm);
 
 	return 1;
@@ -180,7 +180,7 @@ static int rx51_hp_event(struct snd_soc_dapm_widget *w,
 static int rx51_get_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = rx51_dmic_func;
+	ucontrol->value.enumerated.item[0] = rx51_dmic_func;
 
 	return 0;
 }
@@ -190,10 +190,10 @@ static int rx51_set_input(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (rx51_dmic_func == ucontrol->value.integer.value[0])
+	if (rx51_dmic_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	rx51_dmic_func = ucontrol->value.integer.value[0];
+	rx51_dmic_func = ucontrol->value.enumerated.item[0];
 	rx51_ext_control(&card->dapm);
 
 	return 1;
@@ -202,7 +202,7 @@ static int rx51_set_input(struct snd_kcontrol *kcontrol,
 static int rx51_get_jack(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = rx51_jack_func;
+	ucontrol->value.enumerated.item[0] = rx51_jack_func;
 
 	return 0;
 }
@@ -212,10 +212,10 @@ static int rx51_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (rx51_jack_func == ucontrol->value.integer.value[0])
+	if (rx51_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	rx51_jack_func = ucontrol->value.integer.value[0];
+	rx51_jack_func = ucontrol->value.enumerated.item[0];
 	rx51_ext_control(&card->dapm);
 
 	return 1;
-- 
2.7.0
