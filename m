From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 6/6] ASoC: samsung: Fix of-node refcount
 unbalance in odroid_audio_probe()
Date: Tue, 19 Feb 2019 17:36:56 +0100
Message-ID: <69d7e286-9ae0-71c8-af82-cc5eb4919d16@samsung.com>
References: <20190219154652.13644-1-tiwai@suse.de>
 <CGME20190219154757epcas4p2e9cdfcf26df7e5ec39c16ceec964f6d0@epcas4p2.samsung.com>
 <20190219154652.13644-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 344D6265538
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 17:37:03 +0100 (CET)
In-reply-to: <20190219154652.13644-7-tiwai@suse.de>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2/19/19 16:46, Takashi Iwai wrote:
> odroid_audio_probe() leaves of-nodes without unreferenced after use.
> Fix it by shuffling some code a bit and add the missing of_node_put()
> calls accordingly.
> 
> Fixes: aba611fc4c69 ("ASoC: samsung: Add Odroid ASoC machine driver")
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Only compile-tested.  Please review carefully.  Thanks!
Thanks for the patch. Current code for 5.1 is a bit different and we 
may now need something like:

----8<----
diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index bd2c5163dc7f..c3b0f6c612cb 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -257,27 +257,31 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
 						 "#sound-dai-cells", i, &args);
 		if (ret < 0)
-			return ret;
+			break;
 
 		if (!args.np) {
 			dev_err(dev, "sound-dai property parse error: %d\n", ret);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
 		of_node_put(args.np);
 
 		if (ret < 0)
-			return ret;
+			break;
 	}
+	if (ret == 0)
+		cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 
-	cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 	of_node_put(cpu);
 	of_node_put(codec);
+	if (ret < 0)
+		return ret;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 
 	/* Set capture capability only for boards with the MAX98090 CODEC */
 	if (codec_link->num_codecs > 1) {
@@ -288,7 +292,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	priv->sclk_i2s = of_clk_get_by_name(cpu_dai, "i2s_opclk1");
 	if (IS_ERR(priv->sclk_i2s)) {
 		ret = PTR_ERR(priv->sclk_i2s);
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 	}
 
 	priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
@@ -310,7 +314,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	clk_put(priv->clk_i2s_bus);
 err_put_sclk:
 	clk_put(priv->sclk_i2s);
-err_put_codec_n:
+err_put_cpu_dai:
+	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
 	return ret;
 }
----8<----

-- 
Thanks,
Sylwester
