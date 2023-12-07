Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1875C4167B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Dec 2023 18:29:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 618B483A;
	Thu,  7 Dec 2023 19:29:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 618B483A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701973769;
	bh=oUtjZ+VCwu0p6Zdm0+PMZHE5os+JzirK45maCcLFLZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eZ/3BSVTOXqhKbF0M7eBvvE5oQlGjEwR4aa5obq0dmGUE6N4XoDyyBItfCu3+kFlX
	 QhM8cfoM7/QeFPh6XJm0jvA+5/pz6+nyHrwTPimEE/Hs2BFXyQdukqLc9azjoYZXJ6
	 P8VPOSH0tIsnSP4TPXeys6mWE8N9xXCgy+vSy6SQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36D85F80570; Thu,  7 Dec 2023 19:28:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 192CAF80580;
	Thu,  7 Dec 2023 19:28:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69264F8024E; Thu,  7 Dec 2023 19:28:40 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ED5AFF800AC
	for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2023 19:28:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED5AFF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G41HUC1k
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 186F3B829BE;
	Thu,  7 Dec 2023 18:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F0CC433C7;
	Thu,  7 Dec 2023 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973712;
	bh=oUtjZ+VCwu0p6Zdm0+PMZHE5os+JzirK45maCcLFLZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G41HUC1kewwWxdmisy1k+mtURaptTgqBN3Ot5SqLNnSxHulnqvYUQ8hrMoZC3Gj+C
	 bdOrzxYlaYRd2DhcPRBis+su/vydwNbNU1uNX40OSt2W0Gby3b0UZ0hQcmK8MYbVea
	 isD9GxQEpcWW6+XJkRe57pNziM8KzouUAJRDzrjTh3qxajLv/Y3cm4waUAYboP19O4
	 dc1HxrnBESGdJD5nbynnOQvbGH9geK6/rILKW5cHF1BVehqGWk5OZMh4je8gTkm9hb
	 kFclZCtMB4G5cvWfsTixd9YnZWj3W+AdB9uRl6+PZI8WgVGziEpBAXRJF/nRC8JGbR
	 gB215Dmnno5pg==
Date: Thu, 7 Dec 2023 18:28:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 11/16] ASoC: tas2781: use 0 as default prog/conf index
Message-ID: <a07270d1-ef63-4558-83aa-223b97b1a93e@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <88229933b7aaf0777cbe611979712e4e144b1ca1.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mtri/UqkWBaX0XWB"
Content-Disposition: inline
In-Reply-To: 
 <88229933b7aaf0777cbe611979712e4e144b1ca1.1701906455.git.soyer@irl.hu>
X-Cookie: Two is company, three is an orgy.
Message-ID-Hash: DG6XJ3DWXDIWRRGPUWJCMTLCSQFNZD25
X-Message-ID-Hash: DG6XJ3DWXDIWRRGPUWJCMTLCSQFNZD25
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DG6XJ3DWXDIWRRGPUWJCMTLCSQFNZD25/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Mtri/UqkWBaX0XWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 01:04:27AM +0100, Gergo Koteles wrote:

> Invalid indexes are not the best default values.

I'm guessing this is just fallout from the previous (not really
explained patch)?  Is there perhaps some bootstrapping issue here with
ensuring that the program and configuration get written to the device if
the user doesn't explicitly select something in a control?

--Mtri/UqkWBaX0XWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyDsoACgkQJNaLcl1U
h9DGpQf/TQARSIEymiOBOzo5cGEpx/8ZwokjtMX7jsnFlo7PvAc6gfo8VM9mxveo
50R+n3iX5Pmcyf+MAXLcFVDfW/+8lHTiGV0X/KZUBoh76QUk1y3Pwfc+xPylhknp
rxtIAOu+D7ViODrLm00ODKFfVnb69+fpMaZEmfsmQJHsZByc5UU7m1gk9i7IxhDg
UXJrBimr02zmiF4AWdyzUVP3rJPCqld6ciVFHwgB3uoA4+LnNEfgjiIbnb1Y/ip1
qwNmUJpIDEa0exen/Vp95H7fdBKM5wV2H2ivj5D4H4He0FlTS+zEjd6C/+eSY3cA
GCUzFTelOBOyxOEre7TNzJbXivrxzA==
=45un
-----END PGP SIGNATURE-----

--Mtri/UqkWBaX0XWB--
