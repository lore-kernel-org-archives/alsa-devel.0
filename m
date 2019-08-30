Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F4C3A5A4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:19:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469DC21897
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gwf6PXel";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YV5bsu78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469DC21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09CBF886;
	Fri, 30 Aug 2019 13:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09CBF886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567163957;
	bh=b0T0BukowNi+eAZW7qKNMAjO5+yNu5pc4PovXL1PHQo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwf6PXel/eHuDHCD0RzSS6N9CQFx2BvauDp1QWy6NsBEh1GcB0M8w/gef4ViX5nML
	 vTNeqMYLR5aMGs4LPHa9CXLoypt5mvAL7V9k0FpKxgQ8Y5/ftsj1lwQ4ZHAp3PUNFR
	 pfPA0ClZIYX8nHx+82KenufNeKZMVMyhmlxbq5ko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 678D3F80362;
	Fri, 30 Aug 2019 13:18:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51F1CF80369; Fri, 30 Aug 2019 13:18:24 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D40C8F80096
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:18:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D40C8F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="YV5bsu78"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Ag+0BOmBywnIFIz+nrRSrUI5T5t6J5drhYhi0EPdvc=; b=YV5bsu78PtYYon0Hved5dBaQz
 4DSi+cXKEYAburcA+avOKbLa/ntN5tkrCOXUuLlp1e20SOkqgX9Mkmg39dyDyoqQOi+fnignMJM+z
 NeHOOGYff+Ynu0VKlTKcet5oFAbcITTr+L0H02kgsk7QtrPvzhoY8DajjAOUDTa58HUdc=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1i3ev4-0006Dq-OB; Fri, 30 Aug 2019 11:18:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 539872742B61; Fri, 30 Aug 2019 12:18:17 +0100 (BST)
Date: Fri, 30 Aug 2019 12:18:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <20190830111817.GA5182@sirena.co.uk>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
MIME-Version: 1.0
In-Reply-To: <20190829173205.11805-2-katsuhiro@katsuster.net>
X-Cookie: Send some filthy mail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
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
Content-Type: multipart/mixed; boundary="===============1801542846718111986=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830111817.GYcWY3kIJXt49u8CX4hu47M2xukw-rEDjxMr3FXNz8U@z>


--===============1801542846718111986==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:

> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

If we don't get a clock it'd be nice to at least log that in case
there's something wrong with the clock driver so that people have more
of a hint as to why things might be breaking.

> +
> +	if (es8316->mclk) {
> +		ret = clk_prepare_enable(es8316->mclk);
> +		if (ret)
> +			return ret;
> +	}
> +

There's nothing that disables the clock on remove.

Otherwise this looks good.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1pBfYACgkQJNaLcl1U
h9Cfdgf/QHjLqKONAE1J+gdjS0oEehwivLJxEfiY5Bz+LQ/xr+cbRBqLot2+aWM7
b0nZOgOiyKEj6nHSsFnd5ss9GJPvxePyhpwrYifIwRk9UyD6Z16cDP7V1Rz4ad0z
SFmyAE1XHhvbO5MrQvfmKpO9NfiyiuieFf3HQNDgDfPzLKBHgBXZEv4uHuAp7Id6
DeggzMHMb4buK21+AWzcMUh8i8Uygh93qvvpWp6crjUkiIx11kmGuJSp7bYSTx28
1DAHiGVBssJ/RVRk/DJUDuHamDOg+zdDzsy2Br+67WLM8o7azI/4zV3q80HdMz3P
KnY0fDkDGYNvaRG9WZfo7UR6sCQNdQ==
=QHgV
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============1801542846718111986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1801542846718111986==--
