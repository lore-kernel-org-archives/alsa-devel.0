From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv3 8/9] WM8971 adds kcontrol functions
Date: Tue,  2 Sep 2014 11:30:47 +0800
Message-ID: <1409628648-13732-8-git-send-email-xavier.hsu@linaro.org>
References: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C4CB2652BF
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 05:30:56 +0200 (CEST)
In-Reply-To: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch improves WM8971.
We add kcontrol functions on WM8971.

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 95e7c39..6d34565 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -284,6 +284,12 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("ADC Volume", WM8971_LADC, WM8971_RADC,
 			 0, 255, 0, adc_vol),
+
+	SOC_SINGLE("Analogue Bias", WM8971_ADCTL1, 6, 3, 0),
+	SOC_SINGLE("Right Speaker Playback Invert Switch", WM8971_ADCTL2,
+		   4, 1, 0),
+	SOC_SINGLE("Headphone Switch POL", WM8971_ADCTL2, 5, 1, 0),
+	SOC_SINGLE("Headphone Switch EN", WM8971_ADCTL2, 6, 1, 0),
 };
 
 /*
-- 
1.7.9.5
