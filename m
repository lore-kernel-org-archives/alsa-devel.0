Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D89C2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:41:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70415206ED
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mvEhjkT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70415206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD9E916AD;
	Thu, 13 Feb 2020 18:40:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD9E916AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581615707;
	bh=+RWKxHlQ3sp8q9ytf8VGDZOE+NBgXVllzRnZD3aU+/w=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mvEhjkT26A/nCfZNyHkmlvU0r6pVzj4GHBX+4Pmntv2XiReBkCWuGnPI7QrmMeFOV
	 oxPoyFO3hy4dXFUzJF8sXDb6CcgLmUr9L8j6LgAzPjLEEFF5PLPTDPErV3LvZoYRPA
	 92l/5wCUJYE/Cx/2Tr6QoWsoccbWPyLosdHKuQkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EA33F800F0;
	Thu, 13 Feb 2020 18:40:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3ADE3F80145; Thu, 13 Feb 2020 18:40:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5A797F800F0
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 18:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A797F800F0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11579328;
 Thu, 13 Feb 2020 09:40:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88E763F6CF;
 Thu, 13 Feb 2020 09:40:50 -0800 (PST)
Date: Thu, 13 Feb 2020 17:40:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Message-ID: <20200213174049.GI4333@sirena.org.uk>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
 <20200213155159.3235792-2-jbrunet@baylibre.com>
 <20200213171830.GH4333@sirena.org.uk>
 <1j4kvufkwq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
In-Reply-To: <1j4kvufkwq.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 1/9] ASoC: core: allow a dt node to provide
 several components
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
Content-Type: multipart/mixed; boundary="===============5361299996534891631=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5361299996534891631==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 06:37:41PM +0100, Jerome Brunet wrote:

> > My first question here would be why you'd want to do that rather than
> > combine everything into a single component since the hardware seems to
> > be doing that anyway.  Hopefully the rest of the series will answer this
> > but it'd be good in the changelog here.

> Do you think there is something wrong with a linux device providing
> several ASoC components ?

I don't know that it's actively wrong, it's more a comment about the
changelog only describing the what of the change and not the why - the
original idea for a component was that there should be a 1:1 mapping
between components and devices but as you say it's not actually a big
change to let things get split up more.

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FiiAACgkQJNaLcl1U
h9C46Af/TpnlCjwtU4fMMnm8c7NfPorK7RegG0x4rLJk+edJ9/SFZTQw+xzrqVqN
nPQMM1kD0EyLWF7yyIfRTupKgib8azZih6jb2hxU1kp8LdmkDqNsN4urF9cPw16i
0ZljRlQJlVyNLarFet7ctm38otSlAXCadIlzZVODeytxnXrrh0Av6wujTqqBaRCV
8DGNYnfvQxHLh07dxM93Yxe2kP2wWHjYnbPiaXqsYARsK7KfqdqZEW+ojCptuhPL
VXgEbh9Gn9ZHCClylentU1Y3Tg9AmpyUpHrNeEvFT9urgLpTDbcAzW1vP/k/35CD
GBbkYBwAxXr8jfIftVZwP9foH48WRg==
=WHzO
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--

--===============5361299996534891631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5361299996534891631==--
