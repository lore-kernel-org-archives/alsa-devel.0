From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: change micbias widget type to
	supply.
Date: Thu, 28 Dec 2017 19:41:36 +0800
Message-ID: <1514461296-16236-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id CB0AB266C0C
 for <alsa-devel@alsa-project.org>; Thu, 28 Dec 2017 12:41:49 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hdegoede@redhat.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Register "micbias1" and "micbias2" to supply widegts as modern drivers do.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index cd82302..8f37afd 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1977,10 +1977,10 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 
 	/* Input Side */
 	/* micbias */
-	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB1_BIT, 0),
-	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB2_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB2_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
 	SND_SOC_DAPM_INPUT("DMIC R1"),
-- 
2.7.4
