From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Sun, 3 Sep 2017 12:44:17 +0000
Message-ID: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0065.outbound.protection.outlook.com [104.47.2.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C35B1266DCC
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 14:44:18 +0200 (CEST)
In-Reply-To: <1504436701-20700-1-git-send-email-lukma@denx.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukasz Majewski <lukma@denx.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

[Sorry for the top-posting]


The driver currently has:


/*
* Hardware limitation: The bclk rate must be
* never greater than 1/5 IPG clock rate
*/
if (freq * 5 > clk_get_rate(ssi_private->clk)) {
dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
return -EINVAL;
}


Isn't this properly taking care of the clock restriction?

________________________________
From: Lukasz Majewski <lukma@denx.de>
Sent: Sunday, September 3, 2017 8:05:01 AM
To: Timur Tabi; Nicolin Chen; Xiubo Li; Fabio Estevam; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai
Cc: alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Lukasz Majewski
Subject: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal to system freq

The problem is visible in the following setup (on the imx6q):
"simple-audio-card" -> ssi2 -> I2S + I2C -> codec

The function call log (simple-card probe -> CONFIG_SND_SIMPLE_CARD):

asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c
snd_soc_dai_set_sysclk()
fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c

The last call is changing the bit clock (BCLK) frequency to SSI's IP
block clock (ipg = 66 MHz) [1].
This is wrong, since IMX SSI block requires the I2S BCLK to be less
than 1/5 of [1].

As a result the driver initialization passes without any errors, but the
speaker-test test case breaks.

This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
not equal to [1].

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 173cb84..1186fa9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
                 int clk_id, unsigned int freq, int dir)
 {
         struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+       if (clk_get_rate(ssi_private->clk) == freq)
+               return 0;

         ssi_private->bitclk_freq = freq;

--
2.1.4
