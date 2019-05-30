From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Add missing voice activation
	register definitions" to the asoc tree
Date: Thu, 30 May 2019 17:33:13 +0100 (BST)
Message-ID: <20190530163313.9705E440046@finisterre.sirena.org.uk>
References: <20190529193048.14145-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7D8DF8972B
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:33:18 +0200 (CEST)
In-Reply-To: <20190529193048.14145-1-cujomalainey@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Add missing voice activation register definitions

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f499edf9fa90f184af9f457fd0912a788754af25 Mon Sep 17 00:00:00 2001
From: Curtis Malainey <cujomalainey@chromium.org>
Date: Wed, 29 May 2019 12:30:48 -0700
Subject: [PATCH] ASoC: rt5677: Add missing voice activation register
 definitions

Most of the voice activation definitions were missing, they will be
needed for when hotwording is added. Also the source bits are only 2
wide not 3 and needed to be corrected.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 11a2ffceec3b..076e5161d8da 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1456,9 +1456,37 @@
 #define RT5677_I2S4_CLK_SEL_MASK		(0xf)
 #define RT5677_I2S4_CLK_SEL_SFT			0
 
+/* VAD Function Control 1 (0x9c) */
+#define RT5677_VAD_MIN_DUR_MASK			(0x3 << 13)
+#define RT5677_VAD_MIN_DUR_SFT			13
+#define RT5677_VAD_ADPCM_BYPASS			(1 << 10)
+#define RT5677_VAD_ADPCM_BYPASS_BIT		10
+#define RT5677_VAD_FG2ENC			(1 << 9)
+#define RT5677_VAD_FG2ENC_BIT			9
+#define RT5677_VAD_BUF_OW			(1 << 8)
+#define RT5677_VAD_BUF_OW_BIT			8
+#define RT5677_VAD_CLR_FLAG			(1 << 7)
+#define RT5677_VAD_CLR_FLAG_BIT			7
+#define RT5677_VAD_BUF_POP			(1 << 6)
+#define RT5677_VAD_BUF_POP_BIT			6
+#define RT5677_VAD_BUF_PUSH			(1 << 5)
+#define RT5677_VAD_BUF_PUSH_BIT			5
+#define RT5677_VAD_DET_ENABLE			(1 << 4)
+#define RT5677_VAD_DET_ENABLE_BIT		4
+#define RT5677_VAD_FUNC_ENABLE			(1 << 3)
+#define RT5677_VAD_FUNC_ENABLE_BIT		3
+#define RT5677_VAD_FUNC_RESET			(1 << 2)
+#define RT5677_VAD_FUNC_RESET_BIT		2
+
 /* VAD Function Control 4 (0x9f) */
-#define RT5677_VAD_SRC_MASK			(0x7 << 8)
+#define RT5677_VAD_OUT_SRC_RATE_MASK		(0x1 << 11)
+#define RT5677_VAD_OUT_SRC_RATE_SFT		11
+#define RT5677_VAD_OUT_SRC_MASK			(0x1 << 10)
+#define RT5677_VAD_OUT_SRC_SFT			10
+#define RT5677_VAD_SRC_MASK			(0x3 << 8)
 #define RT5677_VAD_SRC_SFT			8
+#define RT5677_VAD_LV_DIFF_MASK			(0xff << 0)
+#define RT5677_VAD_LV_DIFF_SFT			0
 
 /* DSP InBound Control (0xa3) */
 #define RT5677_IB01_SRC_MASK			(0x7 << 12)
-- 
2.20.1
