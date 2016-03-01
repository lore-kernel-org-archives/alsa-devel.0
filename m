From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: mfld: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:35 +0900
Message-ID: <E1aaauN-00087h-D4@finisterre>
References: <1456763365-3123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BBF826627C
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:11 +0100 (CET)
In-Reply-To: <1456763365-3123-1-git-send-email-tiwai@suse.de>
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

   ASoC: intel: mfld: Fix enum ctl accesses in a wrong type

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

>From 508ddfba37cad76d774da8f8d8e2387f0eca5fa4 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:29:25 +0100
Subject: [PATCH] ASoC: intel: mfld: Fix enum ctl accesses in a wrong type

"Playback Switch" and "Lineout Mux" ctls in medfld machine driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/mfld_machine.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 49c09a0add79..34f46c72a0e2 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -94,7 +94,7 @@ static const struct soc_enum lo_enum =
 static int headset_get_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = hs_switch;
+	ucontrol->value.enumerated.item[0] = hs_switch;
 	return 0;
 }
 
@@ -104,12 +104,12 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_context *dapm = &card->dapm;
 
-	if (ucontrol->value.integer.value[0] == hs_switch)
+	if (ucontrol->value.enumerated.item[0] == hs_switch)
 		return 0;
 
 	snd_soc_dapm_mutex_lock(dapm);
 
-	if (ucontrol->value.integer.value[0]) {
+	if (ucontrol->value.enumerated.item[0]) {
 		pr_debug("hs_set HS path\n");
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Headphones");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "EPOUT");
@@ -123,7 +123,7 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mutex_unlock(dapm);
 
-	hs_switch = ucontrol->value.integer.value[0];
+	hs_switch = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -148,7 +148,7 @@ static void lo_enable_out_pins(struct snd_soc_dapm_context *dapm)
 static int lo_get_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = lo_dac;
+	ucontrol->value.enumerated.item[0] = lo_dac;
 	return 0;
 }
 
@@ -158,7 +158,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_context *dapm = &card->dapm;
 
-	if (ucontrol->value.integer.value[0] == lo_dac)
+	if (ucontrol->value.enumerated.item[0] == lo_dac)
 		return 0;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -168,7 +168,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 	 */
 	lo_enable_out_pins(dapm);
 
-	switch (ucontrol->value.integer.value[0]) {
+	switch (ucontrol->value.enumerated.item[0]) {
 	case 0:
 		pr_debug("set vibra path\n");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "VIB1OUT");
@@ -202,7 +202,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mutex_unlock(dapm);
 
-	lo_dac = ucontrol->value.integer.value[0];
+	lo_dac = ucontrol->value.enumerated.item[0];
 	return 0;
 }
 
-- 
2.7.0
