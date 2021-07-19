Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF7C07E9B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 18:26:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC64060FDB
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 18:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC64060FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AE351670;
	Mon, 19 Jul 2021 20:25:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AE351670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626719192;
	bh=CEUSIVf9yphIjs0g8rL0qORQEENmDbI1aS3191BGMEU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lj/1CCNE93zH9nBNueQMpvDUK4F/FxziwN1VTb5jLYHwSJueHq29ZOwqEji9cO6q/
	 eT3BM4/T9AZC0saPC7/AMpjPnL9lp+6tHQjGnjlPk49G/dAvCLUePGfpKk0BN+UESe
	 o+hJyVkuHihh9EUEofrg/mDO+02fIlD3Hwx2pF5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2CBBF804AC;
	Mon, 19 Jul 2021 20:24:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3FFBF80218; Mon, 19 Jul 2021 20:24:50 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D49CF80218
 for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2021 20:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D49CF80218
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190697638"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; d="scan'208";a="190697638"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 11:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; d="scan'208";a="414430049"
Received: from rraymond-mobl1.amr.corp.intel.com (HELO [10.209.130.70])
 ([10.209.130.70])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 11:24:38 -0700
Subject: Re: [PATCH V3 11/12] ASoC: amd: add vangogh i2s dma driver pm ops
To: Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
 <20210719165140.16143-12-vijendar.mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0bb947ff-9822-a83e-081e-b5456f05d8a9@linux.intel.com>
Date: Mon, 19 Jul 2021 13:13:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719165140.16143-12-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sunil-kumar.Dommati@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Alexander.Deucher@amd.com, krisman@collabora.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 7/19/21 11:51 AM, Vijendar Mukunda wrote:
> Add Vangogh i2s dma driver pm ops
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/vangogh/acp5x-pcm-dma.c | 90 +++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> index a2bd53dc86b9..260b6ae0fb2f 100644
> --- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> +++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/pm_runtime.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -417,13 +418,102 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
>  		return -ENODEV;
>  	}
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
>  	return 0;
>  }
>  
> +static int acp5x_audio_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
> +static int acp5x_pcm_resume(struct device *dev)
> +{
> +	struct i2s_dev_data *adata;
> +	u32 val, reg_val, frmt_val;
> +
> +	reg_val = 0;
> +	frmt_val = 0;
> +	adata = dev_get_drvdata(dev);
> +
> +	if (adata->play_stream && adata->play_stream->runtime) {
> +		struct i2s_stream_instance *rtd =
> +			adata->play_stream->runtime->private_data;
> +		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			reg_val = ACP_HSTDM_ITER;
> +			frmt_val = ACP_HSTDM_TXFRMT;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = ACP_I2STDM_ITER;
> +			frmt_val = ACP_I2STDM_TXFRMT;
> +		}
> +		acp_writel((rtd->xfer_resolution  << 3),
> +			   rtd->acp5x_base + reg_val);
> +	}
> +
> +	if (adata->capture_stream && adata->capture_stream->runtime) {
> +		struct i2s_stream_instance *rtd =
> +			adata->capture_stream->runtime->private_data;
> +		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
> +		switch (rtd->i2s_instance) {
> +		case I2S_HS_INSTANCE:
> +			reg_val = ACP_HSTDM_IRER;
> +			frmt_val = ACP_HSTDM_RXFRMT;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = ACP_I2STDM_IRER;
> +			frmt_val = ACP_I2STDM_RXFRMT;
> +		}
> +		acp_writel((rtd->xfer_resolution  << 3),
> +			   rtd->acp5x_base + reg_val);
> +	}
> +	if (adata->tdm_mode == TDM_ENABLE) {
> +		acp_writel(adata->tdm_fmt, adata->acp5x_base + frmt_val);
> +		val = acp_readl(adata->acp5x_base + reg_val);
> +		acp_writel(val | 0x2, adata->acp5x_base + reg_val);
> +	}
> +	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
> +	return 0;
> +}
> +
> +static int acp5x_pcm_suspend(struct device *dev)
> +{
> +	struct i2s_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	acp_writel(0, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
> +	return 0;
> +}
> +
> +static int acp5x_pcm_runtime_resume(struct device *dev)
> +{
> +	struct i2s_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
> +	return 0;
> +}


add __maybe_unused for all the suspend/resume functions, in case power management is not enabled

> +static const struct dev_pm_ops acp5x_pm_ops = {
> +	SET_RUNTIME_PM_OPS(acp5x_pcm_suspend,
> +			   acp5x_pcm_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(acp5x_pcm_suspend, acp5x_pcm_resume)
> +};
> +
>  static struct platform_driver acp5x_dma_driver = {
>  	.probe = acp5x_audio_probe,
> +	.remove = acp5x_audio_remove,
>  	.driver = {
>  		.name = "acp5x_i2s_dma",
> +		.pm = &acp5x_pm_ops,
>  	},
>  };
>  
> 
