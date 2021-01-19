Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE3C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 12:48:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D478D23131
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 12:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D478D23131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F9E11887;
	Tue, 19 Jan 2021 13:47:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F9E11887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611060496;
	bh=8Ah52Cuzti0B+UylBIEezPwyNqnDHo0S16N3eYVNIHI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxQq6muakNoKThwdCyvlIOCUcrLH11PrrdCWxBaCgW7wLbYH0TuUx+N9HBvyghhu1
	 fxctETTJgT2Xux9wQoZ6mpNnkxohDElfJ7RTAGMd6RuL9cgltetNPAbA+6yZ8KNI6H
	 jQHYsT9BRXQKKJ3XAMeT1OdrJVadEGTrhJywDC6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9DD0F80255;
	Tue, 19 Jan 2021 13:47:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BAFFF80257; Tue, 19 Jan 2021 13:47:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15587F80117
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 13:47:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15587F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ki3cfVCQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87BD223131;
 Tue, 19 Jan 2021 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611060433;
 bh=8Ah52Cuzti0B+UylBIEezPwyNqnDHo0S16N3eYVNIHI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ki3cfVCQNI0Go0tv7XAnJD+2giN7Uhb21gzmV+NRW/mzaIsA0BQBt0Mhc4adKJ33C
 OOV//Q4Klf5MdfEpwSUBXkAtYIIxtGQArdOqbUG0KLnmRH6XJCiyC1l9WNUMfd8qoZ
 aOOThBzn47JFwGUF9VX1fR54mDtTETi2JKJMiVQyPeKcDQAjzrW4YPzQVujdPZL+gh
 DJelsApK4Lmf905bl4EU5nahXvMNwFnLN3nzpz1gvPiVXULBAQvNRVVWGbzWTqswQo
 QVIV+sYyb4PtMqWt1wCCD+hI+1JZ7hHKCd2V9zwyl5HectDg5S/OY0CGSTsV9dSmR1
 LFIobSGavOyzw==
Date: Tue, 19 Jan 2021 12:46:35 +0000
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Subject: Re: [PATCH] ASoC: rt5682: remove LDO2 power supply widget
Message-ID: <20210119124635.GA4478@sirena.org.uk>
References: <20210119091158.12988-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20210119091158.12988-1-shumingf@realtek.com>
X-Cookie: Yow!  Am I in Milwaukee?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com,
 derek.fang@realtek.com, flove@realtek.com
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


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2021 at 05:11:58PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> The application circuit shall provide MICVDD power.
> Hence, the codec driver doesn't need to enable LDO2.
> This patch also reduces power consumption while the recording from the he=
adset.

This sounds very board specific - shouldn't this be something configured
by the platform?  Having a default that doesn't use the LDO is fine but
some platforms could reasonably use the LDO that's there.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAG1KYACgkQJNaLcl1U
h9D4SAf+Op5FMd0Dv1VRHIZnlSrndbElkGtv3zB76b0Pb65zxllTkcdgPY+WrirH
YyumPjDi0klZrWbQgll1A26TbKYyh2IjFaZANflNi6tTR5Ig4oDS/tqzn4rBIxwV
rUVDVmdzLnA+xP5S+K3wscavGY7p4YabFf4q6+h0inwE8WhHXi3V4ClCye3o8RS+
FF/+IzVb7Q6hdjH1YsLpv4hvavPRaLN9VzzTw8sSwqlfO1bd5jWwspUWirfZ0s7K
nv7gpOwPjVU0GavCz730RLkUiddcGCE2T5L1sWUQdK5KN8V6kSnx8bp70Lfq8+12
K9npvNiBbYOr6rVcawb7pcRCth7ytw==
=MniT
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
