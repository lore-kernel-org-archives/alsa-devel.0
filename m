Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2244C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:53:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C960208C3
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="noLBRx8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C960208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB7561693;
	Mon,  9 Mar 2020 18:52:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB7561693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583776385;
	bh=rhCco664qrQmoqD2GFkLT+u27MXwyZpSuWrcWe1m4dc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=noLBRx8OyOmavEpJDIRSQUj1Ddx4I9Il+meAW/ie06ZN1e7WdGuUv84L4aXZSmqK3
	 2K0W95C95g/u7JpwXnhdGzRnsrCsLfwKGZv1HJ7v4GeXnVR/9ibcpBffUmkETAnK3t
	 l4gBHvtXbQw+sdxGQqNpNQmhegBRsHpfe3Fh4iLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38626F801A3;
	Mon,  9 Mar 2020 18:52:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32EB8F801EB; Mon,  9 Mar 2020 18:52:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 28A13F800DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 18:52:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28A13F800DA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28C37FA;
 Mon,  9 Mar 2020 10:52:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E243F7C3;
 Mon,  9 Mar 2020 10:52:06 -0700 (PDT)
Date: Mon, 9 Mar 2020 17:52:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Li <kevin-ke.li@broadcom.com>
Subject: Re: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
Message-ID: <20200309175205.GJ4101@sirena.org.uk>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fKov5AqTsvseSZ0Z"
Content-Disposition: inline
In-Reply-To: <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>,
 bcm-kernel-feedback-list@broadcom.com, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-kernel@lists.infradead.org
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


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 10:33:30AM -0700, Kevin Li wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The SoC I2S block we currently have shares one clock and frame sync signal
> for both playback and capture stream, plus playback and capture can only
> have one master at a time. If we set playback and capture master at same
> time, it will have jitter on clock and FS.

I can't really parse what you're talking about here (perhaps some of
that context would have helped...) but it doesn't seem to be the
clocking of the I2S bus which would normally be what master and slave
would be talking about.  If it's something else perhaps the code needs
to be clarified to make it clear that it's not talking about the bus.

--fKov5AqTsvseSZ0Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mgkQACgkQJNaLcl1U
h9A5Fgf/Urnfg3j5PZES06ywstEE7IyxgzPd7YpkYqxz2XToPpUnbB1SBhF0Lfxk
xo/iCZDUkh8H259e98Hq1BEN/mB8UROBB4E23KAY/cYsoFYjU3ZQQtGL3InblMsO
6fFx4mnUIX47TvK9S5oIsXpsS/+mrTx5GPmY9Xg/gBy32d15wnNFYtGP9mCGEgOi
hRj/VQ2vuAbiHk0D3Qjd6GvUZMnvF88BMndqq8wtUMjnwPK5pfk3SD62n1dQkuov
5MClefdJR/qwrpfLHjEzOzfSqrRceYcim8ccxQHmU/5qHgBm2xMTQFQeBjTLWIFs
7Qdtn3SNwtwyrW55Xp9IrO2+zHwjJw==
=VLrd
-----END PGP SIGNATURE-----

--fKov5AqTsvseSZ0Z--
