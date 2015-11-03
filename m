From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: fix range of OPCLK_REF
Date: Tue, 3 Nov 2015 14:24:12 +0000
Message-ID: <1446560652-3144-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The code was able to generate illegal OPCLK_REF values because the
reference frequency tables listed all values of SYSCLK instead of
valid values for OPCLK_REF clock. The maximum OPCLK_REF clock is
49.152MHz or 45.1584MHz.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9929efc..b3ea24d 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1023,24 +1023,18 @@ void arizona_init_dvfs(struct arizona_priv *priv)
 }
 EXPORT_SYMBOL_GPL(arizona_init_dvfs);
 
-static unsigned int arizona_sysclk_48k_rates[] = {
+static unsigned int arizona_opclk_ref_48k_rates[] = {
 	6144000,
 	12288000,
 	24576000,
 	49152000,
-	73728000,
-	98304000,
-	147456000,
 };
 
-static unsigned int arizona_sysclk_44k1_rates[] = {
+static unsigned int arizona_opclk_ref_44k1_rates[] = {
 	5644800,
 	11289600,
 	22579200,
 	45158400,
-	67737600,
-	90316800,
-	135475200,
 };
 
 static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
@@ -1065,11 +1059,11 @@ static int arizona_set_opclk(struct snd_soc_codec *codec, unsigned int clk,
 	}
 
 	if (refclk % 8000)
-		rates = arizona_sysclk_44k1_rates;
+		rates = arizona_opclk_ref_44k1_rates;
 	else
-		rates = arizona_sysclk_48k_rates;
+		rates = arizona_opclk_ref_48k_rates;
 
-	for (ref = 0; ref < ARRAY_SIZE(arizona_sysclk_48k_rates) &&
+	for (ref = 0; ref < ARRAY_SIZE(arizona_opclk_ref_48k_rates) &&
 		     rates[ref] <= refclk; ref++) {
 		div = 1;
 		while (rates[ref] / div >= freq && div < 32) {
-- 
1.9.1
