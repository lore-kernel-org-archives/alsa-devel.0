From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: spitz: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:24:30 +0900
Message-ID: <E1aaavG-00089x-Ts@finisterre>
References: <1456763033-2900-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE3E2657D8
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:52 +0100 (CET)
In-Reply-To: <1456763033-2900-5-git-send-email-tiwai@suse.de>
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

   ASoC: pxa: spitz: Fix enum ctl accesses in a wrong type

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

>From 49a1ba16ab15b9a572c188fe0d9d79017d2fef99 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:23:52 +0100
Subject: [PATCH] ASoC: pxa: spitz: Fix enum ctl accesses in a wrong type

"Jack Function" and "Speaker Function" ctls in spitz are enum, while
the current driver accesses wrongly via value.integer.value[].  They
have to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/spitz.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index b00222620fd0..0e02634c8b7f 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -164,7 +164,7 @@ static struct snd_soc_ops spitz_ops = {
 static int spitz_get_jack(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = spitz_jack_func;
+	ucontrol->value.enumerated.item[0] = spitz_jack_func;
 	return 0;
 }
 
@@ -173,10 +173,10 @@ static int spitz_set_jack(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (spitz_jack_func == ucontrol->value.integer.value[0])
+	if (spitz_jack_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	spitz_jack_func = ucontrol->value.integer.value[0];
+	spitz_jack_func = ucontrol->value.enumerated.item[0];
 	spitz_ext_control(&card->dapm);
 	return 1;
 }
@@ -184,7 +184,7 @@ static int spitz_set_jack(struct snd_kcontrol *kcontrol,
 static int spitz_get_spk(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = spitz_spk_func;
+	ucontrol->value.enumerated.item[0] = spitz_spk_func;
 	return 0;
 }
 
@@ -193,10 +193,10 @@ static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 
-	if (spitz_spk_func == ucontrol->value.integer.value[0])
+	if (spitz_spk_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	spitz_spk_func = ucontrol->value.integer.value[0];
+	spitz_spk_func = ucontrol->value.enumerated.item[0];
 	spitz_ext_control(&card->dapm);
 	return 1;
 }
-- 
2.7.0
