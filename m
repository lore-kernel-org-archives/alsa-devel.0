Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68074C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 15:41:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B8964EAE
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 15:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8964EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 680E31786;
	Mon, 15 Mar 2021 16:40:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 680E31786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615822898;
	bh=MS5Knu7+w8zdHfWpQWdZkvJd0j/NrYsIJsEVkwhZVDQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FWpclEmx/KT8NGBkK5rdCarT41xoVW83nFtwtgFAnh/bzqPBNMPSQN2xaKcr39e2D
	 KTrVi6lSf1jbL/re01Yuz5q+oT+twC1oBFfL7HOX5PvQZzG2n/fpgb0yuLWoRsYcyE
	 QS1H0QqIj3sbSq12aQqw3aGnhCfovgrgkuAFkv3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E47C3F801F7;
	Mon, 15 Mar 2021 16:40:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B22CF8021C; Mon, 15 Mar 2021 16:40:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5943F80100
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 16:40:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5943F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e64CxbdG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C873D64E83;
 Mon, 15 Mar 2021 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615822840;
 bh=MS5Knu7+w8zdHfWpQWdZkvJd0j/NrYsIJsEVkwhZVDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e64CxbdGXxbBfrxyhDLcr7WRIhiuR0a+/AVwYupgntpowlAHQLiRpuTzJvJ5dImec
 FyCjaw9bWiJ1XmtwLNXIw5yM8LX2t/xrGBVxJaoTZiBd0vy9k6sxpoQMoWbEwDFlEp
 YfpIK5M7p+80lajKUg7sIvMt8pLuctDMypsMMkDyxJVwlrm7ZQ+z9Z62+FSdvMgu1R
 5OJ3C0WeMrUJq/xrsEEuP6OCFSzWbu06Bn1aFETfDmMJ3JWGmfDekIJzrU5Vbpz/Ga
 sTZa7s81g4I78AHRLUPunzc5wBHPH5tNAyKtHkvhNLJ+6/Bpgp4Pf1N7HaIFK3xi8l
 dfwkaAmGrA1aw==
Date: Mon, 15 Mar 2021 15:39:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
Message-ID: <20210315153925.GC4595@sirena.org.uk>
References: <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
 <20210311161558.GG4962@sirena.org.uk>
 <f21b87f1afb3eda54b5f00f2d1c146d3@walle.cc>
 <20210312113544.GB5348@sirena.org.uk>
 <6ed28bb5330879b1919aced5174f319f@walle.cc>
 <20210312120456.GD5348@sirena.org.uk>
 <684332700f8be9f77348a510eb6eba22@walle.cc>
 <20210312134642.GF5348@sirena.org.uk>
 <8cdf1cfa971945792b509a687a4de735@walle.cc>
 <6af6439c-bdb8-cd0f-635d-069040ba5b65@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <6af6439c-bdb8-cd0f-635d-069040ba5b65@nvidia.com>
X-Cookie: Close cover before striking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, robh@kernel.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 Michael Walle <michael@walle.cc>, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 15, 2021 at 08:49:00PM +0530, Sameer Pujar wrote:
> On 3/15/2021 5:35 PM, Michael Walle wrote:
> > Am 2021-03-12 14:46, schrieb Mark Brown:

> > Sameer, it looks like the proper fix should be to add the clock
> > support to your codec.

> I agree that complicated clock relationships should be handled within the
> codec itself, however MCLK rate setting depends on "mclk-fs" factor and this
> property is specified as part of simple-card/audio-graph-card codec subnode.
> Right now codec, in general, does not have a way to know this. The
> set_sysclk() callback takes rate argument and not the factor. Moreover the

I just don't understand what you're saying here at all.  At the point
where the card is setting the clock API clock rate it can just as well
set a sysclk, these are equivalent operations.

> same codec is used by other platform vendors too and unless a new DT
> property is added for codec, runtime MCLK update based on the scaling factor
> cannot be supported. This would mean that we will be having two methods to
> specify "mclk-fs" factor, one from simple-card/audio-graph-card and one from
> respective codec nodes, which does not seem ideal.

Again I just can't follow what you're saying here at all.  Again, if the
card is able to set a clock API clock rate it can just as well set a
clock rate via sysclk.

> Yes this is a problem, unfortunately I missed checking some of the
> simple-card examples. I wonder we should be specifically looking for "mclk"
> clock here.

That would definitely help mitigate the problem but I really think it's
cleaner and safer to just push this down to set_sysclk().

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBPf6wACgkQJNaLcl1U
h9Anfwf+NP6HDFtTMIGn540KNLqeTA05Iyt+oW7RwSiBDgEcmupxmx+Zg3B5DtBv
91x/ITUTS+eelZ+Vt2drZY36xNxgj1rY5Zp0P4iI0+dsUabcPlueyYy34Rt8kjip
jyNpLbAJb4RjpfEVssyo2UGKRdon7YwHbz+zgBQt6dxUAumaQa9HrsNDZhxQxe/A
KAeErTEhg62Z9lazAxPupmgLZyGwa4E6z80yb4t6snS182xNsGGz1iwV0F+9Ccr6
Rw3bR3UXovnJXjv7sDgJGBL7MQ/W0TAs3wmbnkAYtQ2Px/WQgvvxPHgGN0cWebKE
xGoRNVLAazs4y/mJB7875+CfQ1plPA==
=Fwtg
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
