Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAABC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 14:41:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C76A1727;
	Fri, 20 May 2022 16:41:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C76A1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653057715;
	bh=QnszhtvhouVRGGtJ1BImAOgQzjjpIeBfd01w+p8YnwU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ASLw+eZxqZeeUclU06vZKjw7mQSviEsSrtAa1z7gqzl1D38Tff/U2bRoFhj9FxAm9
	 JwcWnYNLJf+tuT+MOwxoWKiI5KTR88ka6F69JgXEwp8Lbds1gvYW7cORuohBYFwmHS
	 ESnMsG4ZIkrESjYKfRnxoYDYN1VWnRAQCRdEkvhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3935F80153;
	Fri, 20 May 2022 16:41:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63361F8019D; Fri, 20 May 2022 16:41:03 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 421F5F80109
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 16:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 421F5F80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="CfMKxuAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653057657; x=1684593657;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QnszhtvhouVRGGtJ1BImAOgQzjjpIeBfd01w+p8YnwU=;
 b=CfMKxuABVBcJpVcaDToUeaJK2RX+JulCj4BrWYMydBdjt/z57pB9ckbV
 FTaYc7flh4AsXPB59VhVxZi0FbqyEVxOQLxvfp3j/4r9xuMIwJZLqCpBg
 kpIvI2iDra4W2eAT+0PRFDEXNvUyimcs7jiCaSyBeusPhN7r4LuEbZZwx
 KKWD5qIIzs88cIiqF+2BDhXgmS5FrCQrcGuNLUZckDF0f6Rs/Bbo/h4Ye
 SlP6LFJ5LRzC/2w5tFY/r0pHRAUs9EEScXWH0/bomHdh5Vyvb1fJWP8Dk
 hhO/rxMprIYxPplZBsawfsdRIQOZMmH3QRmeTgjF5wPlXEvKVArOHyL21 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="254681907"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="254681907"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 07:40:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="599251940"
Received: from vphopper-mobl.amr.corp.intel.com (HELO [10.252.133.54])
 ([10.252.133.54])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 07:40:52 -0700
Message-ID: <9fb8fad5-74f7-f6ae-95e0-f1c181532a71@linux.intel.com>
Date: Fri, 20 May 2022 09:24:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: rt1308-sdw: add the default value of register 0xc320
Content-Language: en-US
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20220520090205.25857-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220520090205.25857-1-shumingf@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, flove@realtek.com,
 bard.liao@intel.com, pierre-louis.bossart@intel.com
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



On 5/20/22 04:02, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> The driver missed the default value of register 0xc320.
> This patch adds that default value to avoid the error messages
> when the driver went to suspend mode already.
> 
> BugLink: https://github.com/thesofproject/linux/issues/3651
> Signed-off-by: Shuming Fan <shumingf@realtek.com>

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/rt1308-sdw.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
> index c5ce75666dcc..6668e19d85d4 100644
> --- a/sound/soc/codecs/rt1308-sdw.h
> +++ b/sound/soc/codecs/rt1308-sdw.h
> @@ -140,6 +140,7 @@ static const struct reg_default rt1308_reg_defaults[] = {
>  	{ 0x3008, 0x02 },
>  	{ 0x300a, 0x00 },
>  	{ 0xc003 | (RT1308_DAC_SET << 4), 0x00 },
> +	{ 0xc000 | (RT1308_POWER << 4), 0x00 },
>  	{ 0xc001 | (RT1308_POWER << 4), 0x00 },
>  	{ 0xc002 | (RT1308_POWER << 4), 0x00 },
>  };
