Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D9C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:35:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE1A20838
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JNnLS4hH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbD8weUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19385178E;
	Thu, 30 Jul 2020 14:34:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19385178E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596112514;
	bh=AICqF0qVPcxX6h2jgoARmYjtKK+QC3weSgG1Wfeyvwc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNnLS4hHNzC9+KFzhksamjcAWAMvD0wIt/jkR78kmHhrx8BwCVU0UvnHr/c30Q/hr
	 fZdqYjTPBo6wi4w1wnY5vlNzeLNxhPvQB1HSEzjlCjKAhM63zfKlG/QqCcTmPcpXLE
	 kR/QB83DZfMEmQhUz2lvMsubO+1GerYUiK8aFzAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A51D6F8021C;
	Thu, 30 Jul 2020 14:34:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 622F1F8021E; Thu, 30 Jul 2020 14:34:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B76FF80111
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 14:34:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B76FF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GbD8weUO"
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 [82.37.168.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A074E2074B;
 Thu, 30 Jul 2020 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596112453;
 bh=AICqF0qVPcxX6h2jgoARmYjtKK+QC3weSgG1Wfeyvwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GbD8weUO1Ithjde50V8FenwXItv0AhdqzArlcfemAfKUXrcNtOvOIsUzjqTIQJXRv
 8vvZxxRA7NqlaJhJbmtwaLKbRVZZO7Tupei6MrFQ0TNpLLC8ioABW0v1J56d3CEaui
 zIHSLQAv24jbHQOZXTQ6ePBPUBZZQAXkvbuUCPig=
Date: Thu, 30 Jul 2020 13:33:53 +0100
From: Mark Brown <broonie@kernel.org>
To: "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH 3/3] ASoC: codec: tlv3204: Moving GPIO reset and add ADC
 reset
Message-ID: <20200730123353.GC5055@sirena.org.uk>
References: <20200729073256.24028-1-michael.wei.hong.sit@intel.com>
 <20200729073256.24028-4-michael.wei.hong.sit@intel.com>
 <e97b37d1-548e-6ede-4015-563d4f67f5e6@ti.com>
 <BYAPR11MB30468CC46295BBA5BEF0FB0C9D710@BYAPR11MB3046.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB30468CC46295BBA5BEF0FB0C9D710@BYAPR11MB3046.namprd11.prod.outlook.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "a-estrada@ti.com" <a-estrada@ti.com>, "Shevchenko,
 Andriy" <andriy.shevchenko@intel.com>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, "zakkaye@ti.com" <zakkaye@ti.com>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "Sia, Jee Heng" <jee.heng.sia@intel.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 Dan Murphy <dmurphy@ti.com>
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


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 05:46:20AM +0000, Sit, Michael Wei Hong wrote:
> Hi Dan,
>=20
> The code snippet is taken from the aic32x4_component_probe function of th=
e driver in 5.8.
>=20
> Could you have a look at that portion and see if it is the same?

You need to submit code against the current development branch unless
it's a bug fix for the current release branch, sometimes interfaces
change in the development version (as is the case here).

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ivjAACgkQJNaLcl1U
h9CQ/gf9FkJIvq6J4XVKDPV90OV99qJJXv0qTT8vDbnbPc1gmOr8gk0YKkDySlUp
FtXMWsMml5+cOceljQiOBxui/z72Wm26xbqKkMqQ/g0pVus4mB6RwdWnTBWjQIXK
y9bDBT2xPNbGZljajfaJMx3vthAMLxovWtegg6TESFtwAK4dFKjVEjZ1953cx86t
9EuJx0LCGG3ZDLr7jYdNv2JzE0vw+OVMLM0nkp/uPZn35nBV7OXYS0/E8vzvMTU0
817z737RN7XSd5SCh1J2gvEgcovSdJpNG5dqKRUWzOJaKN7VAY3sXcF5GHnj4/yu
Dmg+S1R3McGvbWTsKp9WHC+1dxsFYw==
=mHir
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
