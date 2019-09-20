Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20079C49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:09:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161D3208C0
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JTvF9+Xc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rVL5GPLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161D3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6F901669;
	Fri, 20 Sep 2019 13:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6F901669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568977747;
	bh=SO/Lo7xZtg6l/XQGxF7dhqO+kUFAKHR7jIkxDxjJKU0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JTvF9+Xcjoatgsh57qC9sdXthCxMKEmnruqoC3HDaAobocQKt2pt1tC+Zm57yc1uG
	 k2qzY+3N62au/94fuVIcWrJ7/2d+FOrf5DBI1fSqAYkkVVNTH7AQezDxiI/Pgjv2j5
	 loTYsoR2Gj5kCah60AdyzJ0REX0aBiVtMJk/g3ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6943CF800C7;
	Fri, 20 Sep 2019 13:08:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54205F80506; Fri, 20 Sep 2019 13:08:14 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08908F800C7
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 13:08:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08908F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="rVL5GPLa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=co4b4aB0J0Xpxr58MRMzHkr+EMJZYe7/FtiyekbtgeY=; b=rVL5GPLaJqivCCSjqFGp8dvAF
 nxpdk9Huu0H0Dv3YjClZ5af6/5cIkZOCjlCENUOI5lYeBwkEl2O/rg4uEw6SI0ZjokWt0GLwADf13
 Fdawjh+DDUkY8bqk0RHRXAOoxypT+cY1Dp7zwwWThbaWjU9oyzIIBlvjBiHyVb7zO+IY0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iBGld-0001by-Cf; Fri, 20 Sep 2019 11:08:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 94FAC274293C; Fri, 20 Sep 2019 12:08:00 +0100 (BST)
Date: Fri, 20 Sep 2019 12:08:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20190920110800.GD3822@sirena.co.uk>
References: <87h859hrv1.wl-kuninori.morimoto.gx@renesas.com>
 <20190919111559.GB3642@sirena.co.uk>
 <877e63akg6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
In-Reply-To: <877e63akg6.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-component.h: tidyup for
	soc-component.h
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
Content-Type: multipart/mixed; boundary="===============2099871986390260809=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2099871986390260809==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2019 at 09:19:05AM +0900, Kuninori Morimoto wrote:

> Not 100% sure yet, but actually I'm thinking that
> current some sound headers are very spaghetti code.
> Someday, we want to cleanup it (this was one of for it).

Part of the reason they're the way they are at the minute is that
someone (IIRC Liam) got part way through splitting a lot of stuff out of
soc.h which was getting very big but didn't quite complete the
transition.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2Esw8ACgkQJNaLcl1U
h9BSYAf/Va8QD6saJtUQtLhhV5h07hfh+zUEdGMch6U+7CTZAU09EgwqVpoj06ji
e/FM8FB5Oc9dTe9i7l0PBBb5mG/yieSdbqQo/bIybD/AKEOkpnPRd2eJdaiQprIt
L59uy4XTW/BusJhc90R7s7MJwuYE+LtCtHUbBDccUhIq8YilkjthSDcpd/KHOjPH
voSntk36S/LnQrQSxcDD/+xtvCRQeLbPCvX9xUER3jWTo/bVmbtJnEVAtJg6n4CD
TVl0Y6yH8vWYoDHhwrt+ABEsJtFynkHhpTOk5AHoYR2lGxAwcrEWb0QgrI9Rbo+8
0g7GRMB4eD3MbpH5zZaLgU03YaXJEw==
=HRO7
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

--===============2099871986390260809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2099871986390260809==--
