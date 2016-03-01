From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: tosa: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:24:15 +0900
Message-ID: <E1aaav1-00089L-Ny@finisterre>
References: <1456763033-2900-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFFE826526E
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:37 +0100 (CET)
In-Reply-To: <1456763033-2900-6-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: tosa: Fix enum ctl accesses in a wrong type

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

>From 419396d5a1d12003a18a58785687697800d2f02a Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:23:53 +0100
Subject: [PATCH] ASoC: pxa: tosa: Fix enum ctl accesses in a wrong type

"Jack Function" and "Speaker Function" ctls in tosa are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0
