Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F8C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:25:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549CD2082C
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YuCxP5Pk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gYfSIaRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549CD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43F4F1709;
	Wed, 11 Sep 2019 12:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43F4F1709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568197510;
	bh=N/wof0qZ6Wi3P7PEcncITS/+CpaZl9tB9aD37Mbk2IQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YuCxP5PkaPuveu6YLuVuNqzyC6JAqMVf41xwReA9jUJGkSn27ICkE/T7ZK7BdhJJk
	 Wgzht21P8u2D81ItjnC56Tw0XwP1HFYidMz1wSviQvGAFEi6EXE9jS/z53lsJml0nF
	 h1/Qk8PCKV0J+IH4JdWVnpr+McgHWJ7YeRNVCCZE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8F40F8031A;
	Wed, 11 Sep 2019 12:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A91E7F800A9; Wed, 11 Sep 2019 12:24:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49858F800A9
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:24:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49858F800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="gYfSIaRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBThNysCAvHSnYBmNEvS3z1uE+4qP+TZBCnb5s97EJE=; b=gYfSIaREC1GoublO+DQVwOfEp
 gIyh/mKXICC2r+zby+kYpzP4IsCDXnhrs/vDSvcbC+lzxrp2eqXhvAmm6MP48pRD9rQ6UMWCKdZC1
 Lr0DFDnR/H7fMU1atxqIJGtS/EPk1VdT4nWF/1tcsUZl2+NEZhJoV81KChmhk8USMVWPw=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i7znJ-0007l8-GP; Wed, 11 Sep 2019 10:24:13 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id CDD71D02E98; Wed, 11 Sep 2019 11:24:12 +0100 (BST)
Date: Wed, 11 Sep 2019 11:24:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Message-ID: <20190911102412.GU2036@sirena.org.uk>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
 <20190906194636.217881-5-cujomalainey@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20190906194636.217881-5-cujomalainey@chromium.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [RFC 04/15] ASoC: rt5677: Load firmware via SPI
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
Content-Type: multipart/mixed; boundary="===============4663020920875065861=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4663020920875065861==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gSSGYPGSs0dvYOj7"
Content-Disposition: inline


--gSSGYPGSs0dvYOj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2019 at 12:46:26PM -0700, Curtis Malainey wrote:

> When 'DSP VAD Switch' is turned on, rt5677_set_vad_source()
> enables the following digital path:

> DMIC L1 ->
> Mono DMIC L Mux ->
> Mono ADC2 L Mux ->
> Mono ADC MIXL ->
> VAD ADC Mux ->
> IB01 Mux

> Then we switch to DSP mode, load firmware, and let DSP run.
> When a hotword is detected, an interrupt is fired and
> rt5677_irq() is called. When 'DSP VAD Switch' is turned off,
> the codec is set back to normal mode.

Usually we would configure all this routing in userspace.  Why
are we hard coding the use case here?  What if for example the
user wants to use a different microphone?

--gSSGYPGSs0dvYOj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14y0wACgkQJNaLcl1U
h9A4xgf/Z/dk5AjgCo+hCH+J0cYXsOCG5eU7jaenb0lGGdTe4urMKUU6AOBpQI63
7GPoGu1MhxpsCkmDDfClXHh+8ic3cO2UAk4of1CW6K42jT9iP/eBAiI0/kuSeatN
vdZsYVP7GardEYt+8lcMRd4yvesj7eJSOfSRosVE3a9O5FZQBebWVKFpY5rRzdP4
sLJi2LXhO1PqtQa7qkWn03Oa6U/sAqM1KCWxwFLvD7n3+3rLYliVyk4T0urdwVqh
UTfV0rBD8bCZMGsnTFHNZoq1uP4yfMBAxKg5kYaXytN1dwg4IjATeQz3aWZBPtyu
d/pTfqdGeasoMxQB1DcPlCAL+HFD/A==
=PcYw
-----END PGP SIGNATURE-----

--gSSGYPGSs0dvYOj7--

--===============4663020920875065861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4663020920875065861==--
