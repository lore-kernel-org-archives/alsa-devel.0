Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38568C47404
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A26921848
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AHX6w92m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Av22dA3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A26921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0E81165D;
	Wed,  9 Oct 2019 18:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0E81165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570639737;
	bh=E5dbZ6ny1QfNHo7J1UzUqE1OoWhkUByx4SLYcOnxS5M=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHX6w92mesFxhsx2jnHtCY5h1s1ysuyXPxhxD84/xTcDPMVB6PPJfISprUJUXjXft
	 Zgdi2O4OJK1O4ri90NxYb9dsby8yv2/bZGnH4IbbEVs/x6ngKJOraV7K6Y0xDGvT2w
	 yNBgWUgIb+los2nfottCUM9q6EzWR8cg1EPdU89s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D937F802BD;
	Wed,  9 Oct 2019 18:48:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24232F802BE; Wed,  9 Oct 2019 18:48:05 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52866F800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 18:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52866F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Av22dA3b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xihV+hrKUrXRaEoaNU4czLsTlMBrjpQZweZmyEQED50=; b=Av22dA3b5NvucR3HZAk9EzKOi
 k/NA4vCv+QREnefKBAKjB763aPttgXgHHGoioH0LzDfsjA0DktvHrb46x47Nlj/+TnlOByc1m0W7l
 jAQgM2dyEISNs/i5Qt1M/XOB+WuH7ymzY0wMW6m+OnC/bdbkAG61tJITALhPOyqE/+7uY=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIF84-0005G5-IY; Wed, 09 Oct 2019 16:48:01 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A3798D03ED3; Wed,  9 Oct 2019 17:47:36 +0100 (BST)
Date: Wed, 9 Oct 2019 17:47:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191009164736.GL2036@sirena.org.uk>
References: <20191009104603.15412-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20191009104603.15412-1-srinivas.kandagatla@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Gopikrishnaiah Anandan <agopik@codeaurora.org>
Subject: Re: [alsa-devel] [RFC PATCH] ASoC: soc-dapm: Skip suspending
 widgets with ignore flag
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
Content-Type: multipart/mixed; boundary="===============2877087537536540764=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2877087537536540764==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K+L15n4vPMSPOAOM"
Content-Disposition: inline


--K+L15n4vPMSPOAOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 11:46:03AM +0100, Srinivas Kandagatla wrote:
> From: Sudheer Papothi <spapothi@codeaurora.org>
>=20
> For wigdets which have set the suspend ignore flag asoc framework
> shouldn't mark them as dirty when ASoC suspend function is called.
> This change adds check to skip suspending the widgets with the flag set.

Why?  The goal here is to ensure we revalidate everything on
resume, and flow any changes out.  It doesn't actually result in
changes in state on these widgets if they're still powered on.

--K+L15n4vPMSPOAOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eDycACgkQJNaLcl1U
h9BGCAf/dK+uOS4ghYlBx/LFBAJdeo4N5IE1HlHjItdYYchRCM70mbOJqOX3jqT2
411PjY4AgP6/+gUhimf+qm/9V4qoZNOpGrQ7j7tJ8aAm/5qG42CyRzpTyD860XvE
2j9hyVMeTq+thrjDudEnzFsLUqfFTW/SuGE8E66paMqHZFbKrcQ78zOyWeJlcnFd
r9OTrnxF9IDRdagu9qEjna3jeFi7dx2sHa3JNDTt17w3IPcSJ4kKwaRUHlJUaSzr
sz3AlU0SRq//PxZMLMZzO7iCwaJu4saVj6f0vJdMQreG4XzcYx16ihZs3jS6jz6x
OX+6IJiZcojBdTPwf4oLYv7svieS6A==
=DpsL
-----END PGP SIGNATURE-----

--K+L15n4vPMSPOAOM--

--===============2877087537536540764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2877087537536540764==--
