Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96E5C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Jan 2022 01:06:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13F391867;
	Sat, 15 Jan 2022 02:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13F391867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642208806;
	bh=wZ0Ry+mIARE6XgrFHfixgiV08hKw7NCIewYKMb+m2qE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ep808YaSm3V8gMzKXimWkVsW/6+OBfSXt9Si/ao6yj3Xty4qOmNflxxpCMFM2O3eq
	 IXvrPmW1NECIbk2tFh1pmAc4KNDMZQPcjeRo6mgJZK6toYFp4649fUlKJSZTe8gAJi
	 DFWp/xrncUi2poPU3fd3ZW+XiESLQTnQwwZfucZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEB96F80141;
	Sat, 15 Jan 2022 02:05:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C9C7F8030F; Sat, 15 Jan 2022 02:05:52 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F016DF80141
 for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2022 02:05:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F016DF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="FTZRlQdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642208740; x=1673744740;
 h=subject:to:references:from:message-id:date:mime-version:
 in-reply-to:content-transfer-encoding;
 bh=wZ0Ry+mIARE6XgrFHfixgiV08hKw7NCIewYKMb+m2qE=;
 b=FTZRlQdRv4zupVeJQeEC8+sRBh1azA9zYgNVUoOHVTvDaIMmZEmO5+M3
 CsRHgjuvGBa9ufPghH/xtQmdriYMPl6TdteQfF4rUPnwBqQfTpkdOVE7k
 ykKSJ593GmP0UXmx3z7eA0cH6Ip5pwb+ZRrhSGCxct6cHbkzq7VM/0t3G
 9FirifhSFtjv0o9cTHtAvnJ5gSG85GeNccc8FEs+LY5kDz8Mo0v+xFjKF
 0MVrG+SrOGoN3+NIne80C9K5hA7EvPKl7dRcmYVV1PEBpmSe/L/IAQoBw
 47hAaKSD8M/JA8mu4UyFT0OvAuuZ3BP3fj4X2IMrZNIsOYF7PhRyNECim Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244319427"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; d="scan'208";a="244319427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:05:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; d="scan'208";a="624531822"
Received: from dsubasic-mobl.amr.corp.intel.com (HELO [10.212.67.37])
 ([10.212.67.37])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:05:31 -0800
Subject: Re: [PATCH] slimbus: qcom: Fix IRQ check in qcom_slim_probe
To: Miaoqian Lin <linmq006@gmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sagar Dharia <sdharia@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220114061830.13456-1-linmq006@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <239c3b32-6754-02ba-6bfd-7f05fa2adfed@linux.intel.com>
Date: Fri, 14 Jan 2022 09:14:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114061830.13456-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 1/14/22 12:18 AM, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.

the 'instead of' wording is a bit misleading:

platform_get_irq() returns non-zero IRQ number on success, negative
error number on failure. Zero is not a valid return valid.


> And the doc of platform_get_irq() provides a usage example:
> 
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
> 
> Fix the check of return value to catch errors correctly.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/slimbus/qcom-ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index f04b961b96cd..ec58091fc948 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,9 +510,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
>  	}
>  
>  	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (!ctrl->irq) {
> +	if (ctrl->irq < 0) {
>  		dev_err(&pdev->dev, "no slimbus IRQ\n");
> -		return -ENODEV;
> +		return ctrl->irq;
>  	}
>  
>  	sctrl = &ctrl->ctrl;
> 
