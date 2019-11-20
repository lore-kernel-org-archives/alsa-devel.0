Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D3CC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C24320674
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oPOCokFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F3B016E8;
	Wed, 20 Nov 2019 17:12:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F3B016E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574266393;
	bh=VCjk1M537XUxebnqISGHAPc5NnQiBqGo2LBYqkWOTcg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPOCokFlFV9QISiNhXpkrQdLce5cHmur6IjQaex0IfDbpAR2p/3CAB+6galGdcrMp
	 HhNqvV/L6LnqKPGEUEVy0KipHP8oYLWPy48DpGeKIWkfLG9aY/nEBxjG6kY3JKammj
	 r8iuRagws/eNDMGcHH95BuEFKlYjFmxefYFEO8pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02BBBF8014A;
	Wed, 20 Nov 2019 17:10:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB90DF8014D; Wed, 20 Nov 2019 17:10:43 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA1DFF8013D
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 17:10:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA1DFF8013D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 08:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; d="scan'208";a="204862316"
Received: from ngoel1-mobl1.amr.corp.intel.com (HELO [10.255.66.61])
 ([10.255.66.61])
 by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 08:10:34 -0800
To: Tzung-Bi Shih <tzungbi@google.com>, broonie@kernel.org
References: <20191120060256.212818-1-tzungbi@google.com>
 <20191120060256.212818-2-tzungbi@google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a0ad3c80-c5e7-f875-7c97-e0e0dc36bfc0@linux.intel.com>
Date: Wed, 20 Nov 2019 08:33:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191120060256.212818-2-tzungbi@google.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: max98090: remove msleep in PLL
 unlocked workaround
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 11/20/19 12:02 AM, Tzung-Bi Shih wrote:
> It was observed Baytrail-based chromebooks could cause continuous PLL
> unlocked when using playback stream and capture stream simultaneously.
> Specifically, starting a capture stream after started a playback stream.
> As a result, the audio data could corrupt or turn completely silent.
> 
> As the datasheet suggested, the maximum PLL lock time should be 7 msec.
> The workaround resets the codec softly by toggling SHDN off and on if
> PLL failed to lock for 10 msec.  Notably, there is no suggested hold
> time for SHDN off.
> 
> On Baytrail-based chromebooks, it would easily happen continuous PLL
> unlocked if there is a 10 msec delay between SHDN off and on.  Removes
> the msleep().
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>   sound/soc/codecs/max98090.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index f6bf4cfbea23..8382a77586ee 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2117,7 +2117,6 @@ static void max98090_pll_work(struct work_struct *work)
>   	/* Toggle shutdown OFF then ON */
>   	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
>   			    M98090_SHDNN_MASK, 0);
> -	msleep(10);

maybe add a comment here that the off/on sequence is done on purpose (as 
stated in the commit message)?

>   	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
>   			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
>   
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
