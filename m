From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: automatic BCLK and LRC divde in
	master mode
Date: Fri, 17 Feb 2017 09:55:33 +0800
Message-ID: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 45800267082
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 02:55:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

configurable LRC and BCLK divide. The driver
will make configurations of LRC and BCLK automatically according to
BCLK and FS information in master mode.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 4576f98..97fbeba 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1231,7 +1231,7 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
 {
        struct snd_soc_codec *codec = dai->codec;
        struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
-       unsigned int val_len = 0, osr;
+       unsigned int val_len = 0, osr, ctrl_val, bclk_fs, bclk_div;

        nau8825_sema_acquire(nau8825, 3 * HZ);

@@ -1261,6 +1261,24 @@ static int nau8825_hw_params(struct snd_pcm_substream *substream,
                        osr_adc_sel[osr].clk_src << NAU8825_CLK_ADC_SRC_SFT);
        }

+       /* make BCLK and LRC divde configuration if the codec as master. */
+       regmap_read(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2, &ctrl_val);
+       if (ctrl_val & NAU8825_I2S_MS_MASTER) {
+               /* get the bclk and fs ratio */
+               bclk_fs = snd_soc_params_to_bclk(params) / params_rate(params);
+               if (bclk_fs <= 32)
+                       bclk_div = 2;
+               else if (bclk_fs <= 64)
+                       bclk_div = 1;
+               else if (bclk_fs <= 128)
+                       bclk_div = 0;
+               else
+                       return -EINVAL;
+               regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL2,
+                       NAU8825_I2S_LRC_DIV_MASK | NAU8825_I2S_BLK_DIV_MASK,
+                       ((bclk_div + 1) << NAU8825_I2S_LRC_DIV_SFT) | bclk_div);
+       }
+
        switch (params_width(params)) {
        case 16:
                val_len |= NAU8825_I2S_DL_16;
-- 2.6.4 .


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
