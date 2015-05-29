From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/6] ASoC: zx: Add zx296702 SPDIF support
Date: Fri, 29 May 2015 16:03:38 +0200
Message-ID: <556871BA.3030408@metafoo.de>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-5-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 217A326068A
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 16:03:40 +0200 (CEST)
In-Reply-To: <1432906281-27698-5-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn
List-Id: alsa-devel@alsa-project.org

On 05/29/2015 03:31 PM, Jun Nie wrote:
[...]
> +static int zx_spdif_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct zx_spdif_info *zx_spdif;
> +	int ret;
> +
> +	zx_spdif =  kzalloc(sizeof(*zx_spdif), GFP_KERNEL);

extra space and devm_

> +	if (!zx_spdif)
> +		return -ENOMEM;
> +
> +	zx_spdif->dai_clk = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(zx_spdif->dai_clk)) {
> +		dev_err(&pdev->dev, "Fail to get clk\n");
> +		return PTR_ERR(zx_spdif->dai_clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	zx_spdif->mapbase = res->start;
> +	zx_spdif->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!zx_spdif->reg_base) {
> +		dev_err(&pdev->dev, "ioremap failed!\n");
> +		return -EIO;
> +	}
> +
> +	zx_spdif_dev_init(zx_spdif->reg_base);
> +	platform_set_drvdata(pdev, zx_spdif);
> +
> +	ret = snd_soc_register_component(&pdev->dev, &zx_spdif_component,
> +					 &zx_spdif_dai, 1);

devm_

> +	if (ret) {
> +		dev_err(&pdev->dev, "Register DAI failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
> +	if (ret)
> +		dev_err(&pdev->dev, "Register platform PCM failed: %d\n", ret);
> +
> +	return ret;
