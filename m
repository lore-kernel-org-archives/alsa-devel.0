Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D15C47422
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jan 2024 06:00:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42A16823;
	Wed, 17 Jan 2024 07:00:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42A16823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705471217;
	bh=l4hHsXxDuaY6bucx8rE9I6NYDTycMAAU5l/I4jSYm5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hkv77S1Lg9spq9pnXv5o9ZdpIzUv+FrQxpX9T/dSna5W53wUS5T0fulUe8MGro2yO
	 1Utj3AwIXlpnVnrtFniqGhLOa2xfixpdfP6DcccwOS82uMFx2AHFzMHqMqDEtaO/Wi
	 XXyu5vsj+iyVxi+83PjEJiimu3uC8DBGD1uMnH4o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD043F8057E; Wed, 17 Jan 2024 06:59:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFE37F800C1;
	Wed, 17 Jan 2024 06:59:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 152E7F801F5; Wed, 17 Jan 2024 06:55:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07BA4F800F5
	for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2024 06:55:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07BA4F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=Xgw52jl9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 399BF614C7;
	Wed, 17 Jan 2024 05:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A176C433F1;
	Wed, 17 Jan 2024 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705470912;
	bh=l4hHsXxDuaY6bucx8rE9I6NYDTycMAAU5l/I4jSYm5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xgw52jl9IR63pY+hurKYprPgLfRPDK7OMY1k0VJaaoQvPON5qbMsygF513R2hySii
	 N4VbqvHr4X8IE6Ndg9+1T/6VHs6jSye/CpTXS8J7RV9MAsJwxR60h0044rxGuwwalJ
	 mykIaCI70FOwqrGZVtPrfKn5yh/AJrNJwI+AIZJQ=
Date: Wed, 17 Jan 2024 06:55:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <2024011716-undocked-external-9eae@gregkh>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
Message-ID-Hash: EBSRWOLZKWT4M2555AFXAVPYQ7SJZWNL
X-Message-ID-Hash: EBSRWOLZKWT4M2555AFXAVPYQ7SJZWNL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EBSRWOLZKWT4M2555AFXAVPYQ7SJZWNL/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jan 16, 2024 at 07:02:19PM +0000, Mark Brown wrote:
> On Tue, Jan 16, 2024 at 10:25:28AM -0800, KernelCI bot wrote:
> 
> The KernelCI bisection bot has identified bc7d0133181e5f33aca ("ASoC:

Nit, typo in your sha1 here :(

> atmel: Remove system clock tree configuration for at91sam9g20ek") from
> the v5.15 stable tree as causing something to fail to probe on
> at91sam9g20ek, most likely the audio driver though I didn't pull the
> logs to verify.  The commit isn't a particularly obvious one for
> backporting.
> 
> Full bisection report below.

This is also in the following kernel releases:
	4.19.240 5.4.191 5.10.113
do they also have issues?  Does 6.1 and newer work properly?

And wow, this is old, nice to see it reported, but for a commit that
landed in April, 2022?  Does that mean that no one uses this hardware?

I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
and 5.10.y?

thanks,

greg k-h
