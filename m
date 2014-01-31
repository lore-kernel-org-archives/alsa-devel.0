From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Improve ultrasonic
	frequency response
Date: Fri, 31 Jan 2014 15:47:14 +0000
Message-ID: <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 752B5264FEB
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:55:30 +0100 (CET)
In-Reply-To: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Evaluation of the device has given some settings to improve the
ultrasonic frequency response. This patch allows the user the option of
applying those.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/pdata.h |    3 +++
 sound/soc/codecs/arizona.c        |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 12a5c13..3df0ed5 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -177,6 +177,9 @@ struct arizona_pdata {
 	/** Mode for outputs */
 	bool out_mono[ARIZONA_MAX_OUTPUT];
 
+	/** Provide improved ultrasonic frequency response */
+	bool ultrasonic_response;
+
 	/** PDM speaker mute setting */
 	unsigned int spk_mute[ARIZONA_MAX_PDM_SPK];
 
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e4295fe..f2e1ffe 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1134,6 +1134,21 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	}
 	sr_val = i;
 
+	switch (priv->arizona->type) {
+	case WM5102:
+		if (priv->arizona->pdata.ultrasonic_response) {
+			snd_soc_write(codec, 0x80, 0x3);
+			if (params_rate(params) >= 176400)
+				snd_soc_write(codec, 0x4dd, 0x1);
+			else
+				snd_soc_write(codec, 0x4dd, 0x0);
+			snd_soc_write(codec, 0x80, 0x0);
+		}
+		break;
+	default:
+		break;
+	}
+
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
-- 
1.7.2.5
