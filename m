From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/9] ASoC: wm8985: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:14 +0100
Message-ID: <1456765278-5435-6-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E4993264F39
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:01:27 +0100 (CET)
In-Reply-To: <1456765278-5435-1-git-send-email-tiwai@suse.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"Equalizer Function" ctl in wm8985 codec driver is enum, while the
current driver accesses wrongly via value.integer.value[].  They have
to be via value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8985.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 9918152a03c7..6ac76fe116b0 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -531,9 +531,9 @@ static int eqmode_get(struct snd_kcontrol *kcontrol,
 
 	reg = snd_soc_read(codec, WM8985_EQ1_LOW_SHELF);
 	if (reg & WM8985_EQ3DMODE)
-		ucontrol->value.integer.value[0] = 1;
+		ucontrol->value.enumerated.item[0] = 1;
 	else
-		ucontrol->value.integer.value[0] = 0;
+		ucontrol->value.enumerated.item[0] = 0;
 
 	return 0;
 }
@@ -545,18 +545,18 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	unsigned int regpwr2, regpwr3;
 	unsigned int reg_eq;
 
-	if (ucontrol->value.integer.value[0] != 0
-			&& ucontrol->value.integer.value[0] != 1)
+	if (ucontrol->value.enumerated.item[0] != 0
+			&& ucontrol->value.enumerated.item[0] != 1)
 		return -EINVAL;
 
 	reg_eq = snd_soc_read(codec, WM8985_EQ1_LOW_SHELF);
 	switch ((reg_eq & WM8985_EQ3DMODE) >> WM8985_EQ3DMODE_SHIFT) {
 	case 0:
-		if (!ucontrol->value.integer.value[0])
+		if (!ucontrol->value.enumerated.item[0])
 			return 0;
 		break;
 	case 1:
-		if (ucontrol->value.integer.value[0])
+		if (ucontrol->value.enumerated.item[0])
 			return 0;
 		break;
 	}
@@ -573,7 +573,7 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	/* set the desired eqmode */
 	snd_soc_update_bits(codec, WM8985_EQ1_LOW_SHELF,
 			    WM8985_EQ3DMODE_MASK,
-			    ucontrol->value.integer.value[0]
+			    ucontrol->value.enumerated.item[0]
 			    << WM8985_EQ3DMODE_SHIFT);
 	/* restore DAC/ADC configuration */
 	snd_soc_write(codec, WM8985_POWER_MANAGEMENT_2, regpwr2);
-- 
2.7.2
