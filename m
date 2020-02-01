Return-Path: <SRS0=WHla=3W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B2C3524A
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:02:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8072E20679
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z+v8LJXm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="j2L+e5NW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8072E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C57CB168E;
	Sun,  2 Feb 2020 13:01:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C57CB168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580644941;
	bh=IT6RmFpHr0X40hra8X/1Xfk+YctZBX82t6fldmn2XdU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+v8LJXmtbaE22eyC9rgFO4kzJMlMOeFk6uibtw+OsEbrb2O8npI8JNKcDXpuKMZN
	 UIXAe/sWTA17X8eWJYa/DxeXWncEm44moJ8G8vuRxKYNh8SFMZh+FBnf1cA1RZ2ri0
	 Jh5rxLGUij1Bk1n1W5cU509tPeo4xsCms2nPAflw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B7AAF80212;
	Sun,  2 Feb 2020 13:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18874F801DB; Sun,  2 Feb 2020 13:00:36 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32465F8011D
 for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2020 13:00:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32465F8011D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="j2L+e5NW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lPzWLn9eAfmZaZgtVXbLGbwWmlBqlL7DYMSG6vEQjls=; b=j2L+e5NWwaUMC1fJqOVZJeRG8
 XVGp3fN6jeeunuFTJSB9WS2gzfhB8Gbv+c0gkve1Wt1jr0168A+4s48YFgWBwaMBsau1tHQ0vJr7b
 ekSgPubB5dwhee3telxcBpJwTaufw8PLUnWclHshCCBDYId+if/b4myzi4nBTvVNdjs6Q=;
Received: from [151.216.144.116] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iyDvT-0006pl-Dn; Sun, 02 Feb 2020 12:00:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A94DED00AD7; Sat,  1 Feb 2020 11:03:58 +0000 (GMT)
Date: Sat, 1 Feb 2020 11:03:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Prashant Malani <pmalani@chromium.org>
Message-ID: <20200201110358.GR3897@sirena.org.uk>
References: <20200130203106.201894-1-pmalani@chromium.org>
 <20200130203106.201894-12-pmalani@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200130203106.201894-12-pmalani@chromium.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Guenter Roeck <groeck@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH 11/17] ASoC: cros_ec_codec: Use
	cros_ec_send_cmd_msg()
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
Content-Type: multipart/mixed; boundary="===============2829355952562405156=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2829355952562405156==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYQNNDjzvANyiJW1"
Content-Disposition: inline


--mYQNNDjzvANyiJW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2020 at 12:30:56PM -0800, Prashant Malani wrote:
> Replace send_ec_host_command() with cros_ec_send_cmd_msg() which does
> the same thing, but is defined in a common location in platform/chrome
> and exposed for other modules to use. This allows us to remove
> send_ec_host_command() entirely.

I only have this patch, I've nothing else from the series or a
cover letter.  What's the story with dependencies and so on?

--mYQNNDjzvANyiJW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl41WxkACgkQJNaLcl1U
h9CH4gf/QSLdGaGwrm8clz1CuyNmPEKvX4LsDa9tkoPrV22OkRCgy31n3b+n4x3S
9KJtgvF1lFaFdo9Wprt0h8mTSBHlChsmiC8pe0n6qFOS6v7VcjRmY0boiO6W9nz2
lO9C1ZI5tlRXX8ipBnJiugQDn/7zanjYSm1O1wZyxJt1dWuY/KqTDIbZput0vmAS
Gbeq/152zVWRCjjLMteZ+2O2GYiasRvriSsEu9rnQzO1+6pbpF897W8EgHhtA3kn
h92YKhAv1UYVkWhV6JBjhv9yfmaMymr1UQ6x6yVsr4Ioppx7i8+a7wSY8AT80ra2
pdXC0uvO4dIp8fE01StcLOYZQ/lZAQ==
=kCyu
-----END PGP SIGNATURE-----

--mYQNNDjzvANyiJW1--

--===============2829355952562405156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2829355952562405156==--
