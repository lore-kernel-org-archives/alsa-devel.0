Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BF9C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jun 2022 07:56:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 997EA1B32;
	Thu, 23 Jun 2022 09:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 997EA1B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655970991;
	bh=+mCsuKkg6J4843YgoICH76eZkbbsWWPv4bN1r397BFU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hlt/1R2aOW1s1VuqxXFPIMwnuu+MWcHdw3IIL5gql3tqcBaiNsnZXYTjWennlwCgJ
	 iuRLwEJvwyeTM/4VXwxNquiZ/WgGr2Qa2yyemRUWy0waV1aS+iLT3aHLQIf947QFqW
	 yoxOv2BHu+EdmLLZthmvsEq8pJduT9RurySy6r8g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16545F804BB;
	Thu, 23 Jun 2022 09:55:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC606F804C1; Thu, 23 Jun 2022 09:55:38 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 456B4F800CB
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2022 09:55:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 456B4F800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ryn/wFyI"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 86D0AB8204D;
 Thu, 23 Jun 2022 07:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96720C3411B;
 Thu, 23 Jun 2022 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655970928;
 bh=+mCsuKkg6J4843YgoICH76eZkbbsWWPv4bN1r397BFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ryn/wFyICQZLHrQUR7HdI9ruJoyDQO4rvJTV6kIaJItCZA7TrYXFQmtn+C1MFr4t0
 Uggw5RZjt97WHgadbomOND0G6IEZVUow7NnL/t9Pb4N8pJp2ZkGR/ii4JnaToVqnUD
 yXqGhU1qM/T3Hhvo+I9ObGBIA9i2oO6j4COS/yg9GliuywGOj4iAqFrizLnQ86AcKw
 sHvytYP4CY/UskGrquWz8o+i05nr3LIv4ffQh3raROCD5oYgeBxE+NKBwzaT95QJZR
 P+FmP3Aaf445fPgIO674cr+tUwXte0DfPKpMNrv00V7FTaqE6FB7hi0e/c1hoXLGe7
 ZYlLam1dG7i+g==
Date: Thu, 23 Jun 2022 13:25:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus_type: fix remove and shutdown support
Message-ID: <YrQca7YH8v6XCl02@matsya>
References: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

On 10-06-22, 09:51, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The bus sdw_drv_remove() and sdw_drv_shutdown() helpers are used
> conditionally, if the driver provides these routines.
> 
> These helpers already test if the driver provides a .remove or
> .shutdown callback, so there's no harm in invoking the
> sdw_drv_remove() and sdw_drv_shutdown() unconditionally.

Okay sounds good

> In addition, the current code is imbalanced with
> dev_pm_domain_attach() called from sdw_drv_probe(), but
> dev_pm_domain_detach() called from sdw_drv_remove() only if the driver
> provides a .remove callback.

Am not sure I follow what is imbalance, pm_domain_attach/detach?

> Fixes: 9251345dca24b ("soundwire: Add SoundWire bus type")

How is this a fix is still unclear to me. At best I think this is code
optimization and removing checks which maybe redundant.

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 893296f3fe39..b81e04dd3a9f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -193,12 +193,8 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
>  
>  	drv->driver.owner = owner;
>  	drv->driver.probe = sdw_drv_probe;
> -
> -	if (drv->remove)
> -		drv->driver.remove = sdw_drv_remove;
> -
> -	if (drv->shutdown)
> -		drv->driver.shutdown = sdw_drv_shutdown;
> +	drv->driver.remove = sdw_drv_remove;
> +	drv->driver.shutdown = sdw_drv_shutdown;
>  
>  	return driver_register(&drv->driver);
>  }
> -- 
> 2.17.1

-- 
~Vinod
