From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Fix the issue of the delay
	volume applied
Date: Tue, 24 Jul 2018 15:49:23 +0800
Message-ID: <1532418563-26569-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B6A4826739D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 09:49:31 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch fixes the issue of the delay volume applied.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 1570b91..dca82dd 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -64,8 +64,8 @@ static const struct reg_sequence rt5514_patch[] = {
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 };
 
 static const struct reg_default rt5514_reg[] = {
@@ -92,10 +92,10 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER0_CTRL3,	0x10000352},
 	{RT5514_DOWNFILTER1_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER1_CTRL2,	0x00020c2f},
-	{RT5514_DOWNFILTER1_CTRL3,	0x10000362},
+	{RT5514_DOWNFILTER1_CTRL3,	0x10000352},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_LDO18_16,	0x02000345},
 	{RT5514_ANA_CTRL_ADC12,		0x0000a2a8},
-- 
2.7.4
