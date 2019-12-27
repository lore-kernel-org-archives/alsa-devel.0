Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860FEC2D0C3
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 22:53:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF2320828
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 22:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LK7apVUG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="E8YSckFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF2320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C5DC1746;
	Fri, 27 Dec 2019 23:52:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C5DC1746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577487182;
	bh=8i5ZJ+uBDnSViGahoMg55IDJCkjVPAeLN3QSnZjg/LA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LK7apVUG0UEeyZtxxxqzvtO3erk2aZ1FnjBEv1y9DM8zKzt2xPiPilZ8COz2rWwEx
	 y6+twlMazcrob6LQOuqZTEIiyInuFCset55l0QG8roj0g4YrI3D1c+DtkhOS6oSsrI
	 dCb4Csz0naiq+UsyROHsaaBr+41cfoSQaPVZ2/2Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A48B8F800AE;
	Fri, 27 Dec 2019 23:52:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7577FF80132; Fri, 27 Dec 2019 23:52:09 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA530F800AE
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 23:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA530F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="E8YSckFi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uo5gwvZX1uDmAXJCobtVZcEzJivK6+plImhSXfcTazg=; b=E8YSckFiwq8AmTe/jo3dd4d1H
 VrHrnqCBw7M3qZk/dbLor5AstRRROVDahgcKr1OIui8etXF+Jst+I0kB2opBTJ4jWIkuw3IjnjpFD
 V0OPmSjLSDqv2pcmawtgZdG5BP0LcCNM1LWmKgDcJ0lBguVtGfcrx0RA60erZ3w4jjFcE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ikySj-0006bK-Ax; Fri, 27 Dec 2019 22:52:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id CCB0DD01A22; Fri, 27 Dec 2019 22:52:04 +0000 (GMT)
Date: Fri, 27 Dec 2019 22:52:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Message-ID: <20191227225204.GQ27497@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
MIME-Version: 1.0
In-Reply-To: <20191227152056.9903-1-ps.report@gmx.net>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [alsa-devel] [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read
 error gracefully
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
Content-Type: multipart/mixed; boundary="===============5549082879204705329=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5549082879204705329==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> Fixes:
>=20
> [    5.169310] Division by zero in kernel.
> [    5.200998] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.18-20191021-=
1+ #14
> [    5.203049] cdc_acm 2-1.6:1.0: ttyACM0: USB ACM device
> [    5.208198] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    5.220084] Backtrace:
> [    5.222628] [<8010f60c>] (dump_backtrace) from [<8010f9a8>] (show_stac=
k+0x20/0x24)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4GixQACgkQJNaLcl1U
h9A2XAf/ftJi8y2gf6jp5exddrR2eCgueTtnjQZXReQ7py0ARP6uZOB4OeAMQr4I
SpEg97JgYdyPaS8GZbklpT5Vy740Dk7j9fJYQpyMv/VWzRV9csz1vSqJCzIhnMRz
m38aujNV1+ddXB1g1xDLcd76wD2M+RM+JCUb+Z6x7e8CK2JMe9YllQVHLkp0pSh+
zwmxEpTajmb976EdW8z8fFseuWub7BSDFw0aO7lqeekEM/hqFjX5IqkXLatTatVE
uXyR7PwBUudPDLlxwcnI9wP/4dfl3f+b7N/V0/CQnYe/lDXrwYB6I8jFlyqQbXmh
VvSW8YZOaXPoWhSI0+mDvbM58wkXaQ==
=2cP3
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--

--===============5549082879204705329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5549082879204705329==--
