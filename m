Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE7C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:01:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD9121D7E
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uTZ+Kjm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD9121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD9741660;
	Fri, 20 Dec 2019 14:00:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD9741660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576846888;
	bh=K+rgoa8zN4AIQVXlsBMoYQKdArBhlEwuQQyKZH4cDP8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uTZ+Kjm+n/R3oEl8jlKYL/NUBdoP/K8ChUJncfqhnsIK0aYbFGvirIuhTxV2mFbr/
	 RL6DDOgabAYV+GgCYMZmsPPZe5Tn27Q3EgaMTyKDuxbEG/K9mpUMLjop94lO6kTrcQ
	 4vmfnEVXSQ4o7UNrWFHHik0lkBMdTfy4nwqrsTEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5628CF8014C;
	Fri, 20 Dec 2019 14:00:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B69CF8022C; Fri, 20 Dec 2019 14:00:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E209BF80059
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 14:00:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E209BF80059
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D408430E;
 Fri, 20 Dec 2019 05:00:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B4F3F719;
 Fri, 20 Dec 2019 05:00:32 -0800 (PST)
Date: Fri, 20 Dec 2019 13:00:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marex@denx.de>
Message-ID: <20191220130030.GE4790@sirena.org.uk>
References: <20191219213257.366145-1-marex@denx.de>
MIME-Version: 1.0
In-Reply-To: <20191219213257.366145-1-marex@denx.de>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, alsa-devel@alsa-project.org,
 festevam@gmail.com, Igor Opaniuk <igor.opaniuk@toradex.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Fix VDDA and VDDIO
	comparison
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
Content-Type: multipart/mixed; boundary="===============2721814942742187495=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2721814942742187495==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 10:32:57PM +0100, Marek Vasut wrote:

>  #include "sgtl5000.h"
> =20
> +#include "../../../drivers/regulator/internal.h"
> +

This sort of peering inside the internals of the framework is obviously
not OK, please add an interface for this if it's needed.

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38xe4ACgkQJNaLcl1U
h9CnbAf/QhNG7otRihP4TheQyGNOeGGPK6YAS1/FJYJX56rqaxVUUuTfY3Kh+4ez
MMaiODkz1qb7jS0AIjmmBX7/q5ip8Ww4JTd4YyGc8UU7I4fb1MeW4TMwpnGC5wow
50Bkcbe1Y23YDAjqh3+J/BKDHiZcaeNW4p+GlZy2Q2psr5WXmC0D/Bgn43DplpZ+
Rs4DjBFuOvgzC293U+gGvYqDzGfXapKjLacPyX0VvHyd6ZypemgbKmykw0IPSpYo
7N8Pco8kmy6vRJennngwUxMkG5mjrdt6mM3miG6Ws2JwOkAiJExShPFX5q2HU6wr
W8Wv88Zqv5bprM6yNuQt5ScZpHM02g==
=hD8x
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--

--===============2721814942742187495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2721814942742187495==--
