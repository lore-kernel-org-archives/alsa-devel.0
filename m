From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 04/12] ASoC: twl6040: Simplify custom get_volsw
	callback
Date: Tue,  4 Oct 2011 14:39:41 +0300
Message-ID: <1317728389-22062-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D8F103870
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:06 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so610915bkb.32
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:04 -0700 (PDT)
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

The custom get_volsw does not need to call any core get_volsw calls,
since we are returning the shadow values for the gains.
Return -EINVAL in the unlikely event, if the function has been called
for unhandled control. This way we can remove one check in the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 7e1c4c2..1d66127 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -798,20 +798,12 @@ static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
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
 
 static int twl6040_soc_dapm_put_vibra_enum(struct snd_kcontrol *kcontrol,
-- 
1.7.7
