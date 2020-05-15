Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EFC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 09:48:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2451B206F1
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 09:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="foKpZmbv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge25+p99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2451B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E68E165E;
	Fri, 15 May 2020 11:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E68E165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589536136;
	bh=8pPGrRF3erkbNAvGiN6j9HqDfRUSmvgwEkTBG8urASk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=foKpZmbvGm+RiyM8QuTPzOJgjotO9JEBONSa/vJJY7KFDab8wxGgqwcDxvE8jhs6b
	 aEdtNFABHRA4YL7Og51RjKHvHAYYHnj2ZRsvv1a51cWr7YFLk0CMIaM+7OMrRzJEjs
	 RwmmZ/AltNQo3CthR6ZeQzHQQ9KBV953egwVl1Zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF58CF80101;
	Fri, 15 May 2020 11:48:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1849AF80247; Fri, 15 May 2020 11:48:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A656F80101
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 11:48:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A656F80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ge25+p99"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33C5E206B6;
 Fri, 15 May 2020 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589536077;
 bh=8pPGrRF3erkbNAvGiN6j9HqDfRUSmvgwEkTBG8urASk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ge25+p99snEMmxUVLucRK3+NmXQVHrUhMPQLHefOkjE+ke7aMFu/+W+8rqyzdiosG
 ZdYGyqG+MumYwz6TmMO86bvFAI3ilUQMUWPoNusD1gSEdqlF9hSumjD0ijrI9VCSYt
 lRQ29f4nbZ5G/FgWnSEZtzStEeeyJX7TuqkyYooY=
Date: Fri, 15 May 2020 10:47:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] SoC: cros_ec_codec: switch to library API for SHA-256
Message-ID: <20200515094754.GA5066@sirena.org.uk>
References: <20200514161847.6240-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20200514161847.6240-1-ardb@kernel.org>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2020 at 06:18:47PM +0200, Ard Biesheuvel wrote:
> The CrOS EC codec driver uses SHA-256 explicitly, and not in a
> performance critical manner, so there is really no point in using
> the dynamic SHASH crypto API here. Let's switch to the library API
> instead.

This doesn't apply against current code (it collides with Arnd's patch
to reduce the stack usage), please check and resend.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+ZUcACgkQJNaLcl1U
h9Ckwwf/f+u+81oeU+jbFmuT90T/E0rnmeAtPBpBUOLh2DHYrCK5JEDbGII3RCpa
mj01eC7JlM+4JCoFt08cn+EYpr5HinY8FRyRnfkY/+CuSlzxA4d5PsepzxGeXuab
9jBAjtcD80EYO5YrtvCoUki2h4M4E1XMH1wXDHBs+xgsexg04QD8M2oEJt0JuUVa
2l1IJLjD20UE9wEpwAFvap1xIgbSNzAOPB5No5TpXtv0zFW/oC5NYDnugmVkYnPC
FGIMhHP1Vmdx3lytK2zm/WdpOodBXVLcxY7DaXgdQLDKhDabQflqy17HN4aM+TgH
LezU9Y3luSquI8Sj0idnWBDekxTvfw==
=nolv
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
