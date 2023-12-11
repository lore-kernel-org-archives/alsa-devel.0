Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1454C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:41:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0987FAE8;
	Mon, 11 Dec 2023 14:41:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0987FAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702302107;
	bh=nxM3m0fd/Qts426VUxaIvUcMjAL8BjhTWiFbn8gjtHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SHUcBEObXtfFZpT6SHJuBayDHWtlE8M9AzePxM9xQh1a0vNRjiOtoIozcfrkZvMx+
	 94bThYbYgayN+pt8nYsdyr1Y4XHIvqQj2MPLm6rT4MT6hK2UA7hnrHIWEIaz3nAimw
	 QLFJpDKKUrfK8hojNaFifqfcZrZUqdTN4ZKG3qDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F7EFF8057A; Mon, 11 Dec 2023 14:41:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3411F80580;
	Mon, 11 Dec 2023 14:41:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34BD1F80166; Mon, 11 Dec 2023 14:41:09 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB33BF800D2
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB33BF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=EWISpyq8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D709ECE127D;
	Mon, 11 Dec 2023 13:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03EC433C9;
	Mon, 11 Dec 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702302061;
	bh=nxM3m0fd/Qts426VUxaIvUcMjAL8BjhTWiFbn8gjtHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWISpyq8wNowbv0aYVcvdj3yFg7Rf4k6p1s8hhxK6NY7eiVikxtLg/N67DRry/c6+
	 xCDto1x/dyxRE0i4mxYN1Kyh9Y2z8AtYz4/CsyfjqJ2ltyisaobLefFGXmNNWm7j3/
	 U4r3banV4ANXrkdOJVgt7wqtT/0L9dgO0G01A4n0=
Date: Mon, 11 Dec 2023 14:40:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker
 digital volumes
Message-ID: <2023121154-mule-utter-98cf@gregkh>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
Message-ID-Hash: MNPIFOJWPVWIL3XPZHWGQ6F3VSNE5YNM
X-Message-ID-Hash: MNPIFOJWPVWIL3XPZHWGQ6F3VSNE5YNM
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MNPIFOJWPVWIL3XPZHWGQ6F3VSNE5YNM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Dec 11, 2023 at 02:26:06PM +0100, Johan Hovold wrote:
> This is a backport of the following series:
> 
> 	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/
> 
> which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
> interface.
> 
> Johan
> 
> 
> Srinivas Kandagatla (2):
>   ASoC: ops: add correct range check for limiting volume
>   ASoC: qcom: sc8280xp: Limit speaker digital volumes
> 
>  sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
>  sound/soc/soc-ops.c       |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> -- 
> 2.41.0
> 
> 

Now queued up, thanks.

greg k-h
