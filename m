Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC166C54EE9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 08:54:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24C1D1658;
	Mon, 19 Sep 2022 10:53:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24C1D1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663577649;
	bh=ZelDhvYGETW6vTz48/kGx9/Naj6tZGI84ZYZBKLByqw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGUHNUYKnVZwk6MojE6PcFhOZKARrDDK34jcLvhZgI6rt3V4lxx7O4DzpMxwbNN8I
	 PQzJEVD9lg3FekY0LalqgySvQFL+sTaWgeccp+oatDO++zLxid8tg41P1LAqVmB9Lg
	 e2R4QIydnjPawW2mvllQniyAIjDTatfLTafyO+BA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5EECF8053C;
	Mon, 19 Sep 2022 10:52:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B64ACF8053D; Mon, 19 Sep 2022 10:52:29 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 207FDF8023A
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 10:52:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 207FDF8023A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hCyYtrZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663577544; x=1695113544;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZelDhvYGETW6vTz48/kGx9/Naj6tZGI84ZYZBKLByqw=;
 b=hCyYtrZ1MEZpZAaMHacR7EJfv8+IpxNRho0UNy2dUiyN33WiSwrkGdr/
 u0G9wVrRZdRxqoe5XzA9T+lY4Uy4O3jdPCdibeHqwCaa7dzO0NWLNpT98
 EZa4mP3RzrKJK/hO140FyIQB78kBCBtnGHR1F5WQPB2smv90F7h+lPYIQ
 Jnrf1PYN/Vahhgw6xYp0e7P3lQeBiEnqGh+BZjj+dSHkFQ6OfSA8tSXSU
 6vg1nd1+wA5gS8dhqdK8l1uCrDGttX3PNUPPC4PmavxbWqZu3Ketcw6fz
 crTsg3sBf0JUGabCfl3H/m5vXx+kniza1zI97CbchDs6KUErYBKGLhv9j g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="296937561"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="296937561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 01:52:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="707485785"
Received: from ilick-mobl1.ger.corp.intel.com (HELO [10.252.59.91])
 ([10.252.59.91])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 01:52:17 -0700
Message-ID: <8d511299-5f92-603f-35e5-64e87b776286@linux.intel.com>
Date: Mon, 19 Sep 2022 10:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] soundwire: cadence: Simplify error paths in
 cdns_xfer_msg()
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
 <20220917154822.690472-2-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220917154822.690472-2-rf@opensource.cirrus.com>
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



On 9/17/22 17:48, Richard Fitzgerald wrote:
> There's no need to goto an exit label to return from cdns_xfer_msg().
> It doesn't do any cleanup, only a return statement.
> 
> Replace the gotos with returns.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/cadence_master.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 3543a923ee6b..30b8c628fdbd 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -709,17 +709,14 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
>  		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
>  				     CDNS_MCP_CMD_LEN, false);
>  		if (ret != SDW_CMD_OK)
> -			goto exit;
> +			return ret;
>  	}
>  
>  	if (!(msg->len % CDNS_MCP_CMD_LEN))
> -		goto exit;
> +		return SDW_CMD_OK;
>  
> -	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
> -			     msg->len % CDNS_MCP_CMD_LEN, false);
> -
> -exit:
> -	return ret;
> +	return _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
> +			      msg->len % CDNS_MCP_CMD_LEN, false);
>  }
>  EXPORT_SYMBOL(cdns_xfer_msg);
>  
