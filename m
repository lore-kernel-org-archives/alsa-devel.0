Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B97C4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:44:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8977B20739
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IUX1bT2S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK13Wl2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8977B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5E8417C6;
	Fri, 20 Mar 2020 14:43:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5E8417C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584711838;
	bh=7RGOPJR25CwJirzAerwKnDLjD3O8PXRhRx7qMiLnguk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IUX1bT2S4HrVzNCQfbo55j0s9ksEpuTcQhuYv4gHQBqLliN7GLM3I5SGQofItspI5
	 eM94urRdMNZjkAJ+bfVE+GLDeNZNNR3vcyZvYkaQUOCGlPnxrCVZn7YOL9jrRt0Opn
	 YvzaBdHgGIoLuYvc0zf0qAeWpglveydLnv7VFHy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 515A5F800DD;
	Fri, 20 Mar 2020 14:43:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55BB4F8015B; Fri, 20 Mar 2020 14:43:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84099F800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 14:43:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84099F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IK13Wl2S"
Received: from localhost (unknown [122.167.82.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1FE3220739;
 Fri, 20 Mar 2020 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584711780;
 bh=7RGOPJR25CwJirzAerwKnDLjD3O8PXRhRx7qMiLnguk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IK13Wl2SiISx3G3YrNWIFPq1yrUzhqhUSirhjg5S49ODZ5Pf4p+riDnww6UOdd75Y
 jpGDNpLNPYlthJ0Y+RjRx+A1ks9jCrbf6CfqUEZ8L0pnCxEoeq0iiDOEcVbmkGvQMA
 cf1LRS3Ms5uw6M3FX/5B2y0BUEHCsJKFcy0xw2uc=
Date: Fri, 20 Mar 2020 19:12:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/7] soundwire: intel: add definitions for shim_mask
Message-ID: <20200320134257.GD4885@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
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

On 11-03-20, 17:10, Pierre-Louis Bossart wrote:
> We want to make sure SHIM register fields such as SYNCPRD are only
> programmed once. Since we don't have a controller-level driver, we
> need master-level drivers to collaborate: the registers will only be
> programmed when the first link is powered-up.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.h           | 2 ++
>  include/linux/soundwire/sdw_intel.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> index 568c84a80d79..cfc83120b8f9 100644
> --- a/drivers/soundwire/intel.h
> +++ b/drivers/soundwire/intel.h
> @@ -16,6 +16,7 @@
>   * @ops: Shim callback ops
>   * @dev: device implementing hw_params and free callbacks
>   * @shim_lock: mutex to handle access to shared SHIM registers
> + * @shim_mask: global pointer to check SHIM register initialization
>   */
>  struct sdw_intel_link_res {
>  	struct platform_device *pdev;
> @@ -27,6 +28,7 @@ struct sdw_intel_link_res {
>  	const struct sdw_intel_ops *ops;
>  	struct device *dev;
>  	struct mutex *shim_lock; /* protect shared registers */
> +	u32 *shim_mask;

You have a pointer, okay where is it initialized

>  };
>  
>  #endif /* __SDW_INTEL_LOCAL_H */
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index 979b41b5dcb4..120ffddc03d2 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -115,6 +115,7 @@ struct sdw_intel_slave_id {
>   * links
>   * @link_list: list to handle interrupts across all links
>   * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
> + * @shim_mask: flags to track initialization of SHIM shared registers
>   */
>  struct sdw_intel_ctx {
>  	int count;
> @@ -126,6 +127,7 @@ struct sdw_intel_ctx {
>  	struct sdw_intel_slave_id *ids;
>  	struct list_head link_list;
>  	struct mutex shim_lock; /* lock for access to shared SHIM registers */
> +	u32 shim_mask;

And a integer, question: why do you need pointer and integer, why not
use only one..?

-- 
~Vinod
