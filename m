Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77128C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 16:48:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2C0233ED
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2C0233ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8913917F2;
	Wed, 20 Jan 2021 17:47:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8913917F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611161308;
	bh=bwvaCWsQmO8/Vs+oEL5eWnWG0GK3Jp5SWEVof2D5jcE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FrKAIIhoMTap+TIVGiWxD8MJNuLTfc7FYfoeiH8DUGikJpXpJIfFPtD0nOU2fZlCz
	 WZS/Kjcb3VyqfoUDGF65ATNlcDLshSksNq/KyEl4e+IVkEUAkkhSo89ZBKMF4YnQ97
	 HsGquOa2B5Pifgvvi+ajb1UxDm7FDAr1lFIiy//Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 261B3F80166;
	Wed, 20 Jan 2021 17:47:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 138ECF80166; Wed, 20 Jan 2021 17:47:35 +0100 (CET)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6845F8012C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 17:47:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6845F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="YUldAD+F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=v15GZJs344S4B1Ug8bOvbsCvV3se60ZDN+6/fmvp0gw=; b=YUldAD+FmxQHTMks8lq2Stjlky
 OkX9rlT8RWQXzg8abFLyflf88pMLWJ2FOCIhxKJWSC9B36ZOGOJg+ybcam2/u8dZDEx7FhodjdiGc
 NTqWrr1FZcsHONV3KyCKjTYDFLjlytVoC5QqtFSvHkWWFYFeddC4amsqTQHFCVW7q9t4cdLYeN6UH
 n7teDgz13pcguEql7x2Vr2JBcZS9qCD8WsAhr6LqN+VRw2t19TlYJLjPHyOTL4G2wDoJKfQzjWBPM
 GpPDvw22DhugF8eCOFm+ASmdr/KZA7BTrbrkJ6dw6h+CObmo4OM4ZI1zhJekOcKxjtXZn4+VB0Xfi
 fiLtP2Cw==;
Received: from [2601:1c0:6280:3f0::9abc]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2Gdi-0005Hq-HG; Wed, 20 Jan 2021 16:47:26 +0000
Subject: Re: [PATCH] drivers: slimbus: Fix word resposible -> responsible in
 slimbus.h
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
References: <20210120144006.3587856-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a5b2d3d-0622-78db-a685-dd522ba47dca@infradead.org>
Date: Wed, 20 Jan 2021 08:47:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210120144006.3587856-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 1/20/21 6:40 AM, Bhaskar Chowdhury wrote:
> s/resposible/responsible/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/slimbus/slimbus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
> index 00a7f112574b..503e2a0200f5 100644
> --- a/drivers/slimbus/slimbus.h
> +++ b/drivers/slimbus/slimbus.h
> @@ -368,7 +368,7 @@ struct slim_stream_runtime {
>   * @get_laddr: It is possible that controller needs to set fixed logical
>   *	address table and get_laddr can be used in that case so that controller
>   *	can do this assignment. Use case is when the master is on the remote
> - *	processor side, who is resposible for allocating laddr.
> + *	processor side, who is responsible for allocating laddr.
>   * @wakeup: This function pointer implements controller-specific procedure
>   *	to wake it up from clock-pause. Framework will call this to bring
>   *	the controller out of clock pause.
> --
> 2.30.0
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
