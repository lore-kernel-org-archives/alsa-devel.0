From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: Recheck the jack detect status
	after resuming from S3
Date: Tue, 13 Oct 2015 15:07:25 +0800
Message-ID: <1444720045-15444-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E5C2606FB
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 09:07:38 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, gary_lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, dain@samsung.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch rechecks the jack detect status after resuming from S3.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 89ba4ff..4d54999 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2745,6 +2745,10 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2,
 			RT5645_PWR_FV1 | RT5645_PWR_FV2);
+		if (rt5645->en_button_func &&
+			snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+			queue_delayed_work(system_power_efficient_wq,
+				&rt5645->jack_detect_work, msecs_to_jiffies(0));
 		break;
 
 	case SND_SOC_BIAS_OFF:
-- 
1.8.1.1.439.g50a6b54
