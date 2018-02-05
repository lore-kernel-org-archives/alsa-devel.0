From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5659: Remove the routing path of
	the power widget "LDO2"
Date: Mon, 5 Feb 2018 18:29:55 +0800
Message-ID: <1517826596-17864-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CE7C266F3E
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 11:30:24 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, spujar@nvidia.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch removes the routing path of the power widget "LDO2", and it
should be depended on the hardware design. The power widget "LDO2" should
add the routing path with the MICBIAS in the machine driver that is
reasonable.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5659.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 07e7757..4ec1917 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2818,11 +2818,6 @@ static const struct snd_soc_dapm_route rt5659_dapm_routes[] = {
 	{ "I2S2", NULL, "I2S2 ASRC" },
 	{ "I2S3", NULL, "I2S3 ASRC" },
 
-	{ "IN1P", NULL, "LDO2" },
-	{ "IN2P", NULL, "LDO2" },
-	{ "IN3P", NULL, "LDO2" },
-	{ "IN4P", NULL, "LDO2" },
-
 	{ "DMIC1", NULL, "DMIC L1" },
 	{ "DMIC1", NULL, "DMIC R1" },
 	{ "DMIC2", NULL, "DMIC L2" },
-- 
2.7.4
