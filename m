From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: Fix maximum value for microphone gain
Date: Sun, 23 Dec 2012 15:41:19 -0200
Message-ID: <1356284479-19323-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f42.google.com (mail-yh0-f42.google.com
 [209.85.213.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 59BE72615C7
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2012 18:41:38 +0100 (CET)
Received: by mail-yh0-f42.google.com with SMTP id g71so1240545yhg.1
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2012 09:41:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, eric.nelson@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

sgtl5000 microphone gain only has 2 bits of resolution, so maximum value is 3.

>From Eric Nelson:
"We also found that for the microphones we have here (commodity PC boom mics) a 
default value of 2 for the gain gives the best results."

So change the default microphone gain as well.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index cb1675c..92bbfec 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -401,7 +401,7 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			5, 1, 0),
 
 	SOC_SINGLE_TLV("Mic Volume", SGTL5000_CHIP_MIC_CTRL,
-			0, 4, 0, mic_gain_tlv),
+			0, 3, 0, mic_gain_tlv),
 };
 
 /* mute the codec used by alsa core */
@@ -1344,7 +1344,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 			SGTL5000_HP_ZCD_EN |
 			SGTL5000_ADC_ZCD_EN);
 
-	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
+	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 2);
 
 	/*
 	 * disable DAP
-- 
1.7.9.5
