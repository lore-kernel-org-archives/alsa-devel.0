Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786EECE58D
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C28218AC
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uUOjkNZU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fRSoG5IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C28218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E5771614;
	Wed,  9 Oct 2019 18:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E5771614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570636878;
	bh=36iH/JSrd6EUam6eUz6QMxTVMeJ832w0Xbd4v3yyx7U=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uUOjkNZUlP/CJSqgIYr88FVBAQ5Cp7SWRr+o3F5gQw1Mkc1RcSkRw9EH5xvnr1+6T
	 MOaRBfBzZ3Vv8awWWARdjNFcZsyxVnsGJOG9R/GJlnqGLgxCqgzzxa/JZQVNqo+C6b
	 24LAmNokq4k0g9J7qYMGz88l8sNG6y4e/oe0WJ2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11707F802BD;
	Wed,  9 Oct 2019 18:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51DD6F800AE; Wed,  9 Oct 2019 18:00:26 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42F56F800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 18:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42F56F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="fRSoG5IP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZkEZaeUG2LDB7osCCzA5SGc46/Ti4vNDPD35O8V/wEU=; b=fRSoG5IPBwTlf8+/uwewnaoO2
 PPQAsKxb3vydNdYfAmppcADKDWbo4O4IFN7Cb7o6wx2ZXI3BWi+soz5OkrNa/QbPb+2dFqQkwGhLU
 aSdjW9JvtHnotZOkP5i9r5Mp6oiT008KhxfV6TPVeVGY9XJjAVNVQrbmDgrQpx8euT7Ig=;
Received: from 188.29.185.136.threembb.co.uk ([188.29.185.136]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIENy-00059v-Ow; Wed, 09 Oct 2019 16:00:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 97E72D03ED3; Wed,  9 Oct 2019 17:00:21 +0100 (BST)
Date: Wed, 9 Oct 2019 17:00:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Message-ID: <20191009160021.GI2036@sirena.org.uk>
References: <20191009142822.14808-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
In-Reply-To: <20191009142822.14808-1-oleksandr.suvorov@toradex.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sasha Levin <sashal@kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/1] [for 4.4/4.9] VAG power control
 improvement for sgtl5000 codec
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
Content-Type: multipart/mixed; boundary="===============6458982420117995009=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6458982420117995009==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yqoYZO0eSM9FLp66"
Content-Disposition: inline


--yqoYZO0eSM9FLp66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 02:28:36PM +0000, Oleksandr Suvorov wrote:
>=20
> This is a backport to stable kernel versions 4.4 and 4.9.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--yqoYZO0eSM9FLp66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eBBIACgkQJNaLcl1U
h9AbxAf+MlzUGC3a6HyTWNrYD7RjNIuqO5iMIsQXvmAOjQQaQcKxIokPtRdZ0DQF
hm0TpNMj97hj0LUvY8P17SP3CJcSJbfsj+ikz2gRL4C1dTmwEIYpeUzvt2ujR58r
mxqx612RmrOalJymH6BKYjw6NUElAjIvO9+bHWCjww3PzfMNj4y9WLZoA9v+BENa
eHNBLuay5ropZOJqhMc6GMNi9EKGnONc1wxw9bFVMGfGK7FiVB9MCOYoeMGVDjvh
5hjeiSmi41giMyjsOQ1NQPtbTW6ymSmT2VPSBEkbulwO0B2oz35hrI9J/JWJmxHh
RofXuI2v8EOT61r3XR7bevxA8PxT8g==
=Psvc
-----END PGP SIGNATURE-----

--yqoYZO0eSM9FLp66--

--===============6458982420117995009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6458982420117995009==--
