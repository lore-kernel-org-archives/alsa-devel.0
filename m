From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic3x: Fix data delay configuration
Date: Fri, 30 Jan 2015 14:42:31 +0200
Message-ID: <1422621751-30484-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 210C2260417
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 13:42:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

Fix the issue introduced by:
368494093354 ASoC: tlv320aic3x: Add TDM support

The CTRLC register were not receiving the correct delay configuration,
which will corrupt DSP_A audio mode.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

most of my boards are using DSP_B or I2S mode... This is why this is slipped.

Peter

 sound/soc/codecs/tlv320aic3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index a78ad361f494..07603d142923 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1046,7 +1046,7 @@ static int aic3x_prepare(struct snd_pcm_substream *substream,
 		delay += aic3x->tdm_delay;
 
 	/* Configure data delay */
-	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, aic3x->tdm_delay);
+	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
 
 	return 0;
 }
-- 
2.2.2
