Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E6C3F2C6
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:30:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C1520866
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WlBnu8LP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C1520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1AFE166D;
	Tue,  3 Mar 2020 13:29:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1AFE166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583238614;
	bh=ncleD2LVkf08XfMdy1P5X6wzcBjLnrYmjxBDohThDvA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WlBnu8LP7Nd2USTu3YO4K5uVA+yAUvWEhDznVwCEAsGYq3rSjyypGw1sYvGE/e5/A
	 xnM0hQHs/3FKiSR4dpefLyvAm744EEHbFZpdyvMtFLZJ9mmZuRIV2ghWe6LcGADHhv
	 EGkzHD++RpBKzS9LJcQS9iYuc98Pn7D8FIJ/s7wY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A0D0F80245;
	Tue,  3 Mar 2020 13:29:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0B23F8025F; Tue,  3 Mar 2020 13:29:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 19B04F80131
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 13:29:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19B04F80131
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA31FEC;
 Tue,  3 Mar 2020 04:29:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6B603F534;
 Tue,  3 Mar 2020 04:29:10 -0800 (PST)
Date: Tue, 3 Mar 2020 12:29:09 +0000
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Subject: Re: [PATCH] ASoC: rt1015: modify pre-divider for sysclk
Message-ID: <20200303122909.GA3866@sirena.org.uk>
References: <20200303025913.24499-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20200303025913.24499-1-jack.yu@realtek.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, lgirdwood@gmail.com,
 derek.fang@realtek.com, shumingf@realtek.com, albertwang@realtek.com,
 flove@realtek.com
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


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 10:59:13AM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Modify pre-divider for system clock.

This changelog really doesn't describe what the change does - in what
way is the pre-divider modified and why?

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eTZEACgkQJNaLcl1U
h9B/Mwf/fbbA7utwGf300EYIzySrXmYA9Vep8bLUkr1Rd0rW67slMVGorEZA5Ql0
pPK5C4Jvkigplm2YLq14bNcmmQnMIdga8jlXnrmFbcn3JthXWPO0u7GlxkmWSqYD
j53uNDeTTmy9IoScCjbYiy/ZDaN/e7INnG9bLNMGlshzbkWuqbZjvwhCddv0ml4w
uP/y2PbpdQ+CEX6WH92qsfOzqpprA88Ch8T+mF2DBPrKBn0yHr4Z46OM+/5ci+Xr
IHIuOylLfUUA6vnU/l1jfgJa1mbkM7mewgz8u9ki3tKkOP78qnmk6Rj9Mq01wXhG
a66p2T7/ubJ2HoBctYzRkDSAvqBucg==
=Zl8g
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
