Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B447FA3728
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:39:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5812E205F4
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LX41/JBS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sEwEZn6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBA9C847;
	Wed, 16 Oct 2019 13:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBA9C847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571225951;
	bh=kLcY9qbeOLq+Mbj7Z7WzIB0ydXvkF/HFK8I41PlsFA0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LX41/JBS5YEBjr7AjQfqqxBTdSfpUTypT5Q34XpMi3ouoJbyGUpBzbcetsO5bPvzq
	 RHpY6fWI79UmGJ7dsw/GNhv/ZmtOp6u7YTVwvIKjXSVjKuPOBjrm1+AWFOvrdNq8DX
	 VrYPx8wlZX6xfjloOLV+d5Ogl7FdXROyGjhlI5dI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 720B4F80276;
	Wed, 16 Oct 2019 13:38:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0BB9F80362; Wed, 16 Oct 2019 13:38:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E983F80276
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 13:38:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E983F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="sEwEZn6v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xOg0pINypU83vp5j4UZoUiVYQVH5WoOQHQqaxcWBZ1c=; b=sEwEZn6vtxtokJjFo+mPnPrM2
 UpTP7qxLN5p4vZiAtYHoVa0LRM14NehNYdzr6WnH89ZvrjlPN7ElTsD6JiqdenItlW5sM7kMHT4Nl
 Wnf73FPx17tAoWkqElR4tJht37/3G8v7fb0cnrpjU/AyNQggsfraCbslBZeWaEEGrI6NU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iKhd9-0005BM-2l; Wed, 16 Oct 2019 11:38:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 3C9A32741FD5; Wed, 16 Oct 2019 12:38:14 +0100 (BST)
Date: Wed, 16 Oct 2019 12:38:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>
Message-ID: <20191016113814.GD4881@sirena.co.uk>
References: <20191016085845.11672-1-shumingf@realtek.com>
 <20191016112349.GC4881@sirena.co.uk>
 <fb55fba1f6e8441983fbd563e4b89e45@realtek.com>
MIME-Version: 1.0
In-Reply-To: <fb55fba1f6e8441983fbd563e4b89e45@realtek.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "cychiang@google.com" <cychiang@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1011: Read and apply r0 and
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
Content-Type: multipart/mixed; boundary="===============5288762457658319998=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5288762457658319998==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 11:28:47AM +0000, Shuming [=E8=8C=83=E6=9B=B8=E9=8A=
=98] wrote:

> > These are new DT bindings and need to be added to the binding document.

> Sure, could I send another patch for it?

Yes, the DT bindings should go in a separate patch anyway.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2nASUACgkQJNaLcl1U
h9CQMAf9EOrsqUvVLANUqMtmLx5u46SkDGCDd+ZjYbDr/+UFydkWxeJRKb+PXMFH
ohanoqnzMpDcB805DDioCOWcn8RPm36rintAU841y3BCG+2snxVtokH8p5z18LMq
cCGrDkP3tTo21WB0nm9yKmfPQskcXNlRet+NvhROnTDiz7TyNwJcceOsS8PbIMFj
Ayd6D79AzWFlrAHnH6Yj9ohBYVSuLWP323xzFLlatB2+7MywXXtd0H1XHcwRKxhQ
ErQUieJvg/YohQ4S+yxaOTivTADBEd5xAKoTfLzDjIKgiUTLui0uaMj9raLr6fNS
5qwbxcDCsBl88tX0KPH169mnNUUGOw==
=vFVF
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============5288762457658319998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5288762457658319998==--
