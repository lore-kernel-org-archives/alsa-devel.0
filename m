From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: tlv320aic3x: Use
	snd_soc_dapm_mixer_update_power
Date: Wed, 24 Jul 2013 15:27:39 +0200
Message-ID: <1374672459-5202-5-git-send-email-lars@metafoo.de>
References: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 64486265373
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:26:59 +0200 (CEST)
In-Reply-To: <1374672459-5202-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <Andreas.Irestal@axis.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Hebbar Gururaja <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_dapm_mixer_update_power() instead of reimplementing its
functionality.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic3x.c | 49 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index cad4fb1..d3417c8 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -147,10 +147,9 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned short val, val_mask;
-	int ret;
-	struct snd_soc_dapm_path *path;
-	int found = 0;
+	unsigned short val;
+	struct snd_soc_dapm_update update;
+	int connect, change;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 
@@ -158,42 +157,26 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	if (val)
 		val = mask;
 
+	connect = !!val;
+
 	if (invert)
 		val = mask - val;
-	val_mask = mask << shift;
-	val = val << shift;
-
-	mutex_lock(&widget->codec->mutex);
 
-	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
-		/* find dapm widget path assoc with kcontrol */
-		list_for_each_entry(path, &widget->dapm->card->paths, list) {
-			if (path->kcontrol != kcontrol)
-				continue;
+	mask <<= shift;
+	val <<= shift;
 
-			/* found, now check type */
-			found = 1;
-			if (val)
-				/* new connection */
-				path->connect = invert ? 0 : 1;
-			else
-				/* old connection must be powered down */
-				path->connect = invert ? 1 : 0;
+	change = snd_soc_test_bits(widget->codec, val, mask, reg);
+	if (change) {
+		update.kcontrol = kcontrol;
+		update.reg = reg;
+		update.mask = mask;
+		update.val = val;
 
-			dapm_mark_dirty(path->source, "tlv320aic3x source");
-			dapm_mark_dirty(path->sink, "tlv320aic3x sink");
-
-			break;
-		}
+		snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, connect,
+			&update);
 	}
 
-	mutex_unlock(&widget->codec->mutex);
-
-	if (found)
-		snd_soc_dapm_sync(widget->dapm);
-
-	ret = snd_soc_update_bits_locked(widget->codec, reg, val_mask, val);
-	return ret;
+	return change;
 }
 
 /*
-- 
1.8.0
