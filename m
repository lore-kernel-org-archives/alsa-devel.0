Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C71C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:20:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725322072D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JuLnUBHR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="orlAfBXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725322072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F30971678;
	Mon, 17 Aug 2020 13:19:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F30971678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597663229;
	bh=1BxYmKlHGAYGgAGwfjEYuulG0rJG5NczRt9Xyo1ZNJ0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuLnUBHRn3ihy2ShTOAfOjqK3giryfEo77b+mgtAiGNdklBabJSsrNTa8/Hk4Vs6R
	 onZ0R8zQmkuKke+WH7aZ2qm1f2ygVbrFXj3RDoJGcDaQOa67u+cWPjXE0iLP5ik3VP
	 dyfWMx8I5Pe7swPSBqvW6f1PfX2KRvMvdz45DPzA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 810D7F80216;
	Mon, 17 Aug 2020 13:19:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D326F80218; Mon, 17 Aug 2020 13:19:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B6F7F800EF
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 13:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B6F7F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="orlAfBXK"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62F742072D;
 Mon, 17 Aug 2020 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597663168;
 bh=1BxYmKlHGAYGgAGwfjEYuulG0rJG5NczRt9Xyo1ZNJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=orlAfBXKzkdMjfZHKw8cKc2q8t0149ohjtuqqBWyQZlTURSTXhO2uMXf408ANifDa
 Vr5XIM50eYgzDpgpvUiX0yq9JZjSwEy0xHVfZ2OEQYoPAG1mj4VEensYL0M91HNWXx
 kCykOPPbx4fhzDqaEHzrJd9OpzJ1EyPl/dre9bOo=
Date: Mon, 17 Aug 2020 16:49:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 03/13] soundwire: intel: reset pm_runtime status during
 system resume
Message-ID: <20200817111924.GO2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200721203723.18305-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721203723.18305-4-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 22-07-20, 04:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The system resume does the entire bus re-initialization and brings it
> to full-power. If the device was pm_runtime suspended, there is no
> need to run the pm_runtime resume sequence after the system runtime.
> 
> Follow the documentation from runtime_pm.rst, and conditionally
> disable, set_active and re-enable the device on system resume.
> 
> Note that pm_runtime_suspended() is used instead of
> pm_runtime_status_suspended() so that we can deal with the case where
> pm_runtime is disabled.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index ed7163ae5f7a..284e5c9d240a 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1433,6 +1433,14 @@ static int intel_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	if (pm_runtime_suspended(dev)) {
> +		dev_dbg(dev,
> +			"%s: pm_runtime status: suspended\n",
> +			__func__);

first, can we have this in a single line, or better drop it
second why would this be called when device is suspended

> +
> +		return 0;
> +	}
> +
>  	ret = sdw_cdns_enable_interrupt(cdns, false);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot disable interrupts on suspend\n");
> @@ -1493,6 +1501,18 @@ static int intel_resume(struct device *dev)
>  		return 0;
>  	}
>  
> +	if (pm_runtime_suspended(dev)) {
> +		dev_dbg(dev,
> +			"%s: pm_runtime status was suspended, forcing active\n",
> +			__func__);

this one also could look better in a single line

> +
> +		/* follow required sequence from runtime_pm.rst */
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_enable(dev);
> +	}
> +
>  	ret = intel_init(sdw);
>  	if (ret) {
>  		dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.17.1

-- 
~Vinod
