From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: pcm: Require both CODEC and CPU
 support when declaring stream caps
Date: Sat, 1 Jun 2013 20:01:42 -0300
Message-ID: <CAOMZO5BWywZLbcTcfgFhJwsEnEuRJNRkROqjqWzVSWcGVDy1dQ@mail.gmail.com>
References: <1370124976-25047-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 17512265579
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 01:01:42 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id m16so1219365vca.16
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 16:01:42 -0700 (PDT)
In-Reply-To: <1370124976-25047-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Jun 1, 2013 at 7:16 PM, Mark Brown <broonie@linaro.org> wrote:
> When declaring playback and capture capabilities check for both CODEC
> side and CPU side support rather than only checking for CODEC side
> support.  While it is unusual some CPUs do have unidirectional DAIs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for the patch, but I still got the same output:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

I also tried:

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 365d9d2..b4a527d 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -601,24 +601,21 @@ static const struct snd_soc_dai_ops mxs_saif_dai_ops = {
 	.set_fmt = mxs_saif_set_dai_fmt,
 };

-static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
+static struct snd_soc_dai_driver mxs_saif_dai[] = {
 {
-	struct mxs_saif *saif = dev_get_drvdata(dai->dev);
-
-	snd_soc_dai_set_drvdata(dai, saif);
-
-	return 0;
-}
-
-static struct snd_soc_dai_driver mxs_saif_dai = {
-	.name = "mxs-saif",
-	.probe = mxs_saif_dai_probe,
+	.name = "saif0",
+	.id = 0,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = MXS_SAIF_RATES,
 		.formats = MXS_SAIF_FORMATS,
 	},
+	.ops = &mxs_saif_dai_ops,
+},
+{
+	.name = "saif1",
+	.id = 1,
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -626,6 +623,7 @@ static struct snd_soc_dai_driver mxs_saif_dai = {
 		.formats = MXS_SAIF_FORMATS,
 	},
 	.ops = &mxs_saif_dai_ops,
+},
 };

 static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
@@ -772,7 +770,8 @@ static int mxs_saif_probe(struct platform_device *pdev)

 	platform_set_drvdata(pdev, saif);

-	ret = snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
+	ret = snd_soc_register_dais(&pdev->dev, mxs_saif_dai,
+						ARRAY_SIZE(mxs_saif_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
 		return ret;
-- 
1.8.1.2

,but this did not work either.

I will have to debug more.

Thanks,

Fabio Estevam
