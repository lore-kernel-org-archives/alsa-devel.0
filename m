Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E98C34021
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:31:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9F1207FD
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cIhDf9Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9F1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ACBD1668;
	Mon, 17 Feb 2020 18:31:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ACBD1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581960712;
	bh=8pD9wbFSBkp7BTIGxAmBesZGFgfxJIFLtVppq2gS75s=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIhDf9SeH2eDF5YuR52AopkzOikmI7Er6Ob7c6J3fvwVlWKfktPsJsXht1fAxbvUF
	 Mlz+ukcrnUPmr2M4ahVU6kLu+KP5hf5/ZA1DkOg7lxTAkncq2xa7ohcWZK3MPf7gZ6
	 Ydgra4lTIFqD4z1hwkWkmZYC07nWiodAXKTiSnfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A512F8015E;
	Mon, 17 Feb 2020 18:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02792F801F4; Mon, 17 Feb 2020 18:30:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 95165F8015E
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 18:30:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95165F8015E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC091FB;
 Mon, 17 Feb 2020 09:30:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD893F68F;
 Mon, 17 Feb 2020 09:30:52 -0800 (PST)
Date: Mon, 17 Feb 2020 17:30:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Message-ID: <20200217173050.GT9304@sirena.org.uk>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
 <20200217144120.GA243254@gerhold.net>
 <20200217154301.GN9304@sirena.org.uk>
 <20200217171245.GA881@gerhold.net>
MIME-Version: 1.0
In-Reply-To: <20200217171245.GA881@gerhold.net>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
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
Content-Type: multipart/mixed; boundary="===============2865424825757849846=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2865424825757849846==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Content-Disposition: inline


--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 06:12:45PM +0100, Stephan Gerhold wrote:

> This does the swapping you mentioned, so I guess rtd->dai_link->params
> is only set for the codec2codec case?

Yes, that's the idea.

> From my limited understanding, I would say that a much simpler way to
> implement this would be:
>=20
> But I'm really not familar with the codec2codec case and am unable to
> test it :) What do you think?

I think that looks reasonable from just looking at the e-mail without a
context diff and you should submit a patch so others can test!

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KzckACgkQJNaLcl1U
h9BziAf+Izx20KRsb99onN4hjg2gDkeh3TMcutoOsbRYWWFaMSJOZ9Fq+lHXbuIq
0Qx4gzYh6jMLzvOPDY4BDyzSmcmE/7nAsAhNguMyc936iDrxG/K66Mq7sDX8oL45
YRWofbhaO4GvVtlpz1hxcrLrVVR9B3a2XreUqqmZQM2jLZCwgPtU0xALL/IDEwyb
VL/OCGwh3GfX3DTmsarJCj3tUlwKcvN9QdS5p4KQvH1q18D9O9nd/I0ykSrkbjPt
6wN2fEAxsfbHRoEbfmGZ3kCXVe7pxLRGiCe13e3ea17uv/Z9u95bHgBRIJVNEcSV
MX62HJ6YUZFKc/aAcg2f6BBGnaYpXQ==
=BVkC
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--

--===============2865424825757849846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2865424825757849846==--
