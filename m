Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC717C46467
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Jan 2023 16:08:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAAF22C77;
	Tue,  3 Jan 2023 17:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAAF22C77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672762099;
	bh=J5CMzr29omiM84inuu5NkFtk950zuT/xGASY9w81KSs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oEVLNhI9L+l0kXxG2uyWx0aLRmR3HsmDVdW1wbQ9C8MDHmWGqU+7ZV2XuwgWdjUtf
	 VyPZ5M/o9ab3eqSQNh04IBB4XZR4xhjAMCQIPlWDJd/NIiHb7HSxIfGgAeHNYmm8kU
	 uyQ33BbazX1z3XZkdhfKUH85AFpG7W86LLZsseiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 908C3F8047B;
	Tue,  3 Jan 2023 17:07:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE54DF803DC; Tue,  3 Jan 2023 17:07:26 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6794EF8047B
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2023 17:07:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6794EF8047B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Vb4MT35k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672762045; x=1704298045;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=J5CMzr29omiM84inuu5NkFtk950zuT/xGASY9w81KSs=;
 b=Vb4MT35kgUVrV/VlTE7kYsspjW+z5vFSYDi0YzH8+MkgGV8z/VaEIVh+
 WEIF7nAhpHVK3Mk7zpWwv3uUGRe3BC8El2UO4ipC7QFy8rjUwroOtrdoB
 TIX/oweoPht0+R3Kp1OpJK4C4D9VYcUrFz/UqPKSGWRjxHpFrHIwZ4G5V
 MiVDknYQSQybPmgMNuAfFGezx6t0aTb7o6A/5QXtJniqgtJAxXRE3i5Rb
 D242CVoZq63MSQvgwkp9t4wu/fqpSBwdYybonYb96912yrxVDFxsU020N
 7euCwi+wLD9YXfnoKuVX6hy7z/g/tUg0p7vlnZFEORFg00cO2kEXNpz6d g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305196323"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; d="scan'208";a="305196323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2023 08:07:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743546025"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; d="scan'208";a="743546025"
Received: from nkpuppal-mobl2.amr.corp.intel.com (HELO [10.209.178.199])
 ([10.209.178.199])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2023 08:07:20 -0800
Message-ID: <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
Date: Tue, 3 Jan 2023 09:08:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/2/23 14:30, Andy Shevchenko wrote:
> Instead of calling put_device(&adev->dev) where adev is a pointer
> to an ACPI device, use specific call, i.e. acpi_dev_put().
> 
> Also move it out of the conditional to make it more visible in case
> some other code will be added which may use that pointer. We need
> to keep a reference as long as we use the pointer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Answering for the series: we should make the change across all Intel
machine drivers. I see at least four cases that were missed

bytcr_rt5640.c:         put_device(&adev->dev);
bytcr_rt5651.c:         put_device(&adev->dev);
bytcr_wm5102.c: put_device(&adev->dev);
sof_es8336.c:           put_device(&adev->dev);


> ---
>  sound/soc/intel/boards/bytcht_cx2072x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
> index 41cec67157b6..9942a2de6f7a 100644
> --- a/sound/soc/intel/boards/bytcht_cx2072x.c
> +++ b/sound/soc/intel/boards/bytcht_cx2072x.c
> @@ -253,9 +253,9 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
>  	if (adev) {
>  		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
>  			 acpi_dev_name(adev));
> -		put_device(&adev->dev);
>  		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
>  	}
> +	acpi_dev_put(adev);
>  
>  	/* override platform name, if required */
>  	ret = snd_soc_fixup_dai_links_platform_name(&byt_cht_cx2072x_card,
