From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 02/10] ASoC: twl6040: Simplify custom
	get_volsw callback
Date: Wed,  5 Oct 2011 10:29:20 +0300
Message-ID: <1317799768-15683-3-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 93EE41038BB
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:45 +0200 (CEST)
Received: by bkbzt19 with SMTP id zt19so1931806bkb.37
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:43 -0700 (PDT)
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

The custom get_volsw does not need to call any core get_volsw calls,
since we are returning the shadow values for the gains.
Return -EINVAL in the unlikely event, if the function has been called
for unhandled control. This way we can remove one check in the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 11f681b..4ad04e3 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -796,20 +796,14 @@ static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
 		out = &twl6040_priv->handsfree;
 		break;
 	default:
-		break;
-	}
-
-	if (out) {
-		ucontrol->value.integer.value[0] = out->left_vol;
-		ucontrol->value.integer.value[1] = out->right_vol;
-		return 0;
+		dev_warn(codec->dev, "%s: Unexpected register: 0x%02x\n",
+					__func__, mc->reg);
+		return -EINVAL;
 	}
 
-	/* call the appropriate handler depending on the rreg */
-	if (mc->rreg)
-		return snd_soc_get_volsw_2r(kcontrol, ucontrol);
-	else
-		return snd_soc_get_volsw(kcontrol, ucontrol);
+	ucontrol->value.integer.value[0] = out->left_vol;
+	ucontrol->value.integer.value[1] = out->right_vol;
+	return 0;
 }
 
 /*
-- 
1.7.7
