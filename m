Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A0DC64E7B
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 20:50:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D3E2073C
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 20:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uyWXveVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D3E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 247CB1700;
	Mon, 30 Nov 2020 21:49:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 247CB1700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606769431;
	bh=SXp3Q+aAnMd2hJ0MxXp1DBBdkcAKlYGgRUPAOf5bJkg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyWXveVGy+qqYxDEoiAUuS/Convf86SnPp2IleHyVmHylhe6ETL5L6rz66DRbDyUz
	 7vZMRtVrrgatLAha7im+YqZmDQGPg05aCUX7UDjgr5qB/oTa4agJ8IxJPBsCDXu9QY
	 ROieFmI74Gc344z9Z+faqCzf0Q9LCQBQkgXWg3mU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CA91F80254;
	Mon, 30 Nov 2020 21:49:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7222CF8025F; Mon, 30 Nov 2020 21:49:33 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5077F80146
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 21:49:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5077F80146
IronPort-SDR: omeQ878CmV6TesmeNoKE2aURvU7NzGB7+i2QFn2ijRXTVtxnCYGipu5gz7lDGUYpCXdB1VVkwe
 ClmnNzAItUew==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234313434"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="234313434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 12:49:21 -0800
IronPort-SDR: l56Kv88FxBl/g7uL0cUWjbZXa/xxgbrCaAcsyNjw772ia5128r3FdUn8oR744As54N2C3ch1GM
 22LAH4UIVNVw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="480800565"
Received: from whsiao-mobl.amr.corp.intel.com (HELO [10.209.17.17])
 ([10.209.17.17])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 12:49:21 -0800
Subject: Re: [PATCH] soundwire: Fix error return code in
 sdw_compute_port_params
To: Qinglang Miao <miaoqinglang@huawei.com>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
References: <20201125065035.154262-1-miaoqinglang@huawei.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fc8ffb8c-955e-ddf3-3113-52c8b7329696@linux.intel.com>
Date: Mon, 30 Nov 2020 11:35:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125065035.154262-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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



On 11/25/20 12:50 AM, Qinglang Miao wrote:
> Fix to return the error code -EINVAL in sdw_compute_port_params
> instead of 0.
> 
> Fixes: 9026118f20e2 ("soundwire: Add generic bandwidth allocation algorithm")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thanks for the patch.
The test covers a very unlikely error scenario but nevertheless not a 
zero probability so the suggested fix makes sense to me.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/generic_bandwidth_allocation.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
> index 0bdef38c9..ad857ac62 100644
> --- a/drivers/soundwire/generic_bandwidth_allocation.c
> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> @@ -283,8 +283,10 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (group.count == 0)
> +	if (group.count == 0) {
> +		ret = -EINVAL;
>   		goto out;
> +	}
>   
>   	params = kcalloc(group.count, sizeof(*params), GFP_KERNEL);
>   	if (!params) {
> 
