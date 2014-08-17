From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: ab8500-codec: Drop bank prefix from
	AB8500_GPIO_DIR4_REG register define
Date: Sun, 17 Aug 2014 16:18:22 +0200
Message-ID: <1408285102-24538-7-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F75326510C
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:31 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

The AB8500_GPIO_DIR4_REG register define has the bank for the register in the
upper 8 bits and the register itself in the lower 8 bits. When passing it to
abx500_{set,get}_register_interruptible() the upper bits get truncated which
generates the following warning from sparse:
	sound/soc/codecs/ab8500-codec.c:1972:53: warning: cast truncates bits
	 from constant value (1013 becomes 13)
	sound/soc/codecs/ab8500-codec.c:1980:53: warning: cast truncates bits
	 from constant value (1013 becomes 13)

The bank is passed separately to abx500_{set,get}_register_interruptible() so
the code works fine as it is. Given that all users of AB8500_GPIO_DIR4_REG
always truncate the upper 8 bits just remove them from the define.

Also remove the unnecessary casts to u8.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ab8500-codec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 1fb4402..62cf231 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -56,8 +56,7 @@
 #define GPIO31_DIR_OUTPUT			0x40
 
 /* Macrocell register definitions */
-#define AB8500_CTRL3_REG			0x0200
-#define AB8500_GPIO_DIR4_REG			0x1013
+#define AB8500_GPIO_DIR4_REG			0x13 /* Bank AB8500_MISC */
 
 /* Nr of FIR/IIR-coeff banks in ANC-block */
 #define AB8500_NR_OF_ANC_COEFF_BANKS		2
@@ -1968,16 +1967,16 @@ static int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
 	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
 
 	/* Set DMic-clocks to outputs */
-	status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
-						(u8)AB8500_GPIO_DIR4_REG,
+	status = abx500_get_register_interruptible(codec->dev, AB8500_MISC,
+						AB8500_GPIO_DIR4_REG,
 						&value8);
 	if (status < 0)
 		return status;
 	value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
 		GPIO31_DIR_OUTPUT;
 	status = abx500_set_register_interruptible(codec->dev,
-						(u8)AB8500_MISC,
-						(u8)AB8500_GPIO_DIR4_REG,
+						AB8500_MISC,
+						AB8500_GPIO_DIR4_REG,
 						value);
 	if (status < 0)
 		return status;
-- 
1.8.0
