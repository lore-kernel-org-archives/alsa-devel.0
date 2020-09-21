Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6FC43466
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:55:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3602076E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSmRuNib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3602076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3928D16D4;
	Mon, 21 Sep 2020 18:54:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3928D16D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600707315;
	bh=5smeGkczUozFteBSVQaVEdcxJ0HN486aJhTyVi3BbOk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSmRuNibrVqEBEDBfbW2Yf5yzHBHT2EOaMBy92v92DmYRGk4wbG29GgrX19KXsdIf
	 FHryIlYwmZVjy7BPBsgjeg4TtUW5+NtNn+Xfwip31jVORkiwpNXzgFtjIvnhqORkDN
	 7W+7TQMiEDjueRGuJy65KKgwBvoPikqtzQXO7YL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ABEDF802DD;
	Mon, 21 Sep 2020 18:52:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49300F802DF; Mon, 21 Sep 2020 18:52:47 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDD72F80162
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 18:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDD72F80162
IronPort-SDR: ZoUkDTJCs+6yMEm4Wcd9Il2nooNMZI1Sr0eHa2v/ZohcqJVxitmtOowPfdtR2AN/UeH0mgVHcR
 iFK+SHjFyIzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="160495333"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="160495333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 09:52:30 -0700
IronPort-SDR: 5RJiOTTblBblCOCLdCqeZdpTODNvGfTvttUdF8y2+pblkkxeROo1AqGfoGTx5NCGrX/TOYoNAC
 jLRYRnfD8sKw==
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="321831242"
Received: from apatwary-mobl.amr.corp.intel.com (HELO [10.212.120.65])
 ([10.212.120.65])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 09:52:28 -0700
Subject: Re: [PATCH 1/2] ASoC: rt700: wait for the delayed work to finish when
 the system suspends
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20200921094244.31869-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <087c1c6b-e108-22d8-c251-7c8c0a61fee4@linux.intel.com>
Date: Mon, 21 Sep 2020 09:29:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921094244.31869-1-shumingf@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, mengdong.lin@intel.com, derek.fang@realtek.com,
 flove@realtek.com, pierre-louis.bossart@intel.com
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



On 9/21/20 4:42 AM, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> To avoid the IO error, we need to cancel the delayed work and wait for it to finish.
> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/codecs/rt700-sdw.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
> index ead4918bbf90..c7deb4e4fcf1 100644
> --- a/sound/soc/codecs/rt700-sdw.c
> +++ b/sound/soc/codecs/rt700-sdw.c
> @@ -490,6 +490,9 @@ static int __maybe_unused rt700_dev_suspend(struct device *dev)
>   	if (!rt700->hw_init)
>   		return 0;
>   
> +	cancel_delayed_work_sync(&rt700->jack_detect_work);
> +	cancel_delayed_work_sync(&rt700->jack_btn_check_work);
> +
>   	regcache_cache_only(rt700->regmap, true);
>   
>   	return 0;
> 
