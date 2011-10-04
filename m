From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 05/12] ASoC: twl6040: Simplify custom put_volsw
	callback
Date: Tue,  4 Oct 2011 14:39:42 +0300
Message-ID: <1317728389-22062-6-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id BBFF01038F0
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:09 +0200 (CEST)
Received: by bkbzu5 with SMTP id zu5so662781bkb.35
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:06 -0700 (PDT)
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

Return -EINVAL in the unlikely event, if the function has been called
for unhandled control. This way we can remove one check in the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 1d66127..cc889e9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -759,15 +759,13 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 		out = &twl6040_priv->handsfree;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
-	if (out) {
-		out->left_vol = ucontrol->value.integer.value[0];
-		out->right_vol = ucontrol->value.integer.value[1];
-		if (!out->active)
-			return 1;
-	}
+	out->left_vol = ucontrol->value.integer.value[0];
+	out->right_vol = ucontrol->value.integer.value[1];
+	if (!out->active)
+		return 1;
 
 	/* call the appropriate handler depending on the rreg */
 	if (mc->rreg)
-- 
1.7.7
