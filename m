From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5677: set PLL_CTRL2 non-volatile
Date: Fri, 18 Dec 2015 10:16:23 +0800
Message-ID: <1450404983-26646-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AD5326153F
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:16:37 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, benzh@chromium.org, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There is a status bit on RT5677_PLL1_CTRL2 and RT5677_PLL2_CTRL2.
That's why those registers are set volatile. However, the status
bit is currently not used by codec driver. So, it should be no
problem if we set them non-volatile.
The purpose of setting them non-volatile is to restore the setting
after a syspend/resume cycle.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
Mark,

Please revert the "ASoC: rt5677: Reconfigure PLL1 after resume"
patch before applying this patch.

Thanks.
---
 sound/soc/codecs/rt5677.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f73fd12..13fef00 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -297,8 +297,6 @@ static bool rt5677_volatile_register(struct device *dev, unsigned int reg)
 	case RT5677_HAP_GENE_CTRL2:
 	case RT5677_PWR_DSP_ST:
 	case RT5677_PRIV_DATA:
-	case RT5677_PLL1_CTRL2:
-	case RT5677_PLL2_CTRL2:
 	case RT5677_ASRC_22:
 	case RT5677_ASRC_23:
 	case RT5677_VAD_CTRL5:
-- 
1.8.1.1.439.g50a6b54
