From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Adding missing volume update
	bits.
Date: Thu, 27 Sep 2012 17:49:52 +0100
Message-ID: <1348764592-8580-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACA712602F3
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 18:56:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

The volume update bits were being set on all but one input and one output.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b99451e..9211e41 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -916,6 +916,8 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_ADC_DIGITAL_VOLUME_2R,
 	ARIZONA_ADC_DIGITAL_VOLUME_3L,
 	ARIZONA_ADC_DIGITAL_VOLUME_3R,
+	ARIZONA_ADC_DIGITAL_VOLUME_4L,
+	ARIZONA_ADC_DIGITAL_VOLUME_4R,
 
 	ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	ARIZONA_DAC_DIGITAL_VOLUME_1R,
@@ -927,6 +929,8 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_4R,
 	ARIZONA_DAC_DIGITAL_VOLUME_5L,
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
+	ARIZONA_DAC_DIGITAL_VOLUME_6L,
+	ARIZONA_DAC_DIGITAL_VOLUME_6R,
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
-- 
1.7.10.4
