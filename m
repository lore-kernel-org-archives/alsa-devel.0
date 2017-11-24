From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] SoC: rt5514: Make sure the DMIC delay will be
	happened after normal SUPPLY widgets power on
Date: Fri, 24 Nov 2017 14:23:17 +0800
Message-ID: <1511504597-2948-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 913E7266A74
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 07:23:28 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch makes sure the DMIC delay will be happened after normal SUPPLY
widgets power on. If there are some platforms that provide the MCLK using
the SUPPLY widget, it will make sure the delay time is helpful.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 61ccbc6..198df01 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -567,7 +567,7 @@ static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("DMIC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("DMIC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SUPPLY_S("DMIC CLK", 1, SND_SOC_NOPM, 0, 0,
 		rt5514_set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_SUPPLY("ADC CLK", RT5514_CLK_CTRL1,
-- 
2.7.4
