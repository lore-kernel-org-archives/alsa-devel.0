Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACADC54EE9
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Sep 2022 10:56:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E06AD1740;
	Fri, 16 Sep 2022 12:55:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E06AD1740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663325802;
	bh=fJFUW8+1F9qiAKmSsj0VidfyYyZ0hwH8viyxweFmXBk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=omtny1axZWPy8W7HhlDYIskFCBESCku1xIQW5tkNvap6+PqAD6UWzbIlFlGCMDZkJ
	 x2CUShkMf7l0jDlV4MXXpZTyf2M89zfR8meDtRmdkCyR6Mb9wIw4KyZNf6LvqO2lb7
	 977KazlIespu/B57NGrDRq0KpjuTAxPeX3zbb8PQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E94FF80254;
	Fri, 16 Sep 2022 12:55:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3355F802BE; Fri, 16 Sep 2022 12:55:49 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AF14F800E5
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2022 12:55:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AF14F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="M28QIdsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663325744; x=1694861744;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fJFUW8+1F9qiAKmSsj0VidfyYyZ0hwH8viyxweFmXBk=;
 b=M28QIdsqpBGyrw2BrQtBhH/MS8qKga+yl4Jpb4J+lqNf/Ctm9Vc/Q5C/
 zsV8H+jdEmIEfOwaQXbDBaDG1hkJjfne0nn3hfyMMhCQDuENHa226TF2d
 RkK9wHzZeNxsoYAwJp78smFnh7Jw0O5TqbH2trY9i2tDTw7QiYmaIR3eN
 ZVrzRb9sgM2C8b21bT/3d9OOa4EGN95dQm7IAIhZPZ6A/aJnO4vv6iK2X
 Nv/lSpWij+9CuqKbsyURIDxaS8ZbTvwxSRV1Rj17Z2okvYhz7v2Q3UWoe
 mVEMGqR2NCNUgF/bsKU+6lFPkSrdChuBPK5ZE1414/mQaS6BiPl/4Ql9O g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="279348822"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="279348822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 03:55:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="743298468"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56])
 ([10.252.61.56])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 03:55:35 -0700
Message-ID: <0f4154f6-ad5a-22e7-3b95-5a577c1dff47@linux.intel.com>
Date: Fri, 16 Sep 2022 12:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: cadence: Don't overwrite msg->buf during write
 commands
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20220916103505.1562210-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916103505.1562210-1-rf@opensource.cirrus.com>
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



On 9/16/22 12:35, Richard Fitzgerald wrote:
> The buf passed in struct sdw_msg must only be written for a READ,
> in that case the RDATA part of the response is the data value of the
> register.
> 
> For a write command there is no RDATA, and buf should be assumed to
> be const and unmodifable. The original caller should not expect its data
> buffer to be corrupted by an sdw_nwrite().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/cadence_master.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index be9cd47f31ec..3ef472049980 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -544,9 +544,12 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
>  		return SDW_CMD_IGNORED;
>  	}
>  
> -	/* fill response */
> -	for (i = 0; i < count; i++)
> -		msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA, cdns->response_buf[i]);
> +	if (msg->flags == SDW_MSG_FLAG_READ) {
> +		/* fill response */
> +		for (i = 0; i < count; i++)
> +			msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA,
> +							 cdns->response_buf[i]);
> +	}
>  
>  	return SDW_CMD_OK;
>  }
