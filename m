From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 002/102] ASoC: twl4030: Clean up duplicated code
Date: Tue, 18 Feb 2014 12:29:26 +0100
Message-ID: <1392722967-12472-3-git-send-email-tiwai@suse.de>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E39526517F
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:29:34 +0100 (CET)
In-Reply-To: <1392722967-12472-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove the open code in snd_soc_put_twl4030_opmode_enum_double() but
just call snd_soc_put_enum_double() instead, which does the very same
thing (even correctly with a lock).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/twl4030.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1eb13d586309..682e4ac88939 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -965,9 +965,6 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned short val;
-	unsigned short mask;
 
 	if (twl4030->configured) {
 		dev_err(codec->dev,
@@ -975,19 +972,7 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
-	if (ucontrol->value.enumerated.item[0] >= e->items)
-		return -EINVAL;
-
-	val = ucontrol->value.enumerated.item[0] << e->shift_l;
-	mask = e->mask << e->shift_l;
-	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] >= e->items)
-			return -EINVAL;
-		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
-		mask |= e->mask << e->shift_r;
-	}
-
-	return snd_soc_update_bits(codec, e->reg, mask, val);
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
 }
 
 /*
-- 
1.8.5.2
