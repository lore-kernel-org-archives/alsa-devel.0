From: John Lin <john.lin@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: improve headphone pop when
	system resumes from S3
Date: Thu, 25 Feb 2016 13:18:26 +0800
Message-ID: <1456377507-13120-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3962E261687
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 06:19:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

When playing audio through headphone, headphone makes pop noise if system
resumes from S3 to S0. We modify the sequence of writing register for
avoiding pop sound.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 93e8c90..d57119d 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3029,13 +3029,18 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 			RT5645_PWR_BG | RT5645_PWR_VREF2,
 			RT5645_PWR_VREF1 | RT5645_PWR_MB |
 			RT5645_PWR_BG | RT5645_PWR_VREF2);
+		mdelay(10);
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2);
-		if (rt5645->en_button_func &&
-			snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
-			queue_delayed_work(system_power_efficient_wq,
-				&rt5645->jack_detect_work, msecs_to_jiffies(0));
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
+			msleep(40);
+			if (rt5645->en_button_func)
+				queue_delayed_work(system_power_efficient_wq,
+					&rt5645->jack_detect_work,
+					msecs_to_jiffies(0));
+		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
1.8.1.1.439.g50a6b54
