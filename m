Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B284C3DA42
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:29:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1330A86E;
	Mon,  8 Jul 2024 17:29:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1330A86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720452582;
	bh=fGNrG710KVQF9G4461uY3S5esz47alZUo9ZD7VmRx1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=W+way1pq82l0Y/I0BjQTdF8xFaENbocLbypPGjwORS3muSlXV6R7CRRgNzgsJZqs3
	 8XCuWhnmekWttRUn8J10HiJE13nhWFjR63/Iwsqj8HsG2H0QpMPcLUuRP3LAhdIk+2
	 eqDZW5jEjfcoV30oxQphnUwGGug2Be+Zcgf7QQBI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 693F0F804FC; Mon,  8 Jul 2024 17:29:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4B51F805B5;
	Mon,  8 Jul 2024 17:29:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27531F801F5; Mon,  8 Jul 2024 17:29:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2929BF80074
	for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2024 17:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2929BF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NHv8q685
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD2A460E2C;
	Mon,  8 Jul 2024 15:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F53C116B1;
	Mon,  8 Jul 2024 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452534;
	bh=fGNrG710KVQF9G4461uY3S5esz47alZUo9ZD7VmRx1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHv8q685WKRhC5W483Xt1LsJAVW37UKg5XgU+g+ePd2Bx2J1Te3H8iDDICzUZc1W7
	 +F1SWzeEJz2P476mWOb2gbe6Vz+cWIimerXuNIHLa4pruFSHrVerasWHCdpfroA6/H
	 CCWUhWHQs2ULCcLFeY/0GINwCuhv3LR2tYQDhGuso4TfQkC+4tr2GLDCGy3J/ow3Z9
	 wisn11YY63nAZJzG4mCVkcPMd4lLOxffTZeGRHN00ReLYTCCBXUIIoLtFdoUr4wOF7
	 b0rbrfL50qADd83cMXVeW5ByM4YvK6gIWGjbfiqU5rEwbAT99g1KFXDUT1st93Qc9l
	 /7d5EeBQoSagQ==
Date: Mon, 8 Jul 2024 16:28:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1
 wmfw files
Message-ID: <cee81a44-f51c-4abf-81a1-36c40eff452d@sirena.org.uk>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
 <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
 <91fc7cb3-6a00-4b3b-abed-a3a41b191912@sirena.org.uk>
 <27d74268-53ff-4248-8d3d-71948ffcf68b@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/a5qg2alAm4FAP1y"
Content-Disposition: inline
In-Reply-To: <27d74268-53ff-4248-8d3d-71948ffcf68b@opensource.cirrus.com>
X-Cookie: Many are cold, but few are frozen.
Message-ID-Hash: GB6UYOZMDZ46UPLZSR52P23NYTIYGWRJ
X-Message-ID-Hash: GB6UYOZMDZ46UPLZSR52P23NYTIYGWRJ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GB6UYOZMDZ46UPLZSR52P23NYTIYGWRJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--/a5qg2alAm4FAP1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 04:22:46PM +0100, Richard Fitzgerald wrote:
> On 08/07/2024 16:05, Mark Brown wrote:

> > git seemed to be able to figure out the context for 6.10 (I apply
> > everything with am -3).

> Oh, I read this just after I'd sent a V2. You can ignore my V2 if you've
> got it to apply (it's the same patch but with a couple of conflicting
> lines dropped from the context)

Yeah, no worries - git seemed to cope fine.

--/a5qg2alAm4FAP1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaMBbEACgkQJNaLcl1U
h9C0Fwf+I/ECA8qGlN2zBdk7W5C2CSGXpLEvJ/bHyB1CiL23NmykqK7pDqisuk/3
cbofSsQr66D2Zff8N4iJXtPawyHDuWPeDnY7PfuZp2Pz9pbYwJe3Y2N3s9qadS3V
tRSW2SpYUMCXkDplwj/YjGPtRnVE3EiI3xC2tQYvOrla94hDMLzFj7HmDZ9axU8R
Lqy6v9y1c7LTeKRuhKM/qU9VVBWq9PNTy/qYyxWFfgpg5syff1XZeLihnVn7knEc
xkS+oit7Ft+hPLx6i0hJzVrBmr8TnUUZRXwmbNyVySUt280vTcItEoNWAcr0pXP6
6iK7TB/5jqIx9vGmE3zlTp93equmag==
=VA25
-----END PGP SIGNATURE-----

--/a5qg2alAm4FAP1y--
