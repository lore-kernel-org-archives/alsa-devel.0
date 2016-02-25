From: John Lin <john.lin@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: extend delay time for
	headphone pop noise
Date: Thu, 25 Feb 2016 13:18:27 +0800
Message-ID: <1456377507-13120-2-git-send-email-john.lin@realtek.com>
References: <1456377507-13120-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D56C265E2F
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 06:19:45 +0100 (CET)
In-Reply-To: <1456377507-13120-1-git-send-email-john.lin@realtek.com>
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

Headphone needs enough delay time before unmuting for avoiding pop sound.
We extend the delay time to make sure headphone doesn't pop.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d57119d..7af5e73 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1674,7 +1674,7 @@ static void hp_amp_power(struct snd_soc_codec *codec, int on)
 				regmap_write(rt5645->regmap, RT5645_PR_BASE +
 					RT5645_MAMP_INT_REG2, 0xfc00);
 				snd_soc_write(codec, RT5645_DEPOP_M2, 0x1140);
-				msleep(70);
+				msleep(90);
 				rt5645->hp_on = true;
 			} else {
 				/* depop parameters */
-- 
1.8.1.1.439.g50a6b54
