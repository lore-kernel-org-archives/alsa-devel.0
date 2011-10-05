From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/10] ASoC: twl6040: Simply call
	snd_soc_put_volsw form the custom code
Date: Wed,  5 Oct 2011 10:29:26 +0300
Message-ID: <1317799768-15683-9-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D92103A34
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:54 +0200 (CEST)
Received: by mail-bw0-f49.google.com with SMTP id t2so1971457bka.8
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:53 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The ASoC core now have one callback function, which can handle
single, and double register mixer controls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c9a601d..7450e1b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -746,7 +746,7 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	struct twl6040_output *out = NULL;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int ret, type_2r;
+	int ret;
 
 	/* For HS and HF we shadow the values and only actually write
 	 * them out when active in order to ensure the amplifier comes on
@@ -754,11 +754,9 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	switch (mc->reg) {
 	case TWL6040_REG_HSGAIN:
 		out = &twl6040_priv->headset;
-		type_2r = 0;
 		break;
 	case TWL6040_REG_HFLGAIN:
 		out = &twl6040_priv->handsfree;
-		type_2r = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -769,12 +767,7 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	if (!out->active)
 		return 1;
 
-	/* call the appropriate handler depending on the rreg */
-	if (type_2r)
-		ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
-	else
-		ret = snd_soc_put_volsw(kcontrol, ucontrol);
-
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 	if (ret < 0)
 		return ret;
 
-- 
1.7.7
