Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43386C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 16:00:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC48D16DC;
	Mon,  7 Mar 2022 16:59:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC48D16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646668815;
	bh=UIQ205em1WrlnAoEopCeQjugklgipYmQxrXTFmaWBqc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mV8ItRfzvOv4CNYj9O9gpVO2k/DAVs26APLt5fDIsztxt1xRL8nzSxLz6+NrlHOIU
	 scL5TopGmlpPk+aCOQsiiS0g5xogJ1VflB+M4m56/JX+8Ix7/Thbt+pklq17Gs+CdI
	 93JddkFv/NMr7/aanjqBPAc4rkz8djYgrb4C/n24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55FA5F80132;
	Mon,  7 Mar 2022 16:59:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B447F8013F; Mon,  7 Mar 2022 16:59:24 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B149F80124
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 16:59:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B149F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ZppUW8v/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646668762; x=1678204762;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UIQ205em1WrlnAoEopCeQjugklgipYmQxrXTFmaWBqc=;
 b=ZppUW8v/JCkEfzHtTPrgS8bBC29x/fYh6isFNjUk+SZkrg4YhE71Ym8e
 CVYjqgFlKtGXeaEhYE/fr1KGEgVldDurbsKV8xOUvH3JbyCDUKYhy+yGP
 xj5JgrAYH1L+5Fl/gTSqDLfKQNgCEymVfI/JPTMtMPPzWICpSv8NHnC5j
 8NrJ95WmJCJbOWiiHGPZLt2wul62z2iBpebn+0wU6w1nfeATqaMdRRT+9
 ycCGzun6PUnzpKNc5xPpPTnS+nAMNilL06ObzwRZ6+oc6RgbHrr3rcqaE
 vV4Y/dWv0GRfgNDFWuImBkUI5NWFMNZW1ocUDi2rlQNJMXIuzPhM0Qcaz A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="241857483"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="241857483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 07:59:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; d="scan'208";a="643292226"
Received: from rhack-mobl1.amr.corp.intel.com (HELO [10.209.14.71])
 ([10.209.14.71])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 07:59:17 -0800
Message-ID: <def6807f-5d5d-5d08-7705-70c907b23805@linux.intel.com>
Date: Mon, 7 Mar 2022 09:24:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH -next] soundwire: stream: Fix error return code in
 do_bank_switch()
Content-Language: en-US
To: Wang Wensheng <wangwensheng4@huawei.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220307074039.117488-1-wangwensheng4@huawei.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220307074039.117488-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: xuqiang36@huawei.com
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



On 3/7/22 01:40, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>

Thanks for the patch, sounds good to me.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/stream.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 980f26d49b66..553131597af6 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -822,6 +822,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   		} else if (multi_link) {
>   			dev_err(bus->dev,
>   				"Post bank switch ops not implemented\n");
> +			ret = -EINVAL;
>   			goto error;
>   		}
>   
