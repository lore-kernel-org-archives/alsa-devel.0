From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH 1/2] ASoC: adau17x1: Handling of DSP_RUN
	register during fw setup
Date: Tue,  3 Apr 2018 10:05:34 +0200
Message-ID: <20180403080535.6109-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D7908266CE7
 for <alsa-devel@alsa-project.org>; Tue,  3 Apr 2018 10:05:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

From: Danny Smith <dannys@axis.com>

DSP_RUN needs to be disabled during firmware write otherwise
we can end up with undefined behavior if writing to a dsp which
is already running firmware.

Signed-off-by: Danny Smith <dannys@axis.com>
---
 sound/soc/codecs/adau17x1.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 80c2a06285bb..5636b9522462 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -838,14 +838,19 @@ EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
 int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
 {
 	int ret;
-	int dspsr;
+	int dspsr, dsp_run;
 
 	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
 	if (ret)
 		return ret;
 
+	ret = regmap_read(adau->regmap, ADAU17X1_DSP_RUN, &dsp_run);
+	if (ret)
+		return ret;
+
 	regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 1);
 	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, 0xf);
+	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
 
 	ret = sigmadsp_setup(adau->sigmadsp, rate);
 	if (ret) {
@@ -853,6 +858,7 @@ int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
 		return ret;
 	}
 	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, dspsr);
+	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, dsp_run);
 
 	return 0;
 }
-- 
2.11.0
