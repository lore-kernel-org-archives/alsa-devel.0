From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 11/12] ASoC: twl6040: Simply call
	snd_soc_put_volsw form the custom code
Date: Tue,  4 Oct 2011 14:39:48 +0300
Message-ID: <1317728389-22062-12-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id B643B103934
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:20 +0200 (CEST)
Received: by mail-bw0-f49.google.com with SMTP id t2so690254bka.8
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:19 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
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
 sound/soc/codecs/twl6040.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index ff27eb4..ea814e5 100644
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
@@ -769,11 +767,7 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	if (!out->active)
 		return 1;
 
-	/* call the appropriate handler depending on the rreg */
-	if (type_2r)
-		ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
-	else
-		ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
 	if (ret < 0)
 		return ret;
-- 
1.7.7
