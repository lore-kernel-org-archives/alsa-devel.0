Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28769C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:07:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBD920746
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R5B7VQs6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBHmGu3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBD920746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E242A17DA;
	Fri, 13 Mar 2020 13:07:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E242A17DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584101271;
	bh=q+0D/K3yLFpRrEgdR8NjgvruhvTmw4R8SOGsrQpR0ew=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5B7VQs6NONLxZPGg5tX5dbVFiv9nYv1CF6KLEzEjhe1JTyRArczeNcbqYUkRkMVb
	 w568B8KqOkTGw/mDW9K0fjrgMedg/fNtCn2xNzHhbWP+NKTN8sMFGP8JXTUqiL3oHc
	 jNpLdFS6iyvzbbMx3O6knOlhm4vBv5UTymhdFBQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7EE9F80086;
	Fri, 13 Mar 2020 13:06:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED1CDF801EB; Fri, 13 Mar 2020 13:06:19 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0DDFF8013E
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 13:06:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0DDFF8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SBHmGu3F"
Received: from localhost (unknown [171.76.107.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0C6F206FA;
 Fri, 13 Mar 2020 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584101171;
 bh=q+0D/K3yLFpRrEgdR8NjgvruhvTmw4R8SOGsrQpR0ew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SBHmGu3FIQGse3B1aLKIp3EXkV54dS0959MiD2uYZA5EqCZ/kL6frkYwsMoAjV8Ax
 wKf4cZpQG0/6QWcPEfXBy2irf4a3osCzdNE7xTj8zAjtRz1Q96zGy+3v8l3qYFDCLT
 pMWrrhFRTCQIjTZo0V4vr7/LIy69opgfqnnbDslQ=
Date: Fri, 13 Mar 2020 17:36:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 03/16] soundwire: cadence: add interface to check clock
 status
Message-ID: <20200313120607.GE4885@vkoul-mobl>
References: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
 <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311184128.4212-4-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>, Rander Wang <rander.wang@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 11-03-20, 13:41, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> If master is in clock stop state, driver can't modify registers
> in master except the registers for clock stop setting.
> 
> Signed-off-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 19 +++++++++++++++++++
>  drivers/soundwire/cadence_master.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 941809ea00a8..71cba2585151 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -1207,6 +1207,25 @@ static const struct sdw_master_port_ops cdns_port_ops = {
>  	.dpn_port_enable_ch = cdns_port_enable,
>  };
>  
> +/**
> + * sdw_cdns_is_clock_stop: Check clock status
> + *
> + * @cdns: Cadence instance
> + */
> +bool sdw_cdns_is_clock_stop(struct sdw_cdns *cdns)
> +{
> +	u32 status;
> +
> +	status = cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP;
> +	if (status) {
> +		dev_dbg(cdns->dev, "Clock is stopped\n");
> +		return true;
> +	}

This can be further optimized to:

        return !!(cdns_readl(cdns, CDNS_MCP_STAT) & CDNS_MCP_STAT_CLK_STOP);

-- 
~Vinod
