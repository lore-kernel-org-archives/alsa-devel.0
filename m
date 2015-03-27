From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5645: Restore HP depop setting in
	HP off
Date: Fri, 27 Mar 2015 20:19:09 +0800
Message-ID: <1427458749-821-4-git-send-email-bardliao@realtek.com>
References: <1427458749-821-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AE81C265A7C
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 13:19:21 +0100 (CET)
In-Reply-To: <1427458749-821-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This driver will set RT5645_DEPOP_MAN bit in headphone power up
depop process. We need to restore it in headphone power down
process. Otherwise, we will get headphone noise when push button
function is enabled.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b6d5b95..69528ae 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1270,6 +1270,8 @@ static void hp_amp_power(struct snd_soc_codec *codec, int on)
 			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_HP_L | RT5645_PWR_HP_R |
 				RT5645_PWR_HA, 0);
+			snd_soc_update_bits(codec, RT5645_DEPOP_M2,
+				RT5645_DEPOP_MASK, 0);
 		}
 	}
 }
-- 
1.8.1.1.439.g50a6b54
