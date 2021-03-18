Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21466C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:23:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDFD64F57
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDFD64F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CC491666;
	Thu, 18 Mar 2021 13:22:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CC491666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616070202;
	bh=YZPjD0grHvb7TpLRHaKuUZjk7mnoKqGU0BsUTBVs2I8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JD7oZqniqcz7D1/NZ+XlP8PXh4MOw2DUi9W26DWgHxqDUwVn8NmI4gaFhAllcOkTn
	 qpcZTt0hojVE5HH4YckRrBysENBabyh4Dptu46nMuVO55wAbt+P9MCwzcG4UUE9A8q
	 BdCI0zOpV7Q1HxV4N4l9bRsHQH4Slu6xoSS+WP3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16733F80163;
	Thu, 18 Mar 2021 13:22:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BB97F80165; Thu, 18 Mar 2021 13:22:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79866F800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 13:22:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79866F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aR997AyW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B4364F40;
 Thu, 18 Mar 2021 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616070142;
 bh=YZPjD0grHvb7TpLRHaKuUZjk7mnoKqGU0BsUTBVs2I8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aR997AyW4gEWNEiXB7OwEsNlHbYxJzqTD34M3EQEIeGLs794jQ7QUW5LD4mZthH6t
 bHTVLm8K4DgsWF5/ifyhStaDPUoUSId9+GIzt68R+1l2weslw2MiFBGqJ6NvcbGdYS
 xtPKfNgYoLN1GNj7QK7p0bnTrq22FjEQuBHrAAbTIql0Z6biTUgTs61HAEN6G0iDej
 ohYAFhfVgQF1A1LyFq7Dv1zFK4XH/p7kwlTVYSgfe86zBCIJb092zyOwwSrLKk9Gjg
 7yWfS6Dl/iBTJy5AZsA8TqYYNQhMvfV1eXMg8YKgo5+54907/bNiTQ79qoK6kaHeoS
 DxcSMfJKVA+SA==
Date: Thu, 18 Mar 2021 12:22:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume
Message-ID: <20210318122219.GB5469@sirena.org.uk>
References: <a35835bae45f4f468dab8ad0df5ece10@realtek.com>
 <20210317140841.GC5559@sirena.org.uk>
 <5f4be33320754b11ad055aa66fc3a217@realtek.com>
 <20210318120856.GA5469@sirena.org.uk>
 <8f0067f5b52240e398537a7118e32f13@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <8f0067f5b52240e398537a7118e32f13@realtek.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 12:19:18PM +0000, Jack Yu wrote:

> > This change is literally just removing some brackets that don't do anything, the
> > regmap API has no impact here.

> Sorry, I misunderstand your reply, and yes, this modification just remove some brackets.
> Should I send it with separate patch?

Yes, sure.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTRfoACgkQJNaLcl1U
h9DyJAf+IhGAkV0Ds2d51NkLs9lbYhthWtkafWyLeiBTZGJgZuvGvfiNZlrmPKKy
XtI6X0w5i+2Y0RmeAkuPGHXdnz3yuEYg7naLwHSmmh2rXaSa7L6JVU2IGzy6cND0
oab/RnNrDMyq3WK0c5IZQZn9irnJz+4S9xEHnCW9dIB39yl2+LHkRgKvK4AcvQM/
ScSwhsKQ9IFhd90vi88rv47BQ+pjnkX9zULIgq8q79U3h3Q3v+h1rB52bcIwkpPz
Bn8nZQF1KjjhpIg26Wnh5HetfGAXm152e3XVQYunI1wocM8uML1tABxgs8gphoGu
Z3lltcev/XqwDyZsnb1fNvX2zxAbiQ==
=dWYG
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
