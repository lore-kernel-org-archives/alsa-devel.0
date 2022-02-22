Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F73AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 19:56:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF1DD1817;
	Tue, 22 Feb 2022 20:55:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF1DD1817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645559793;
	bh=VHSxbtD4mVx8CwpUuPAeIMnzDxuN5vCFvKRBG3+7rIs=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ija866uiAV5EI9BHzNQAvbZd2eLJCRl5j6GysMdq1W/JrvRQM1u9N0tos+qbdHUz9
	 BFYuWd8X3Jal4cchk6XbfRwker7/pxogL4JDR5rXebGL0Dm7BNqT1040hIdcn5vCzR
	 ZkgtJ9CErY8ML0QUc6Zf3NVFKa3EEo8ZalPr2/6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A522F80118;
	Tue, 22 Feb 2022 20:55:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAF01F801F5; Tue, 22 Feb 2022 20:55:39 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DAFAF800F5
 for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2022 20:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DAFAF800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="aG47/5z5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645559737; x=1677095737;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VHSxbtD4mVx8CwpUuPAeIMnzDxuN5vCFvKRBG3+7rIs=;
 b=aG47/5z59iEVbSa5HUTDpLcPR1vWUPHx+x2H/6SG0tzer08trdDzdDEK
 H6pe/3gY9LczO25bM5Kvwv5nDxenT9oBmOmsU0UzcnT6hbj2RPLTiSdrp
 eBMV7EelT5Qwlx5VzZ5vMaODbPB6Q4BbVKy+Xj9WH5EGt4wPm0bbzyQcP
 d8nulr+u72AwsrWHn2Wh8rQ6n+Cyd8PuQQncJRASPCe8hWU8IudPT9FIc
 ac86dfbbq+MD1Qu9lniV7JtXGKJL8bk7N+pIp7IpsR9CyNhsZGGth8giX
 FWDEYhQq7q5Jbtb1TV7CRMWvi1ee5OKMikq9Kor8e9KVg0uOCCRc9MdQG A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232421600"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="232421600"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 11:55:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="639032064"
Received: from mjpatel-mobl.amr.corp.intel.com (HELO [10.212.37.223])
 ([10.212.37.223])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 11:55:18 -0800
Message-ID: <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
Date: Tue, 22 Feb 2022 13:26:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, robh+dt@kernel.org, 
 vkoul@kernel.org, yung-chuan.liao@linux.intel.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
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




> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *swrm = dev_id;
> +	int ret = IRQ_HANDLED;
> +	struct sdw_slave *slave;
> +
> +	clk_prepare_enable(swrm->hclk);
> +
> +	if (swrm->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
> +			disable_irq_nosync(swrm->wake_irq);
> +	}
> +
> +	/*
> +	 * resume all the slaves which must have potentially generated this
> +	 * interrupt, this should also wake the controller at the same time.
> +	 * this is much safer than waking controller directly that will deadlock!
> +	 */
There should be no difference if you first resume the controller and
then attached peripherals, or do a loop where you rely on the pm_runtime
framework.

The notion that there might be a dead-lock is surprising, you would need
to elaborate here.

> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
> +		ret = pm_runtime_get_sync(&slave->dev);

In my experience, you don't want to blur layers and take references on
the child devices from the parent device. I don't know how many times we
end-up with weird behavior.

we've done something similar on the Intel side but implemented in a less
directive manner.

ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);

static int intel_resume_child_device(struct device *dev, void *data)
{
[...]	
	ret = pm_request_resume(dev);
	if (ret < 0)
		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);

	return ret;
}


> +		if (ret < 0 && ret != -EACCES) {
> +			dev_err_ratelimited(swrm->dev,
> +					    "pm_runtime_get_sync failed in %s, ret %d\n",
> +					    __func__, ret);
> +			pm_runtime_put_noidle(&slave->dev);
> +			ret = IRQ_NONE;
> +			goto err;
> +		}
> +	}
> +
> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
> +		pm_runtime_mark_last_busy(&slave->dev);
> +		pm_runtime_put_autosuspend(&slave->dev);
> +	}
> +err:
> +	clk_disable_unprepare(swrm->hclk);
> +	return IRQ_HANDLED;
> +}
> +

