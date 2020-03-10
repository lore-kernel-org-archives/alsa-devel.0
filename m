Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C23C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:38:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0018624686
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MVq60Ien"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0018624686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 545F8851;
	Tue, 10 Mar 2020 13:37:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 545F8851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583843891;
	bh=X0sEz4payhG1fjvJGWD595RqJCzH8z0UfJdotIC16vk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MVq60IenE6YrzMMdtqyUFgey5k2LR+Tc3v6feAJEx6RHn4cawaF2LNSCalexsOHCy
	 tvNFUGIpNnkrVOhnG17oaoQTzkKJ6h4lsQoZL3YfDIdUCIrHwEwZi3KAZjRQffrvef
	 YqxhU00G1qNCwgQ+VgwOzitkf6o0NGQyyWktoh1U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE388F800DA;
	Tue, 10 Mar 2020 13:37:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F533F80217; Tue, 10 Mar 2020 13:37:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7C13DF800DA
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 13:37:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C13DF800DA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803B730E;
 Tue, 10 Mar 2020 05:37:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B533F67D;
 Tue, 10 Mar 2020 05:37:12 -0700 (PDT)
Date: Tue, 10 Mar 2020 12:37:11 +0000
From: Mark Brown <broonie@kernel.org>
To: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH] MAINTAINERS: Update Cirrus Logic codec driver maintainers
Message-ID: <20200310123711.GA53842@sirena.org.uk>
References: <alpine.DEB.2.21.2003061508150.32557@james-tower>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003061508150.32557@james-tower>
X-Cookie: To program is to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "Rhodes, David" <David.Rhodes@cirrus.com>
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 09:10:38PM +0000, Schulman, James wrote:

> +++ b/MAINTAINERS
> @@ -4021,8 +4021,8 @@ F:
> Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>    F:      sound/soc/codecs/cros_ec_codec.*
>=20

This e-mail is corrupted so the patch won't apply, you've got word
wrapping issue.  Please check your mail configuration and resend :/

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nifYACgkQJNaLcl1U
h9CyfQf+N6jCxkozIrxQRp9J62BZBuHtmMBlJxq5zJM3EMcV1+OSqX3Zl3w1278Y
/WWMQrn1GmBniHkX6nZ718YNYM4DCWzySi0ywTJCViMs8cLWloxwta/yTS7b3EBk
9S269k3FwZ9BU14UYPqfdmF1W+BT8SauK9jwGd8hCFhzkQdxzktRaPZQx9RsjeAG
HQO1K+HP17Qp1rJ/kO7kTUJ5QVzEu3BXY/EsfkCjpHAsoJbdcmmkyA1pOhyl+inl
Sjpjqm6u9yv5VupxPOR1qfeZO+Q4ewkr/IhNNPe31Q412AYHXoSqstXzpbMQ3mX7
xJoPQBhpfVcvMD1Q0OWt9iHd/t1r3A==
=+uJv
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
