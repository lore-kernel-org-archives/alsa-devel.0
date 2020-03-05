Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC8C3F2CD
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:05:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC1920848
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WzUntSf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC1920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CA4F15F8;
	Thu,  5 Mar 2020 13:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CA4F15F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583409918;
	bh=3qXbHaMmE4CbUCL1xUMLrPbvwsPTbQUraZV/SLGXfao=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WzUntSf+KzNktMgPXEfra+dIT6JSeC4Nm4z6XGCrgP2bNYPrON1gpCwcLG7bB3DOg
	 Z9KJWfSlVxw0ZFPcheatuI5+Q9RNw9yekSL0qe2UmvVdcerhRzFqxDq20OFL1iwvz6
	 1+98rvRas0gXGFnThuLpVy3PV0H2O10YTka23llk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD88FF80245;
	Thu,  5 Mar 2020 13:04:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4835AF8025F; Thu,  5 Mar 2020 13:03:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2F672F8012D
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 13:03:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F672F8012D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C901D31B;
 Thu,  5 Mar 2020 04:03:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9F83F6C4;
 Thu,  5 Mar 2020 04:03:12 -0800 (PST)
Date: Thu, 5 Mar 2020 12:03:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: wm8741: Fix typo in Kconfig prompt
Message-ID: <20200305120310.GA4046@sirena.org.uk>
References: <20200304140241.340-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200304140241.340-1-axel.lin@ingics.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Sergej Sawazki <sergej@taudac.com>
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2020 at 10:02:41PM +0800, Axel Lin wrote:
> Fix trivial copy-n-paste mistake.

Remember to CC the maintainers on patches - you've missed the Cirrus
people here.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g6nsACgkQJNaLcl1U
h9BGiAf8C8nysgbLA31qg0f9M2Y8t0+JrqPPejoKKOIzqisb9qxCSjW1/MCJNSxg
qu3EJTLI6prSu0U55LMM9ZGo282LJn8CBw7jkp7DP0Lhpv4UrlKBHasL1aVVC7By
F57LfyhXXDqUTVvEs/5fwjfjZ7kaWFWxpSVFkrR6jy65Y52PpIOz+7+0SkTmM7Pn
N6HEDpSg2AO7Vo1ay6Jli+/d535NdUeZBsKLkoek5A0KjKkcU+VFwXFgO0jMpU9q
b+7tiN42915kcO7dCVqWAcAn5fd/g6gs7MUILWnyCMFipe+6DcmxzXTZHGdImtu/
vAsEc1IRmyn1A1R9b1gz+TQDGEc6tw==
=01FR
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
