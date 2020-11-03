Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D4C2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:54:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737262076E
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gAFbKnLO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgGH85Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737262076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 072DB16A8;
	Tue,  3 Nov 2020 15:53:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 072DB16A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604415281;
	bh=GVewwPMeCjAxDalOCCOf46CmJoqqIh23iYK56tZAfQg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gAFbKnLO6EjMwdX4xqOuIvIscCmJm5e5kpUOYqgzX6MfAmLDo6mJlV7GDOVPID604
	 INsxCw1yR4bPaTlJqsfoLdIJNsI31/pvCtsPn7+BYjA5GBNTaFCAmen76eN/EAkcuq
	 frrVbEC51kBTposFFQwt8p+v69AAjxjU7/ICvBEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E263F80162;
	Tue,  3 Nov 2020 15:53:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87524F80171; Tue,  3 Nov 2020 15:53:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7CAEF80083
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 15:53:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7CAEF80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IgGH85Fr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77BE620757;
 Tue,  3 Nov 2020 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604415222;
 bh=GVewwPMeCjAxDalOCCOf46CmJoqqIh23iYK56tZAfQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IgGH85FrWT7zXFS6P4u2q+HG2JtNzvLUQSa2ajV+G7JKbeQBbuxoqwaGSe/1sjcOF
 UZYUiR09pGaGOQ8zAomcm8ACk8K9UVixl4pOeBAUHcqnhuRoSPxhO80a7KLiIke40K
 gn+LYgpGFQvVGuuRQWxT+Ksg/1pslaPlzt/A8yd4=
Date: Tue, 3 Nov 2020 14:53:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Message-ID: <20201103145332.GC5545@sirena.org.uk>
References: <20200911091952.14696-1-olivier.moysan@st.com>
 <20ed825b-10b6-e71f-9da4-91df38a950de@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20ed825b-10b6-e71f-9da4-91df38a950de@st.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 01:38:27PM +0000, Olivier MOYSAN wrote:
> Hi Mark,
>=20
> Gentle reminder on this series, as it seems that there was no update=20
> since Rob's "reviewed-by" for dt bindings, on 11/09.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hbusACgkQJNaLcl1U
h9Dm9Qf+JPb2goRZsdbee0uFj53fh/s4jI5jzfiqEEX5flUTcLaxnRR27AcGii7B
9lcpaOHDzg/6oPwTXmQUWN8GMq/QNU+YDiAE+3PeafsCoi+0SZqqYu+UlignrFOy
mRygNLL8OocnwrwtUTFhQpcqs6MJXiLYAvwo5fw+zNpG42C1xnkvH83ZUglhmK3C
ph7kV5Ez7b4/kK1yMqsHBvnftPIPMyZeyauf5xpTGftvzyxMWRqwk9D/Pp4vQkYM
e0/AoIFpz/o3RE62XbLW9Y2+v7vqSXuQr31GcKZwF5lmeVzHJpDOfxdtsHExzTGv
S6xL8vxHCBwnRNrL9lEzduzWwk9Teg==
=3wTy
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
