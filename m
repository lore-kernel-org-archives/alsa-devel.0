Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5581FC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:49:30 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCE820842
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MuT770+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 310CD15E2;
	Tue, 11 Feb 2020 12:48:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 310CD15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581421768;
	bh=/q69l4ca8n2aFMgeID6i+V5kJTWrkQyz/jRlpz05hx0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuT770+/6x8euNHJUS/abUOsZ1/raQBnWnVeCVqy6YQKwiwHsJt+YmNynQfrq9LyS
	 7V0FCBaAUANmmxdXUNlJKv8I9391vgv7ri0rdfmmoJS3DZyCwnRUTIX6L4o0as/Xx6
	 Z5hvn4KHDUlAzbR+4XReVTpcgQog1Y0rHZyBX+QM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD3C0F8013D;
	Tue, 11 Feb 2020 12:48:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC616F80145; Tue, 11 Feb 2020 12:48:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 63A0FF8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 12:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63A0FF8013D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 584E3FEC;
 Tue, 11 Feb 2020 03:48:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16433F6CF;
 Tue, 11 Feb 2020 03:48:30 -0800 (PST)
Date: Tue, 11 Feb 2020 11:48:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Message-ID: <20200211114829.GE4543@sirena.org.uk>
References: <d4cf3eab72104431967087898b0e07a2@realtek.com>
MIME-Version: 1.0
In-Reply-To: <d4cf3eab72104431967087898b0e07a2@realtek.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Albert Chen <albertchen@realtek.com>, "Liao, Bard" <bard.liao@intel.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rl6231: Add new supports on
	rl6231
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
Content-Type: multipart/mixed; boundary="===============5062880224564528421=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5062880224564528421==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 10:35:07AM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:
> 1. Increases the max limit of PLL input frequency
>    on RL6231 shared support.
> 2. Add a new pll preset map.
> ---

You're missing a Signed-off-by here, please see submitting-patches.rst.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ClIwACgkQJNaLcl1U
h9DkOgf+ICDZBNErtbJ6QTX00RY3uaBlVNQSmcGSDF08vH1qx/yHeSITquZW+2Hu
MK0yepntXbMLklt2qC3HY+tDYjAC0FsdvTWMHVIWbuCz3NYUKQqX8NBNu1ptYbah
gNXE+/ZNJ8u3os4IOWkVUqIX+E+sfGC7ClqwYlLhT09FvpjZuMbhHLDOXtaA9s+4
grhAEZg6EtWgyy9NTRpnmkJtQAGubea7hXKry40iksJ6PazzIPhYZ1vJabdEq7A/
L7SOa0Y5VLcEkGQQCREkx3YNTTyt3iw2Nsl4nbI64yVNoQv2pQs2HjQN3qo6z2Pn
+aVJnEdn94gXeaDgbv5g6JMpaaNr6Q==
=f6JA
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--

--===============5062880224564528421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5062880224564528421==--
