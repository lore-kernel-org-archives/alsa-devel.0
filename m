Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCAFC433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:42:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5E561009
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 14:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5E561009
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A15C81671;
	Wed, 31 Mar 2021 16:41:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A15C81671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617201754;
	bh=t9gaxHXzMkc3vmfJuA6SyCsF4VG3xgcsJQyJtsfuvU8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xv6D/XRbHwJfFYdQq5YET4/MsNA9mrIaWgKEr8R/aQjLLRUZWSqKwwbC0nZbFG5NH
	 E1gS6X43axE4I3Net/cW2oZxV0cB6FcHmiVcCx90+kMbrAuDd+I62JAw/Kxq+GgGX/
	 sY4B3uQ9JQ3qtBuESMYGG7kvpaGr4gkx5NhFYJxs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D879F8015A;
	Wed, 31 Mar 2021 16:41:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA3D1F80166; Wed, 31 Mar 2021 16:41:42 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E33BCF8013F
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 16:41:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E33BCF8013F
IronPort-SDR: 527X29pfYBgdZbQeYLS0lJTFy6YiLyVnSKnabbpTzMtnI+4cOOX67tvOJJHiKNcF9QQLgNi9dX
 Ml1nvu71GBtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179553698"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; d="scan'208";a="179553698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 07:41:26 -0700
IronPort-SDR: vkzzsBYmQzWnxqIFwGewwH9SSQ55VgOas4ODz/oxJGoOE9M2SSm5/UdqrUfAr/5aPV/ogqjQBr
 lorrFe695/ig==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; d="scan'208";a="610536384"
Received: from erikberx-mobl4.amr.corp.intel.com (HELO [10.212.230.42])
 ([10.212.230.42])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 07:41:25 -0700
Subject: Re: [PATCH] soundwire: qcom: use signed variable for error return
To: Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20210331072111.2945945-1-vkoul@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9cdef4e9-a38a-6c77-1b23-739f85384b12@linux.intel.com>
Date: Wed, 31 Mar 2021 09:41:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331072111.2945945-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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



On 3/31/21 2:21 AM, Vinod Koul wrote:
> We get warning for using a unsigned variable being compared to less than
> zero. The comparison is correct as it checks for errors from previous
> call to qcom_swrm_get_alert_slave_dev_num(), so we should use a signed
> variable instead.
> 
> drivers/soundwire/qcom.c: qcom_swrm_irq_handler() warn: impossible
> condition '(devnum < 0) => (0-255 < 0)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/soundwire/qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b08ecb9b418c..55ed133c6704 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   	struct qcom_swrm_ctrl *swrm = dev_id;
>   	u32 value, intr_sts, intr_sts_masked, slave_status;
>   	u32 i;
> -	u8 devnum = 0;
> +	s8 devnum = 0;

it's not great to store negative error codes with s8. That works in this 
specific case because the function only returns -EINVAL.

We actually have zero occurrences of s8 in the drivers/soundwire/ code.

>   	int ret = IRQ_HANDLED;
>   
>   	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> 
