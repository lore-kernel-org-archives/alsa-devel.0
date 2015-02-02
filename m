From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ASoC: tlv320aic3x: Fix data delay
	configuration
Date: Mon, 2 Feb 2015 10:20:23 +0200
Message-ID: <1422865223-11785-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F3C872604A0
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 09:20:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, tiwai@suse.de
Cc: pavel@ucw.cz, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The CTRLC register were not receiving the correct delay configuration,
which will corrupt DSP_A audio mode.

Fixes: 368494093354 ("ASoC: tlv320aic3x: Add TDM support")

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---

Changes since v1:
Fixes tag and Tested-by from Pavel and Jarkko added to commit message.

Regards,
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
