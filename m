Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2543C6FA8B
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Sep 2022 14:26:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAA021AA9;
	Fri, 16 Sep 2022 16:25:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAA021AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663338385;
	bh=S1JSC8Br/8ucG2eLuk9wLNXKmUdcrmGUqFmJDrAJYfc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tN3v+LVcpwLekgmgbZks9eU/0Db3Ad0rRsnvMqo3PnjNItDn0qLimtFZ1gIBnBW7U
	 KzJVpw0CLHP8dJs3lrL9lULhifYAhXmW4ebzA/iTstffcMMnY43POK+WvrJK6jt/Hy
	 jwVvjRvHHEo1mvdTBuCqIZFoj2PCYqzoChRhlGvw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53A58F8055A;
	Fri, 16 Sep 2022 16:24:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E952CF8055C; Fri, 16 Sep 2022 16:24:42 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 786E8F8055A
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2022 16:24:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 786E8F8055A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="UTEEjXvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663338277; x=1694874277;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=S1JSC8Br/8ucG2eLuk9wLNXKmUdcrmGUqFmJDrAJYfc=;
 b=UTEEjXvcQybaqclmhH/NF+skyDzX/r271rN4UDv8jQMbFK7qwHmNHqOg
 ZdjfbPA+J1Tcyk0j7pyeJHBRaSSlrWzvQguLz0RJmUhikiW9hr0ouawmn
 t2X7WVElErwgVIa0WDNtxqthiBtyKmB494MO+AdqiGyhuL6kyJ0bVHfTE
 30wTSrfSuN3Rqnz2ay5LWnPsh2kOsPtfPko49YPxBf5O9+FPjsL1T2A+h
 gCaxG2fNfg31sMJwKVtH/S+kmz8dX/a0G0wr/m2COXqLIBPPMVhmooHqo
 q3Jn5doJpBsYWcMYP2xgVibUqbUP+Qye4CWHCOjl+iyXZzzui+qLVmn2+ Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299824352"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="299824352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 07:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="650889101"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56])
 ([10.252.61.56])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 07:24:24 -0700
Message-ID: <5209eae6-8cf4-df16-4b9d-afc91a31db30@linux.intel.com>
Date: Fri, 16 Sep 2022 10:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_rt5682: use devm_kcalloc()
 instead of devm_kzalloc()
Content-Language: en-US
To: cgel.zte@gmail.com, broonie@kernel.org
References: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
 tiwai@suse.com, cezary.rojewski@intel.com, linux-kernel@vger.kernel.org,
 liam.r.girdwood@linux.intel.com, mac.chiang@intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 ajye.huang@gmail.com, peter.ujfalusi@linux.intel.com, brent.lu@intel.com,
 vamshi.krishna.gopal@intel.com, yong.zhi@intel.com
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



On 9/16/22 08:26, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  sound/soc/intel/boards/sof_rt5682.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 045965312245..1bf9455eaf93 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -600,10 +600,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int i, id = 0;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
> +			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
> +			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		goto devm_err;
>  
> @@ -687,9 +687,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  
>  	/* HDMI */
>  	if (hdmi_num > 0) {
> -		idisp_components = devm_kzalloc(dev,
> -				   sizeof(struct snd_soc_dai_link_component) *
> -				   hdmi_num, GFP_KERNEL);
> +		idisp_components = devm_kcalloc(dev,
> +				   hdmi_num,
> +				   sizeof(struct snd_soc_dai_link_component),
> +				   GFP_KERNEL);
>  		if (!idisp_components)
>  			goto devm_err;
>  	}
