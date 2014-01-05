From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/5] ASoC: mc13783: Drop fixed ADC & DAC ports
	usage
Date: Sun,  5 Jan 2014 11:38:33 +0400
Message-ID: <1388907515-18975-3-git-send-email-shc_work@mail.ru>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD57261B1B
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 08:38:49 +0100 (CET)
In-Reply-To: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

There are no users of this driver without pdata, so stop using
constant assignment of ADC and DAC ports.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/mc13783.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index c2def5d..997f708 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -770,8 +770,7 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 		priv->adc_ssi_port = pdata->adc_ssi_port;
 		priv->dac_ssi_port = pdata->dac_ssi_port;
 	} else {
-		priv->adc_ssi_port = MC13783_SSI1_PORT;
-		priv->dac_ssi_port = MC13783_SSI2_PORT;
+		return -ENOSYS;
 	}
 
 	if (priv->adc_ssi_port == priv->dac_ssi_port)
-- 
1.8.3.2
