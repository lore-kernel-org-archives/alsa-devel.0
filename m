From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V4 1/3] sound: soc: jz4740: Add dynamic
	sampling rate support to jz4740-i2s
Date: Tue, 3 Feb 2015 10:55:57 +0000
Message-ID: <1422960959-40403-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1422960959-40403-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5284F2612CC
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 11:56:17 +0100 (CET)
In-Reply-To: <1422960959-40403-1-git-send-email-Zubair.Kakakhel@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, Zubair.Kakakhel@imgtec.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The div clock register is not modified during jz4740_i2s_hw_params.
Hence, default sampling rates are actually used regardless of
sampling rates input from userspace.

This patch adds support to calculate the value of the divider from
the parameters passed from userspace and update the relevant div
registers

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
V4 Added Acked-by: Lars-Peter Clausen <lars@metafoo.de>

V2 changes: Removed a redundant #define
---
 sound/soc/jz4740/jz4740-i2s.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index d3d45c6..b7a7e82 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -83,6 +83,8 @@
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
 #define JZ_AIC_CLK_DIV_MASK 0xf
+#define I2SDIV_DV_SHIFT 8
+#define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
 
 struct jz4740_i2s {
 	struct resource *mem;
@@ -237,10 +239,14 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int sample_size;
-	uint32_t ctrl;
+	uint32_t ctrl, div_reg;
+	int div;
 
 	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
 
+	div_reg = jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
+	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
@@ -264,7 +270,10 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 	}
 
+	div_reg &= ~I2SDIV_DV_MASK;
+	div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
 
 	return 0;
 }
-- 
1.9.1
