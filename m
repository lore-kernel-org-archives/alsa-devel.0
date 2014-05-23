From: Fabio Estevam <festevam@gmail.com>
Subject: Re: The resume of sgtl5000 causes kernel Oops
Date: Thu, 22 May 2014 23:05:39 -0300
Message-ID: <CAOMZO5D8u9BmQH6K-oGcNA77o-WbmTtSEcWuVYrBTx5vbimkiA@mail.gmail.com>
References: <20140522145650.GD32184@dragon>
 <20140522174818.GN12304@sirena.org.uk>
 <CAOMZO5CCFnZSz_jaipe4Fz0sTxXOajp7QRPiaM5f5wg_Di0ftA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 70BCB265634
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 04:05:40 +0200 (CEST)
Received: by mail-vc0-f169.google.com with SMTP id ij19so5464321vcb.14
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 19:05:39 -0700 (PDT)
In-Reply-To: <CAOMZO5CCFnZSz_jaipe4Fz0sTxXOajp7QRPiaM5f5wg_Di0ftA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 22, 2014 at 6:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
> sgtl5000 1-000a: Failed to restore cache: -5
> sgtl5000 1-000a: ASoC: Failed to turn on bias: -5

These errors are gone if on top of the previous change I add:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -36,29 +36,55 @@

 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
-    { SGTL5000_CHIP_CLK_CTRL,        0x0008 },
-    { SGTL5000_CHIP_I2S_CTRL,        0x0010 },
-    { SGTL5000_CHIP_SSS_CTRL,        0x0010 },
+    { SGTL5000_CHIP_DIG_POWER,         0x0000 },
+    { SGTL5000_CHIP_CLK_CTRL,         0x0008 },
+    { SGTL5000_CHIP_I2S_CTRL,         0x0010 },
+    { SGTL5000_CHIP_SSS_CTRL,         0x0010 },
+    { SGTL5000_CHIP_ADCDAC_CTRL,         0x020c },
     { SGTL5000_CHIP_DAC_VOL,        0x3c3c },
     { SGTL5000_CHIP_PAD_STRENGTH,        0x015f },
-    { SGTL5000_CHIP_ANA_HP_CTRL,        0x1818 },
+    { SGTL5000_CHIP_ANA_ADC_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_HP_CTRL,         0x1818 },
     { SGTL5000_CHIP_ANA_CTRL,        0x0111 },
+    { SGTL5000_CHIP_LINREG_CTRL,        0x0000 },
+    { SGTL5000_CHIP_REF_CTRL,        0x0000 },
+    { SGTL5000_CHIP_MIC_CTRL,        0x0000 },
+    { SGTL5000_CHIP_LINE_OUT_CTRL,        0x0000 },
     { SGTL5000_CHIP_LINE_OUT_VOL,        0x0404 },
     { SGTL5000_CHIP_ANA_POWER,        0x7060 },
     { SGTL5000_CHIP_PLL_CTRL,        0x5000 },
+    { SGTL5000_CHIP_CLK_TOP_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_STATUS,        0x0000 },
+    { SGTL5000_CHIP_SHORT_CTRL,        0x0000 },
+    { SGTL5000_CHIP_ANA_TEST2,        0x0000 },
+    { SGTL5000_DAP_CTRL,            0x0000 },
+    { SGTL5000_DAP_PEQ,            0x0000 },
     { SGTL5000_DAP_BASS_ENHANCE,        0x0040 },
     { SGTL5000_DAP_BASS_ENHANCE_CTRL,    0x051f },
+    { SGTL5000_DAP_AUDIO_EQ,        0x0000 },
     { SGTL5000_DAP_SURROUND,        0x0040 },
+    { SGTL5000_DAP_FLT_COEF_ACCESS,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B0_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B0_LSB,        0x0000 },
     { SGTL5000_DAP_EQ_BASS_BAND0,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND1,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND2,        0x002f },
     { SGTL5000_DAP_EQ_BASS_BAND3,        0x002f },
-    { SGTL5000_DAP_EQ_BASS_BAND4,        0x002f },
+    { SGTL5000_DAP_EQ_BASS_BAND4,        0x002f },
     { SGTL5000_DAP_MAIN_CHAN,        0x8000 },
+    { SGTL5000_DAP_MIX_CHAN,        0x0000 },
     { SGTL5000_DAP_AVC_CTRL,        0x0510 },
     { SGTL5000_DAP_AVC_THRESHOLD,        0x1473 },
     { SGTL5000_DAP_AVC_ATTACK,        0x0028 },
     { SGTL5000_DAP_AVC_DECAY,        0x0050 },
+    { SGTL5000_DAP_COEF_WR_B1_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B1_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B2_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_B2_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A1_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A1_LSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A2_MSB,        0x0000 },
+    { SGTL5000_DAP_COEF_WR_A2_LSB,        0x0000 },
 };

,but now I am not able to play audio again after suspend/resume.
