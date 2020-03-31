Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF375C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:57:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DD0206EB
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RmWgFHnt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Vj3G0fFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DD0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC2D286F;
	Tue, 31 Mar 2020 07:56:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC2D286F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585634222;
	bh=bKY2DffSOrQkYRySAqNzwmLgQ+bx2jS9RCJ+jMioI/k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RmWgFHntB1n2BXZ6FkBwPHSKqLd6rzaCoPVaXPm0jpb8hcvGWCMSx49ko5odXcRkY
	 wYSx3mi5LxuH6Vmp+/6qlOH2eyDBLXCEwjmqnCq3+LsDzmah+VpDioXTavgwAK+sfu
	 iUxo9ixilJNmSKB9fSkzrTMWe317VWSqFcdcxg10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E73DF80140;
	Tue, 31 Mar 2020 07:56:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48418F80146; Tue, 31 Mar 2020 07:56:10 +0200 (CEST)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3E2BF8010D
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 07:56:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3E2BF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="Vj3G0fFv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U6mJJA8B3BLS8SxPj8hxfBj3bGGU0ojqcuvIrJcgGAk=; b=Vj3G0fFvU3GOXIcV8mfGOh12ox
 L0LVFS5zK0vosM/gjgN5edsyZ/0Ins2vVQeumwzZ8NlRJYE2S+3Yq9F+vT9O0hiEYuhUB3rmcJzxP
 k0wni3ud6dmghsGPtaNPDAKLItxFpBPY3DajzNv4HmDp17gKU2vprikk5ighOTC4upXNvJVR5rvpL
 dz19hH44291GWY678q3cALF9LLMUke3gqWxB9026s6/xmMeByyi8qUhNn6Amt/tnCg4Tj5oGrxiaI
 vbkSflPZDjE6A6nUCc8BzM+/HO38z1KzlWrNWKt5eT8HBSKXcJzHWC2btQlqToOpFYTOPB3uVaEJW
 lD1TFyGg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <lars@metafoo.de>)
 id 1jJ9sT-0003Ar-K4; Tue, 31 Mar 2020 07:55:57 +0200
Received: from [82.135.70.63] (helo=[192.168.178.20])
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1jJ9sT-000XH7-Ak; Tue, 31 Mar 2020 07:55:57 +0200
Subject: Re: [PATCH 1/3] ASoC: dapm: connect virtual mux with default value
To: =?UTF-8?B?7J206rK97YOd?= <gt82.lee@samsung.com>, broonie@kernel.org
References: <CGME20200330073548epcas2p3045be9d3c8b76115c76ce27679840b6f@epcas2p3.samsung.com>
 <000e01d60665$d48444b0$7d8cce10$@samsung.com>
 <010901d6071f$1f299dd0$5d7cd970$@samsung.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b76d4955-94d3-5a75-d01f-5cb9ab47d6a7@metafoo.de>
Date: Tue, 31 Mar 2020 07:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <010901d6071f$1f299dd0$5d7cd970$@samsung.com>
Content-Type: text/plain; charset=euc-kr; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 hmseo@samsung.com, tkjung@samsung.com, pilsun.jang@samsung.com
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

On 3/31/20 7:42 AM, ÀÌ°æÅÃ wrote:
> Since a virtual mixer has no backing registers to decide which path to
> connect, it will try to match with initial value 0.
> This is to ensure that the default mixer choice will be correctly powered
> up during initialization.
>
> Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
> ---
>   sound/soc/soc-dapm.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c index
> 9fb54e6fe254..fc55a0534252 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -802,7 +802,16 @@ static void dapm_set_mixer_path_status(struct
> snd_soc_dapm_path *p, int i,
>   			val = max - val;
>   		p->connect = !!val;
>   	} else {
> -		p->connect = 0;
> +		/* since a virtual mixer has no backing registers to
> +		 * decide which path to connect, it will try to match
> +		 * with initial value 0.  This is to ensure
> +		 * that the default mixer choice will be
> +		 * correctly powered up during initialization.
> +		 */
> +		val = 0;
> +		if (invert)
> +			val = max - val;
> +		p->connect = !!val;
Do you have virtual mixers that have the inverted flag set and if yes 
why? Cause otherwise this is exactly the same as before.
