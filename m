From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] ASoC: wm8904: Use SOC_SINGLE_EXT()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:33:56 +0200
Message-ID: <1371663243-10032-4-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 90514261B33
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:33:55 +0200 (CEST)
In-Reply-To: <1371663243-10032-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8904.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 3ff195c..4c9fb14 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -603,13 +603,8 @@ SOC_DOUBLE_R("Capture Switch", WM8904_ANALOGUE_LEFT_INPUT_0,
 
 SOC_SINGLE("High Pass Filter Switch", WM8904_ADC_DIGITAL_0, 4, 1, 0),
 SOC_ENUM("High Pass Filter Mode", hpf_mode),
-
-{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "ADC 128x OSR Switch",
-	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,
-	.put = wm8904_adc_osr_put,
-	.private_value = SOC_SINGLE_VALUE(WM8904_ANALOGUE_ADC_0, 0, 1, 0),
-},
+SOC_SINGLE_EXT("ADC 128x OSR Switch", WM8904_ANALOGUE_ADC_0, 0, 1, 0,
+	snd_soc_get_volsw, wm8904_adc_osr_put),
 };
 
 static const char *drc_path_text[] = {
-- 
1.8.0
