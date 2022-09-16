Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FDBECAAD8
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Sep 2022 14:24:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D42C91AA7;
	Fri, 16 Sep 2022 16:24:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D42C91AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663338290;
	bh=9tPEr/H6IzDstmNvVzD+zOCEBT6Sewon5wngnegWEOA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rg62m9ceAVO5eAehZSt1e6BLGdmzdbLEzdP99d1ZuTvWbMtaH44Cy3LRHBAZ9ZS2e
	 r4HTidQdcLElMjdPEFXMGWIgnWD9RyLnMrlI2WZDhgN7GcR0JgEubpYoAmSwOL8Dx3
	 llrHUm8NR7cj5xITAcSg9yO9k2/I2FeUif5qGi0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E515F802BE;
	Fri, 16 Sep 2022 16:24:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F0D1F802BE; Fri, 16 Sep 2022 16:23:58 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F041BF800E5
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2022 16:23:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F041BF800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="NEY7MhY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663338233; x=1694874233;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9tPEr/H6IzDstmNvVzD+zOCEBT6Sewon5wngnegWEOA=;
 b=NEY7MhY9PGNaVYr3izluQ4z8c/dzkI6CLtBKoM4eNCkOyGwB6fTcvNKw
 e2GsBHbU0NsJmwv7y+PtoO8pn1w6yVvX/vgd2HP9r06i3Z1MLAhnddWhY
 qF8++E7kERkbJBoIYCacHcDtfxrVrUJqAH1YW1JNu7LAGOhkf11qtkBd9
 5BWQb5YzEctxRm3U095AmMOXlvQhLJ+jOelrLlV9fWaf1yZ7/Dg4i4Alw
 awlNyIFBJ7UQsZ0hLkJx+3hvLT6leKlvemQRHZ331/WFiGsqCIxqmzgpO
 IVd2b2YxkrNz07Ks79bqpJVrQUg2WY5xWU16pVzpuETqACSrUJ1U+p+RM Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279382856"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="279382856"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 07:23:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; d="scan'208";a="650888874"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56])
 ([10.252.61.56])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2022 07:23:42 -0700
Message-ID: <95073ce7-6f4e-0adf-0c23-44351af0061b@linux.intel.com>
Date: Fri, 16 Sep 2022 10:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] ASoC: Intel: sof_cs42l42: use function
 devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To: cgel.zte@gmail.com, broonie@kernel.org
References: <20220916062234.153275-1-ye.xingchen@zte.com.cn>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916062234.153275-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
 cezary.rojewski@intel.com, tiwai@suse.com, liam.r.girdwood@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 akihiko.odaki@gmail.com, peter.ujfalusi@linux.intel.com, brent.lu@intel.com,
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



On 9/16/22 08:22, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_cs42l42.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
> index 85ffd065895d..e38bd2831e6a 100644
> --- a/sound/soc/intel/boards/sof_cs42l42.c
> +++ b/sound/soc/intel/boards/sof_cs42l42.c
> @@ -445,9 +445,9 @@ static int create_hdmi_dai_links(struct device *dev,
>  	if (hdmi_num <= 0)
>  		return 0;
>  
> -	idisp_components = devm_kzalloc(dev,
> -					sizeof(struct snd_soc_dai_link_component) *
> -					hdmi_num, GFP_KERNEL);
> +	idisp_components = devm_kcalloc(dev,
> +					hdmi_num,
> +					sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!idisp_components)
>  		goto devm_err;
>  
> @@ -543,10 +543,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>  	struct snd_soc_dai_link *links;
>  	int ret, id = 0, link_seq;
>  
> -	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
> -			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
> -	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
> -			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
> +	links = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
> +			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
> +	cpus = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
> +			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
>  	if (!links || !cpus)
>  		goto devm_err;
>  
