Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AABC433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:06:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3A061378
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3A061378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96F8216C5;
	Thu,  1 Apr 2021 18:05:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96F8216C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617293176;
	bh=DSutbyQVSHPRdbg9SPdAQAnK0pzwZ5jNV2+rmi4K0OE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TroJZ/53Ak1Q0G1tpVP6DSi4Au0Xc8sOr5HZZiTSSYjbPDN8Fc9qCJe83CHzdYbeS
	 Njbki2tw3B6McKdCzgcRjHBtXkWX8X8T0HwYeFDpNrZp4cNnLviMlGoMBG9CcuEUtF
	 F7dNNGfl+M8o9G5wg2qE4WU5Zbk78fP/9Jflk1nw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2730AF8013C;
	Thu,  1 Apr 2021 18:04:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 332F3F80424; Thu,  1 Apr 2021 18:04:01 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E0FDF8013C
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 18:03:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E0FDF8013C
IronPort-SDR: z03Ly3kUlkMEZiMbLtWUVhcxZ75YAeJqYIFW+z6LwGOEknZWHtI5thBx/9lGLVLkKJfVm6yItM
 hSNczTHm+uuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171692995"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="171692995"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 09:03:24 -0700
IronPort-SDR: GbwNOpvEZemzt630fFese/DM+HYvVYBD4Zqs3gESV2CMFD43Q04yPNQtheaAngsSs+vhpFdJKp
 5lwg04j+pzAQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="439265778"
Received: from mooreale-mobl.amr.corp.intel.com (HELO [10.255.229.43])
 ([10.255.229.43])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 09:03:24 -0700
Subject: Re: [PATCH] ASoC: Intel: Boards: cml_da7219_max98390: add capture
 stream for echo reference
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
References: <1617285613-29457-1-git-send-email-mac.chiang@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab85d8b5-036e-ad66-0d03-399a657585c6@linux.intel.com>
Date: Thu, 1 Apr 2021 09:43:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1617285613-29457-1-git-send-email-mac.chiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, yang.jie@linux.intel.com
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



On 4/1/21 9:00 AM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
> 
> enable speaker capture dai link for feedback path
> 
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>

LGTM

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index 0c0a7178..9ffef39 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -813,6 +813,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   				if (ctx->spkamp == SPKAMP_MAX98390) {
>   					broxton_dais[i].codecs = max98390_codec;
>   					broxton_dais[i].num_codecs = ARRAY_SIZE(max98390_codec);
> +					broxton_dais[i].dpcm_capture = 1;
>   				}
>   			}
>   			/* DIALOG_CODEC is connected to SSP0 */
> 
