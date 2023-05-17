Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F4CC77B7D
	for <alsa-devel@archiver.kernel.org>; Wed, 17 May 2023 16:51:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA313E8;
	Wed, 17 May 2023 18:51:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA313E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684342312;
	bh=1mSQXJWCQ9lX0x3tGFr7Nl/lmeL6e4hiAkMTL3TSDuM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MwNy1e9qOQbAUdQasdrv6HX+BsAyCE1IbqGVfR8ZQ6y5l+MIV4AKBeaPopmffK6+7
	 lIhkj2tvBLX9baFNy7Jtn9/ZoE4wev/P/9bowSMlTmuLHcpXTtCqfMNCJz7GJvXFen
	 KjeVz8C8qNyG1LKEBY2zei/ZS88NthofKyUlKXUk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7E40F80578; Wed, 17 May 2023 18:50:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92967F80579;
	Wed, 17 May 2023 18:50:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1070DF80551; Wed, 17 May 2023 18:50:07 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB0D5F80272
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2023 18:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB0D5F80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=n6flfkh1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684342205; x=1715878205;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1mSQXJWCQ9lX0x3tGFr7Nl/lmeL6e4hiAkMTL3TSDuM=;
  b=n6flfkh1Rngoz8XJ33M5Ig4X5GJf8CmOEvMjnSjhN5y5VSFd5IgJ4Fvl
   B+pKejgKtMbYXejCoCKhLb4Mua4kBB5zseBeAP3SEmD+hkRQZ/ioO0HLL
   Yhbda2X98nbAOjg+hce+RfyJ/WJfbDCqNgZuuGyPu0G0TdFvZiXEAv6pt
   6clwcIWwDbqtq17WynEdBVgmpFlsJjkxjFhQKYrszzLDvK2wB/RXHev0f
   eB+L7DrtK5Y3OfppiOU+kB0YOAh2NlTIhGWAovBKAog9wT0K8kbDcKBGV
   IfWW/fkXTryUVdmT2P8wfNg9Wz2NlYluOX/bzKQKYE879fYdd5n7HhYre
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="350649407"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200";
   d="scan'208";a="350649407"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 09:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734764323"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200";
   d="scan'208";a="734764323"
Received: from pgopdahl-mobl1.amr.corp.intel.com (HELO [10.209.16.196])
 ([10.209.16.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 09:48:50 -0700
Message-ID: <805a61d6-64eb-5805-b0bf-74fcc317fb98@linux.intel.com>
Date: Wed, 17 May 2023 11:47:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] soundwire: debugfs: fix unbalanced pm_runtime_put()
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
 <20230517163750.997629-2-krzysztof.kozlowski@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230517163750.997629-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: FFDBND5IETOPYH5ERJKIXNKBVSYS3TVE
X-Message-ID-Hash: FFDBND5IETOPYH5ERJKIXNKBVSYS3TVE
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FFDBND5IETOPYH5ERJKIXNKBVSYS3TVE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 5/17/23 11:37, Krzysztof Kozlowski wrote:
> If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
> execution and finally called pm_runtime_put_autosuspend().  Since
> pm_runtime_resume_and_get() drops the usage counter on every error, this
> lead to double decrement of that counter.
> 
> Fixes: b275bf45ba1d ("soundwire: debugfs: Switch to sdw_read_no_pm")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index dea782e0edc4..c3a1a359ee5c 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -56,8 +56,9 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = pm_runtime_resume_and_get(&slave->dev);
> +	ret = pm_runtime_get_sync(&slave->dev);
>  	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(&slave->dev);
>  		kfree(buf);
>  		return ret;
>  	}
