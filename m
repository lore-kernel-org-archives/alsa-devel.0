Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D747C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 17:09:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5EC61F4;
	Mon, 25 Jul 2022 19:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5EC61F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658768980;
	bh=gaRQ8OrgasXoKsBE8DAQZEaK2QlXpbZjuu5pCy7Jz7A=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q4X1NfZNqZUVKn7efg2gHVEDgg3IFrZWmUpdLyj9vBLmDFkQdkAaQ71rtFg1gSDR4
	 rGsvgDN5NmeGxZVeRwWawr9jeVKvlFK/abpRemmbxRpbz+ESYOkbCBtstcogyx3L5Z
	 hwT7IxBiJ9nPwNuBJZWurUznqxxOOfhdR6P0Bp/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57439F80155;
	Mon, 25 Jul 2022 19:08:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EF38F80212; Mon, 25 Jul 2022 19:08:47 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27EF5F80128
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 19:08:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27EF5F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OE+f5aLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658768921; x=1690304921;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=gaRQ8OrgasXoKsBE8DAQZEaK2QlXpbZjuu5pCy7Jz7A=;
 b=OE+f5aLmpUOJjLnjEabgZ+Wg8H5wEkcW20gV595CUKjHN+53/ODk+2H8
 QsiB743kOsBjwd2TpZXDKIb5RRCGj7CtosgykvR3EYAkEMXmLpWz5c1Vq
 lCyD32CkP+vd6IoFSNgV39gFwigk27mGvbAhzZHWEXEmj/oFrLPSuFRn/
 KleOUVu8g5hs5kHJ7HbrrzR+YKc/HPcGtZYNBXp7+q5r/8CCNRxY/W4xO
 gTvEqvKr3syevXqddi+AdqWsQkdC7KjIVnUbq4CE5g40O7xAoUcyER/mO
 2WNHI9tjH0vPJHFMbGuHJ06L41tnvZr9tpTtuE2CHpTrQdwnXG3Bd7sbl Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349449587"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="349449587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 10:08:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="550062688"
Received: from jxzhao-mobl.amr.corp.intel.com (HELO [10.212.0.178])
 ([10.212.0.178])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 10:08:30 -0700
Message-ID: <bdaec1b0-1385-b376-7640-61d363c9b009@linux.intel.com>
Date: Mon, 25 Jul 2022 10:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: max98373: Removing 0x203E from the volatile reg
Content-Language: en-US
To: Ryan Lee <ryan.lee.analog@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, steve@sk2.org,
 ryans.lee@analog.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20220723015220.4169-1-ryans.lee@analog.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220723015220.4169-1-ryans.lee@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/22/22 20:52, Ryan Lee wrote:
> The 0x203E speaker gain register should be non-volatile.
> This register value was not able to be synced because it was marked as
> volatile.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
>  sound/soc/codecs/max98373-i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
> index 4fe065ece17c..3e04c7f0cce4 100644
> --- a/sound/soc/codecs/max98373-i2c.c
> +++ b/sound/soc/codecs/max98373-i2c.c
> @@ -442,7 +442,6 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
> -	case MAX98373_R203E_AMP_PATH_GAIN:

That register isn't declared as volatile for the SoundWire case so that
sounds like a good fix

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>  	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
>  	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
>  	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
