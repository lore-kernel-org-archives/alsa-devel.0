Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E99FA372A
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D54218DE
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cyqD8nbP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Sk8Q8B1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D54218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35CDF846;
	Wed, 16 Oct 2019 14:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35CDF846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571230546;
	bh=X885FA/XsleTUjiddASD+nNtoW9gomgJSc/DG+NMEk4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyqD8nbPpZi3M34XGIrRHEZPiQjLdnC4q6oo/dJuEO7x/lhQRtvuUjUFC42k+THz+
	 TzefoH8PPTxteAvfeA+fp7uaLfoIzScAIP736ADE0om6+aUjuuIxhmvi62BNdhXeH5
	 Bo1DUi94sw2ol9V/RJLLCA1Bqd4JIQCZ1mbE8noM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B62F1F80323;
	Wed, 16 Oct 2019 14:54:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFB1EF80362; Wed, 16 Oct 2019 14:54:53 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A3C4F80276
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 14:54:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A3C4F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Sk8Q8B1s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WqeGFCv18TuZ7rbQEViz/qP3PqPC7V7p+dUz9t1Tbo0=; b=Sk8Q8B1sQb5yK/bxwwmV0YOtZ
 LzZB3hfq8I3rEM/R23D3Eu2t69Xt7PmnM0t/jn/AIVzr9aCikooUZDuSJ0y5CIo6J0ex7phfabBp+
 oTuUYt2G31GRV6gXYhqoa1O9APr/s1xY1GDT7wSbNus/ZPQSd2gCZZv2TII8na8S58sas=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iKipF-0005LZ-QL; Wed, 16 Oct 2019 12:54:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 538282741FD5; Wed, 16 Oct 2019 13:54:49 +0100 (BST)
Date: Wed, 16 Oct 2019 13:54:49 +0100
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Message-ID: <20191016125449.GB11371@sirena.co.uk>
References: <20191016115617.23213-1-shumingf@realtek.com>
MIME-Version: 1.0
In-Reply-To: <20191016115617.23213-1-shumingf@realtek.com>
X-Cookie: Swap read error.  You lose your mind.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, cychiang@google.com, lgirdwood@gmail.com,
 derek.fang@realtek.com, flove@realtek.com
Subject: Re: [alsa-devel] [PATCH] ASoC: dt-bindings: rt1011: add r0 and
 temperature device property
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
Content-Type: multipart/mixed; boundary="===============1735222467325745970=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1735222467325745970==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 07:56:17PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> Typically, the r0 (calibration data) and temperature were measured in the=
 factory.
> This information is written into the non-volatile area
> where keeps data whether factory reset or OS update.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2nExgACgkQJNaLcl1U
h9ADWgf/T7Zd4AEYj2L+Owo7CyEqE5JpRgjUcCMDm137WGPeWmigyXNijHw4yDKi
lAG+NtHIJitOw8EgQkyFcRS4qZpoijpT0oF9kSE1SXzltnNh4D5Gik4BY/Sc+G2r
+xmKe8t1h7YBR7uYDRZaxczmp39CFj7sm/k2O/guo8jReD2wJfT8a7CBqWSvOKo2
pSAnImOfVxZ40Bu8uwZmaa5+sRS5x0hhT4odux4xUfXACP8rrZZsdXpDDkRgDei6
+Jm7JK2gmFOx6CzIbHppSY5tlH0OMI/1Gx+lBkC/YRhC2a8xjY563HGhw5iZc6UT
7/M9SSb3lGrwwbFqNSD5WGN1iLh9Lw==
=uTOj
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

--===============1735222467325745970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1735222467325745970==--
