From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: intel: mfld: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 17:29:25 +0100
Message-ID: <1456763365-3123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A570265ACF
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:29:28 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

"Playback Switch" and "Lineout Mux" ctls in medfld machine driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

I didn't put Cc to stable, as I assume medfiled is 32bit only.
If it also supports 64bit, put Cc to stable.

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
2.7.2
