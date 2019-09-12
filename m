Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39574C47404
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:24:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3779820856
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="POC6yPMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3779820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F639173D;
	Thu, 12 Sep 2019 15:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F639173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568294696;
	bh=fBOG7aJ7UTH7jlb6630h6fyFCnoQghFgqsT563KfmDY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=POC6yPMCC8e+n8VlDV++zF3atr2TN92xVMId58+CYspR/TsrCMQvW5KoAAEP4tMhR
	 A3ooQsxN5V8MDj4se94GnRR53wbGelfcg8bFiO2hyuKD24IVQtgBWRCGpRAw/GIqOR
	 hUnezwVQMUpca27MJQoi+tu48h4LpjUvn8fS20Dg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2BA0F80321;
	Thu, 12 Sep 2019 15:24:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0FD0F80368; Thu, 12 Sep 2019 15:24:04 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A089F801ED;
 Thu, 12 Sep 2019 15:23:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A089F801ED
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2019 06:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="269077660"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga001.jf.intel.com with ESMTP; 12 Sep 2019 06:23:57 -0700
Received: from vjyoung-mobl.amr.corp.intel.com (unknown [10.251.12.73])
 by linux.intel.com (Postfix) with ESMTP id 3E961580862;
 Thu, 12 Sep 2019 06:23:56 -0700 (PDT)
To: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>,
 alsa-devel@alsa-project.org, cezary.rojewski@intel.com
References: <20190912112441.28327-1-pawel.harlozinski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4e4294fa-4c85-6f88-70b9-a968a526518b@linux.intel.com>
Date: Thu, 12 Sep 2019 08:23:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912112441.28327-1-pawel.harlozinski@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, Szymon Mielczarek <szymonx.mielczarek@intel.com>,
 broonie@kernel.org, patch@alsa-project.org, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH v3] ASoC: Intel: Skylake: Recover BXT FW on
 DSP boot timeout error
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 9/12/19 6:24 AM, Pawel Harlozinski wrote:
> When DSP boots with timeout error try to reload firmware
> to keep best user expeirience.

experience

> 
> Change-Id: Ic7377da687e7441a487c443f9de1ebae5967afa2

please remove this Change-Id.

> Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@intel.com>
> Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/bxt-sst.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index 92a82e6b5fe6..fdf4c198445e 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -446,14 +446,19 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
>   
>   	/* If core 1 was turned on for booting core 0, turn it off */
>   		skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
> +		/* FIXME this FW recovery applies only for BXT */
>   		if (ret == 0) {
> -			dev_err(ctx->dev, "%s: DSP boot timeout\n", __func__);
> -			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
> +			dev_warn(ctx->dev,
> +				"DSP boot timeout: Error code=0x%x: FW status=0x%x. Reloading FW\n",
>   				sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
>   				sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
> -			dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
> -			ret = -EIO;
> -			goto err;
> +
> +			ret = bxt_sst_init_fw(skl->dev, skl);

Can you provide more explanations on the flow, if I look at the code I 
only see that this will load the firmware and library, which looks like 
the re-doing the start of this function set_dsp_D0, it doesn't seem to 
retry a boot so not sure in what state the DSP lands and if all the 
control variables such as boot_complete are set.

> +			if (ret < 0) {
> +				dev_err(ctx->dev, "Reload fw failed: %d. Failed to set core0 to D0 state\n",
> +				ret);
> +				goto err;

is there a reason why you removed the ret = -EIO assignment?

> +			}
>   		}
>   	}
>   
> @@ -478,7 +483,6 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
>   	if (core_id == SKL_DSP_CORE0_ID)
>   		core_mask |= SKL_DSP_CORE_MASK(1);
>   	skl_dsp_disable_core(ctx, core_mask);
> -
>   	return ret;
>   }
>   
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
