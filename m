From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/4] ASoC: rt5659: register power bit of LOUT
	Amp
Date: Mon, 16 Oct 2017 19:15:13 +0800
Message-ID: <1508152516-25767-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id CAE17266B38
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 13:17:36 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There is a power bit for LOUT Amp.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5659.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 71216db..999432e 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2744,7 +2744,8 @@ static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
 		SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5659_hp_event,
 		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_PGA("LOUT Amp", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_S("LOUT Amp", 1,  RT5659_PWR_ANLG_1, RT5659_PWR_LM_BIT,
+		0,  NULL, 0),
 
 	SND_SOC_DAPM_SUPPLY("Charge Pump", SND_SOC_NOPM, 0, 0,
 		rt5659_charge_pump_event, SND_SOC_DAPM_PRE_PMU |
-- 
2.7.4
