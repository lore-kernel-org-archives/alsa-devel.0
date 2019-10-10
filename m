Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C737C4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:21:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B078206B6
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P1SGji+m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xtrkLKWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B078206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7178D1615;
	Thu, 10 Oct 2019 16:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7178D1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570717280;
	bh=nWekgJgjN5lvkhWEPz2lf4brSj/2sRBLYRyba06m8IY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1SGji+mpiIxx5Hpb3arnTG2JLZq/mzniYrbCZjGbvUn4uI9pmB614lNvu9+WZ+On
	 mJez+R1P44JYTVFHtB0bmnmxd86xbTQf7++PrJqJ5doEcDCpB/axM1ue6Pis/CQGFU
	 ThaMCDFciua/KsZ9iR5uf4YXFRvBqE5yNEG9C7Iw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00883F802BC;
	Thu, 10 Oct 2019 16:20:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A65EAF8038F; Thu, 10 Oct 2019 16:20:28 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9DAAF802BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 16:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9DAAF802BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="xtrkLKWI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Ojk2cWFeyBwCUHHnOE4O9lJwi8tYwkK/wWv+v40C14=; b=xtrkLKWISm+703+SCiaaOnkUl
 oIi6Z2DanOQvzsGwnm1Ha7sm172rY11dvUtVYh7oKt6WZ9lIjF2TL51mdIyjKJ3Pp4nL/q0JnuipP
 Qwexm8cOFs8XdkosQ7CozaqdlkUBM/61O4QtiE9JkuPfd3frZyO83yLL3lrelKvao4CwI=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIZIh-0001Yw-LO; Thu, 10 Oct 2019 14:20:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 42D43D0003A; Thu, 10 Oct 2019 15:20:19 +0100 (BST)
Date: Thu, 10 Oct 2019 15:20:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>
Message-ID: <20191010142019.GC4741@sirena.org.uk>
References: <8f933cee57fc4420875e1e2ba14f1937@realtek.com>
MIME-Version: 1.0
In-Reply-To: <8f933cee57fc4420875e1e2ba14f1937@realtek.com>
X-Cookie: Void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "cychiang@google.com" <cychiang@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1011: export r0 and temperature
	config
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
Content-Type: multipart/mixed; boundary="===============5410099573071891601=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5410099573071891601==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 09:33:24AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:
> In chromebook case, the machine driver will get the
> r0 calibration data and temperature from VPD.
> Therefore, the codec exports r0 and temperature config API for it.

This doesn't seem to apply against current code, please check and
resend.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fPiIACgkQJNaLcl1U
h9AtIgf9H5ea4FNSzsP/sC5QMn1bnKbcUVd4wMeWlaJGbLERMmiGk2mhziHUUVWJ
z4KqYLBHDeYjH1jg6fPdUGgeK2S4oTnaFI9siT77WAuhAo1BpXoKuUPxST+WkZv5
YRbCk92WLWujU6RlCU0Rr5P3hw827Ca/Za/pYvzDGuPXl+/F8BOb0zBOz3txRAAj
3ztkQdRIZOFxl/DDFida+nwR2XDqhWexPQrFYZR4Tux7OX9trBinxLaeLCo97X24
IGPQbm+kHfrSzkFYpt1X/8pFBry6wL5DCBJDcilowAiY+Qg8oRaTHKOyNW5YaoCK
Dqnv/VdilRxpTciAeLROet+Fh27O7g==
=Qksp
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

--===============5410099573071891601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5410099573071891601==--
