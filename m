Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72503C4332E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:42:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F291A20714
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QrfDL9H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F291A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 293B715F9;
	Mon, 23 Mar 2020 20:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 293B715F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584992566;
	bh=giVVrVwIBrqFHkZkg96NXozODduLdI6KHgCv+qVIUw8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QrfDL9H61dzAW8VdKULROqx5a+h4osUxAkErFvnc01fDhpjHH87Hjx5uLwuTY0VWy
	 NfDCLwnmZI+iQfZgoPI9xRO98l+zYNbAl1CpA3kIw+cXGlIpzErbfzBlGZBzP3Naox
	 kxMVBCOxGoNoiOPsu0uqJY3dnvU/kUjZIwME9VX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A362BF800F6;
	Mon, 23 Mar 2020 20:41:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1A5DF80158; Mon, 23 Mar 2020 20:41:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1DB3CF800B9
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2020 20:41:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DB3CF800B9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0BB431B;
 Mon, 23 Mar 2020 12:41:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53D313F52E;
 Mon, 23 Mar 2020 12:41:44 -0700 (PDT)
Date: Mon, 23 Mar 2020 19:41:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: sysfs: show components string
Message-ID: <20200323194142.GH4948@sirena.org.uk>
References: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cfJ13FhsvNR/yOpm"
Content-Disposition: inline
In-Reply-To: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
X-Cookie: Stay on the trail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


--cfJ13FhsvNR/yOpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 02:36:23PM -0500, Pierre-Louis Bossart wrote:
> Add attribute and show the components string. This is useful to see
> what is provided to userspace and e.g. used by UCM to understand the
> card configuration:
>=20
> root@plb:~# more /sys/class/sound/card0/components
> HDA:8086280b,80860101,00100000 cfg-spk:2 hs:rt711 spk:rt1308 mic:rt715

Sysfs is supposed to be one value per file so this should be a directory
with a file for each component I guess.

--cfJ13FhsvNR/yOpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl55EPYACgkQJNaLcl1U
h9Aadwf/VB8e7pY9IQcnvpoBkvU1FqK2rQO0LWm2cTwAL1Vn6o19tVw4J+ZuX0Ut
xPfs5WQZv6uMMoHJn92IB/6oIOmQCI4zE8ggaA9OWLfz0GNC83mRC6uqBsqdzjIG
nyzxQ0kR7UfyPukll2UtaWMHnsCGB45nVnOtyg0yMta6UrQmIj5HK+XSiSYSg1+A
VRAVqrv2PZ4gooOHqKz34tYq/pDTci4Mi6xKPDPhtvqbGDI+BUgQGtt430hFnjq6
mLYpYo8IRy6xR9jpy/is+kEM3aPSMVPOX8rR6mguJgMkc1vv2+mhzDttci+oSWCX
qYxlG3Qw89OrcfybcIgIfDWzvk/Xnw==
=XskA
-----END PGP SIGNATURE-----

--cfJ13FhsvNR/yOpm--
