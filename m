Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5CECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Sep 2022 12:02:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C3DE1657;
	Mon, 12 Sep 2022 14:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C3DE1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662984136;
	bh=zkOXQ6fic21iBzYMitvf8khwq2yyDU+RwPlIGr7j6/o=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrvHuXW4O1TfEafGWJu0X+WJt/tntbQmhXzaeFeTzk4D9t1ltuHUsiIeK/cE7Ee8m
	 NDgc+LDfdv+IB3+dJwRAmLinF7+La9qmULGFFGGElKMRsvGDD8cWVOTjkpuZxsCoGJ
	 mvM+BPDGgiq/nn3MflP1HTkHVr10P4vUFb7pE/SY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5A78F8055B;
	Mon, 12 Sep 2022 14:00:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55AC3F80552; Mon, 12 Sep 2022 14:00:23 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9442EF80552
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2022 14:00:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9442EF80552
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ihzgmc0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662984017; x=1694520017;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zkOXQ6fic21iBzYMitvf8khwq2yyDU+RwPlIGr7j6/o=;
 b=ihzgmc0VLKgqKaoy1O8oVfLc40Ac1c7tduyuNks9np5iw+VwEQoUpxP+
 jeN1fXKcwh79J7Bt1eJWokqoUn2/Qq6sTfIuTQlyRcgS5Awfu6shrG1yh
 xAjw54cjbYRxJDS3wUMELGn/0Hjy4c8ZY6v9XY3DFU2ZZG4XL4L1Fz9i7
 3aVAB6+MS0e3abRmwzEnOT+nmq620N/buvv1M73HZdl8B/B4p0W46K1fY
 BF5bVCutYCFU+idjXKkA9kXHdNtQpL6ZkQbmpuliysqX+mb9F4v2qKs9c
 TzqWEQcz8SVKZ3lk89K+QNp9sAYSpwcP3H3cilMJIHj3ffIH6K1po6Bp1 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="295430400"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; d="scan'208";a="295430400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2022 05:00:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; d="scan'208";a="705126574"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67])
 ([10.252.32.67])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2022 05:00:11 -0700
Message-ID: <35122b05-4d2f-8c9c-eb5e-c0f96ef585a4@linux.intel.com>
Date: Mon, 12 Sep 2022 13:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] soundwire: cadence: Fix lost ATTACHED interrupts
 when enumerating
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-5-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907085259.3602-5-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 9/7/22 10:52, Richard Fitzgerald wrote:
> The correct way to handle interrupts is to clear the bits we
> are about to handle _before_ handling them. Thus if the condition
> then re-asserts during the handling we won't lose it.
> 
> This patch changes cdns_update_slave_status_work() to do this.
> 
> The previous code cleared the interrupts after handling them.
> The problem with this is that when handling enumeration of devices
> the ATTACH statuses can be accidentally cleared and so some or all
> of the devices never complete their enumeration.
> 
> Thus we can have a situation like this:
> - one or more devices are reverting to ID #0
> 
> - accumulated status bits indicate some devices attached and some
>   on ID #0. (Remember: status bits are sticky until they are handled)
> 
> - Because of device on #0 sdw_handle_slave_status() programs the
>   device ID and exits without handling the other status, expecting
>   to get an ATTACHED from this reprogrammed device.
> 
> - The device immediately starts reporting ATTACHED in PINGs, which
>   will assert its CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit.
> 
> - cdns_update_slave_status_work() clears INTSTAT0/1. If the initial
>   status had CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit set it will be
>   cleared.
> 
> - The ATTACHED change for the device has now been lost.
> 
> - cdns_update_slave_status_work() clears CDNS_MCP_INT_SLAVE_MASK so
>   if the new ATTACHED state had set it, it will be cleared without
>   ever having been handled.
> 
> Unless there is some other state change from another device to cause
> a new interrupt, the ATTACHED state of the reprogrammed device will
> never cause an interrupt so its enumeration will not be completed.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/cadence_master.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 245191d22ccd..3acd7b89c940 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  	u32 device0_status;
>  	int retry_count = 0;
>  
> +	/*
> +	 * Clear main interrupt first so we don't lose any assertions
> +	 * the happen during this function.
> +	 */
> +	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +
>  	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
>  	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
>  
> +	/*
> +	 * Clear the bits before handling so we don't lose any
> +	 * bits that re-assert.
> +	 */
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
> +
>  	/* combine the two status */
>  	slave_intstat = ((u64)slave1 << 32) | slave0;
>  
> @@ -964,8 +977,6 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  
>  update_status:
>  	cdns_update_slave_status(cdns, slave_intstat);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);

this one is hard to review, if you don't clear the status here, then how
does the retry work if there is a new event?

Put differently, do we need to retry and the 'goto update_status' any more?

>  
>  	/*
>  	 * When there is more than one peripheral per link, it's
> @@ -1001,8 +1012,7 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  		}
>  	}
>  
> -	/* clear and unmask Slave interrupt now */
> -	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +	/* unmask Slave interrupt now */
>  	cdns_updatel(cdns, CDNS_MCP_INTMASK,
>  		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
>  
