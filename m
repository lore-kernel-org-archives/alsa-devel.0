Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0CFE784BC
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Oct 2023 15:17:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19962A4A;
	Mon,  2 Oct 2023 17:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19962A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696259868;
	bh=Fb0ymaVOpCVGd7cx59N9jbdB3iYdc12n4vQA6NoFyqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iBlfyzuLFSV9EaNELTjJwCNDjc2RkVM0PfORnQxzi2k3vTHpMcF+Iq7NiZZL995AA
	 DbNEjLCuWZLJP/tm65wllSdIUnVKZDG1Epzu9UfoCOP5jJcb3HQCIk1/sG3XZb/QZG
	 a11EyZiXUyDQAukjEwikM1OGasyQH8BEh0S4ip4c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0987F80549; Mon,  2 Oct 2023 17:16:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45538F80310;
	Mon,  2 Oct 2023 17:16:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B8E2F80310; Mon,  2 Oct 2023 17:16:33 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB488F801EB
	for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2023 17:16:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB488F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aPFImDyh
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D0923B81184;
	Mon,  2 Oct 2023 15:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FBEC433C8;
	Mon,  2 Oct 2023 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696259788;
	bh=Fb0ymaVOpCVGd7cx59N9jbdB3iYdc12n4vQA6NoFyqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPFImDyhexsU1wHFumQd4HI2AtZnCoyHnaWvoK9Lp/BJk7TiwY6RuY1djs1iZp5C1
	 DDQbWOfBGxG3JyIwNbn2hqu94FZZDGaoCbCGLB2Ddi9AADQ8mN1JmDBS2TwS+aIplR
	 dOqwhLTpssI3x3dlD4312/eJEfNlqd+92JZhLeMVjRfGSL7m4KwUOhWbfqjsSoh4ps
	 2W6wUwCjoyk5oxEknACrIopYS1WGygWNqWCFXtHarC+hxceEn3fjxGxUcgpcEhr6Wv
	 SHKJWjiPIC/EB2EhvAQR5HKFSGF85QMIjI7BBLZI/mPF5xYXJkVR8yXjFylrPc0BnA
	 A7Q3z61p6aseQ==
Received: (nullmailer pid 1744043 invoked by uid 1000);
	Mon, 02 Oct 2023 15:16:26 -0000
Date: Mon, 2 Oct 2023 10:16:26 -0500
From: Rob Herring <robh@kernel.org>
To: Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, a-krasser@ti.com, joerg@hifiberry.com,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
Message-ID: <169625977391.1743730.497698992999115873.robh@kernel.org>
References: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
Message-ID-Hash: ZSLGFFYFF4BRFNRYPFYSR5WMEUMPL4SI
X-Message-ID-Hash: ZSLGFFYFF4BRFNRYPFYSR5WMEUMPL4SI
X-MailFrom: SRS0=McIo=FQ=robh_at_kernel.org=rob@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSLGFFYFF4BRFNRYPFYSR5WMEUMPL4SI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 29 Sep 2023 17:05:55 +0200, Joerg Schambacher wrote:
> The TAS5754/6 power amplifiers use the same pcm512x driver with
> only minor restictions described in the bindings document.
> 
> Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/pcm512x.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring <robh@kernel.org>



