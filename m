Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13611C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:21:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF79610FA
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF79610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3D3316DE;
	Tue, 27 Apr 2021 12:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3D3316DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619518863;
	bh=Y1Sf0bjD5hEhEnLL4TFrISbrwe7DqxOPsCTILOOKIc8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZ3YUwMTFAH3H0GqqDvhwlRR0QrOGq3+iqAnInSGvW+UM231qYJYhMfAxeLyMpmki
	 AfIM8/FujR5GKoSqa0xuAfqS5XQZdN2G5P/YHRgavvlXYFrJ284n50PgmCG8a6nGpt
	 8TU8s+kPTD8kDcxLN+8buLzTZTOgEZ/aNhm1DqeA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64AF1F801D8;
	Tue, 27 Apr 2021 12:20:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F361F801EC; Tue, 27 Apr 2021 12:20:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 853D3F800C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 853D3F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i+W4G3Wt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB4D611ED;
 Tue, 27 Apr 2021 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619518797;
 bh=Y1Sf0bjD5hEhEnLL4TFrISbrwe7DqxOPsCTILOOKIc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+W4G3Wt3ezZF1DPhgVS8L0osuBSYKgvXTFNxPRwd2su++/HqqeCZYvXKLXmymz7w
 6gbrlpW6pvoICl+ktRH3yavDILTeFMBvtZvICRhr1zfTllPEWdy4D+UwHd/icWf4MS
 1TslGw713EaPmxXHQMqrGFN2N1N9icLKrR7KWUpVIgl9js4BW/es4DX1BqmRunx/eT
 gIDh9KBNRgu458IeAQi5YjZwImKmv45BiLAQcSwJ9BUzFjlXY1fEgqATlI8lTTtVzc
 nzuC59Df87iNHbtFwVhnBFsB6A+QOjoMnlSef04EJCsoUAIWTn3ymyYFpIMmpJVME1
 c4Tv9AYBuhRYQ==
Date: Tue, 27 Apr 2021 11:19:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
Message-ID: <20210427101926.GA4605@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
 Thierry Reding <treding@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>,
 kernelci-results@groups.io, Guillaume Tucker <guillaume.tucker@collabora.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:

> > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
> > > all saiX doesn't have .name. I think it should have different name.
> > > In your case, at least, sai5 / sai6 needs to have

> > You could send a patch along with re-adding the three patches I dropped?

> Thanks, I can do it.
> But I want to confirm above first.
> Let's keep Guillaume's happiness :)

This board is in the Kontron lab - KernelCI is just reporting results
=66rom it, we'd need to connect with someone from Kontron for system
specific questions.  Guillaume, I don't know what e-mail they wanted to
be used here?

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH5S0ACgkQJNaLcl1U
h9CVnAf+OzAymrPGqi74AroobdIikqiR4xtw2bKKWThMR3fGvwPaQtbr6qtmLwoY
n96fzVSW/xSOiZ4oMSvbT+eO3ZO89M1ecPNxROmwkErYOqH8yZZ/Rja26bBNX5zm
UN/nsMq8b3qcFhrMKfxQf0yDxWLOwxDNGOt21SlbRcztz3xJYDFU/iom5j946UbO
7Zeg+aqzP3KyHwUjyBdyuA8TfJ2k0Dpv4uL5K+Nk4/0/wKtUJf/hdmtFOyNej2GZ
EpX64Wy+uu83WSQ9tgjsVmxQun4TJw4KgVPKxk0m6uPnxe1NODim67sxCo1F2z12
PQAcIhsegTpqWM4b3lVMQKekQ5Ux5Q==
=tr2h
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
