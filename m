From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/31] ASoC: max98095: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:50 +0100
Message-ID: <1383673218-18405-4-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D1CA7265117
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:41 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
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

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98095.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 8fb072455802..67244315c721 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -516,8 +516,9 @@ static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
 	unsigned int eq_reg;
 	unsigned int i;
 
-	BUG_ON(band > 4);
-	BUG_ON(dai > 1);
+	if (WARN_ON(band > 4) ||
+	    WARN_ON(dai > 1))
+		return;
 
 	/* Load the base register address */
 	eq_reg = dai ? M98095_142_DAI2_EQ_BASE : M98095_110_DAI1_EQ_BASE;
@@ -541,8 +542,9 @@ static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
 	unsigned int bq_reg;
 	unsigned int i;
 
-	BUG_ON(band > 1);
-	BUG_ON(dai > 1);
+	if (WARN_ON(band > 1) ||
+	    WARN_ON(dai > 1))
+		return;
 
 	/* Load the base register address */
 	bq_reg = dai ? M98095_17E_DAI2_BQ_BASE : M98095_174_DAI1_BQ_BASE;
@@ -890,7 +892,8 @@ static int max98095_line_pga(struct snd_soc_dapm_widget *w,
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	u8 *state;
 
-	BUG_ON(!((channel == 1) || (channel == 2)));
+	if (WARN_ON(!(channel == 1 || channel == 2)))
+		return -EINVAL;
 
 	state = &max98095->lin_state;
 
@@ -1740,7 +1743,8 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	int fs, best, best_val, i;
 	int regmask, regsave;
 
-	BUG_ON(channel > 1);
+	if (WARN_ON(channel > 1))
+		return -EINVAL;
 
 	if (!pdata || !max98095->eq_textcnt)
 		return 0;
-- 
1.8.4.2
