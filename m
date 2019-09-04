Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A453C3A5A9
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:15:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2276F23402
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DOJTt2OU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhBTLeuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2276F23402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BFAE1669;
	Wed,  4 Sep 2019 09:14:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BFAE1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567581323;
	bh=msIScjnnGQkypxfyHhOIzM/SEU5wc5hZzXAey0KQHM8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOJTt2OU/zKUaGcyoq7NhIdYOFUK9b058gcS5ZO6+xieZx+kn1/jBaeNtcYKecJX+
	 6FiymxzbW5bg0ivJmAi/thTIKBI7Dvnnw28PQI9jsKk0+gphW5YJKLmNbFliiwpr44
	 6oAIyilVhsmwIc5pdID6zDaT+2Wh2vwju2Ew2dXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8C99F80394;
	Wed,  4 Sep 2019 09:14:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45E12F803A6; Wed,  4 Sep 2019 09:14:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C44EF8011E
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 09:14:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C44EF8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XhBTLeuw"
Received: from localhost (unknown [122.182.201.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3A6D22CEA;
 Wed,  4 Sep 2019 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567581265;
 bh=NNC+RkkJ+eyITyoMs4o1gFL0TAFukDFGUWCl2aimc18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XhBTLeuw97W8DprCY1IMVU6AdWo9PaTC7PJNuXO6HzMcs8KiXB+r/kBYAe39/5zir
 sPdcD6rlDeUxYQxDEk+mwM/j6EEXXjljTJX8YSfpZNvbLVdpcinoL2U9CQkPLszhz3
 VuVt9dCMUtswZmUlmQ428EVv4SMmMXfeV75K8qCk=
Date: Wed, 4 Sep 2019 12:43:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20190904071317.GJ2672@vkoul-mobl>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: cadence_master: add
 hw_reset capability in debugfs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
> Provide debugfs capability to kick link and devices into hard-reset
> (as defined by MIPI). This capability is really useful when some
> devices are no longer responsive and/or to check the software handling
> of resynchronization.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 046622e4b264..bd58d80ff636 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>  
> +static int cdns_hw_reset(void *data, u64 value)
> +{
> +	struct sdw_cdns *cdns = data;
> +	int ret;
> +
> +	if (value != 1)
> +		return 0;

Should this not be EINVAL to indicate invalid value passed?

> +
> +	ret = sdw_cdns_exit_reset(cdns);
> +
> +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> +
>  /**
>   * sdw_cdns_debugfs_init() - Cadence debugfs init
>   * @cdns: Cadence instance
> @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>  {
>  	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +
> +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
> +			    &cdns_hw_reset_fops);
>  }
>  EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
>  
> -- 
> 2.20.1

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
