From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5514: Set the pin GPIO6(IRQ) to
	output low as default
Date: Mon, 31 Jul 2017 13:47:43 +0800
Message-ID: <1501480063-32225-2-git-send-email-oder_chiou@realtek.com>
References: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 69087266F15
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 07:47:52 +0200 (CEST)
In-Reply-To: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, chinyue@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch set the pin GPIO6(IRQ) to output low as default to prevent the
IRQ pin to trigger the IRQ function continuously in the float status.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 6 ++++--
 sound/soc/codecs/rt5514.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 21cbb56..7a1c2aa 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -58,7 +58,8 @@ static const struct reg_sequence rt5514_i2c_patch[] = {
 };
 
 static const struct reg_sequence rt5514_patch[] = {
-	{RT5514_DIG_IO_CTRL,		0x00000040},
+	{RT5514_DIG_IO_CTRL,		0x00000240},
+	{RT5514_GPIO_CTRL1,		0x04000000},
 	{RT5514_CLK_CTRL1,		0x38020041},
 	{RT5514_SRC_CTRL,		0x44000eee},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
@@ -74,7 +75,8 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_I2S_CTRL2,		0x20000000},
 	{RT5514_VAD_CTRL6,		0xc00007d2},
 	{RT5514_EXT_VAD_CTRL,		0x80000080},
-	{RT5514_DIG_IO_CTRL,		0x00000040},
+	{RT5514_DIG_IO_CTRL,		0x00000240},
+	{RT5514_GPIO_CTRL1,		0x04000000},
 	{RT5514_PAD_CTRL1,		0x00804000},
 	{RT5514_DMIC_DATA_CTRL,		0x00000005},
 	{RT5514_DIG_SOURCE_CTRL,	0x00000002},
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 2dc40e6..3da40d1 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -25,6 +25,7 @@
 #define RT5514_VAD_CTRL6			0x2030
 #define RT5514_EXT_VAD_CTRL			0x206c
 #define RT5514_DIG_IO_CTRL			0x2070
+#define RT5514_GPIO_CTRL1			0x2074
 #define RT5514_PAD_CTRL1			0x2080
 #define RT5514_DMIC_DATA_CTRL			0x20a0
 #define RT5514_DIG_SOURCE_CTRL			0x20a4
-- 
2.7.4
