Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD7606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=XLk6lJOw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S21CMEXt
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4493E601F9;
	Fri,  6 Nov 2026 14:28:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4493E601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793971705;
	bh=y0xUCAp8a/zPC/9PhSCA0RilO7FnCVSqrcm6vXrGEME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XLk6lJOwWhmKuYFij0XLTULPVq2RFuyGni/x+qSl65i+bn0Br05QOT/m2447WuqXr
	 n4Ml/SX8CJjIwbYE9TOO4Y7mXNzHAFeeqilopFU1B1S4yFMtjEBVZhB3x9E36OLztq
	 PPb5j0kfJ+8PWce6eqwwQjwjelfXyFUXEKOHOhi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C191F805F6; Fri,  6 Nov 2026 14:27:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65E84F805EE;
	Fri,  6 Nov 2026 14:27:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B0AEF80510; Fri,  6 Nov 2026 14:27:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793971660;
	b=bCSJm0Bl3KwdOSTCed74jBukfSTmfythZhddl4dO8Nhm0DZBVnM1jqs/h/SB0qh5CBjd
	 /+fAspJ4tN+MZHr1ohj/+YjGUnUFeWntQItuUvkpXx6sh8EY1nwMTqilmQYkYQmBWAjYg
	 11gzXQuCtJ8en2jSl2cO1BX8fIwWvehmICCeKaEO56EPDo28g/gVTWeOGZaeHrmHiW49J
	 pnRokSTG+gj3G6MHt+yoIKcr8LIj3BnCG/J58fF6QtNhjoSe2weQybD/G3trcnQ8aDpeN
	 BlD0Jgnmt4+KYTFyEvDqMlVY/dop702LDsl18EGlmMFT9eIGck7ws0gMnyZLQRAjy3A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793971660;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=y0xUCAp8a/zPC/9PhSCA0RilO7FnCVSqrcm6vXrGEME=;
	b=cUysjpd6DziWRemHpMk4ToROlgVG8sB9YM1ugfumYAYi993klzVfLMCvQHSRxWWcavi8
	 z8tyoP98fDN0FCpPIqV4rnWI8yePyfiWQJ4bJCpL8Qd9lHPg1k3f+Faom0ww7IJSDPfRx
	 vNsLQKR/bpLZ7qq6OO0M5EUMQPLq4nwpNayZbzEDAqn6L/m/MiwdW+xUUbxhUCKlXODgo
	 T/ySoaNxGoh2YCgxEiUgEAjmCT7Cf/RNaofC2B30Gv4s7WYfaqH9zNo4CCEL6cRqM33nh
	 TX/qBqSqyC0gie8AC2MbBrnU0f6A9D1UH6mwgZdVRi+BQyuMq2nbpMfhhTskXmJE/7w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S21CMEXt;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 65F0BF80124
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 14:27:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65F0BF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S21CMEXt
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18760404A1;
	Fri,  6 Nov 2026 13:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6821F0089F;
	Fri,  6 Nov 2026 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971656;
	bh=PN4awULBFGC9ZH9QdrdiAMHRKAA3lcCqKfgTxlypFXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S21CMEXt81WIvcIKyPoFfFmTRFa8ir9+MiOyQJOzj373HqU34J0Rl6QtMlJIkRoJv
	 qotoYFJKBQu5vOGm6DJ+obJGWRe16YpitShaijeWSzn9LrKYQnyD9hfNKt2gFayC6x
	 FwS1rNBTIdFOmBF6997HjpxIYtzqps2akAzNmq4Ct2AZXyMdKtWbjgHkQQwVMQPFP4
	 jmaFS8v1YBpU6xaByvC2y+0OmtNnClfpFgdNGZQf3L7d6enLhZ9GJgpeSZLHyUPcSn
	 4BzrcO64jjV9H0CRZpWkOMC7wVgq2hfsqI1S1/U66B5daxi6wC0ZVchbSIOOHgaz17
	 oVLYUJqfZIGTQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 7187528078CB; Fri, 06 Nov 2026 13:27:32 +0000 (GMT)
Date: Fri, 6 Nov 2026 13:27:32 +0000
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: pierre-louis.bossart@linux.dev, Basavaraj.Hiregoudar@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com,
	Sunil-kumar.Dommati@amd.com, Syed.SabaKareem@amd.com,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, venkataprasad.potturu@amd.com
Subject: Re: [PATCH 0/2] ASoC: amd: acp: supplement patches for ACP7.B/7.F
 SoundWire machine driver series
Message-ID: <8d5dfce0-a916-481e-969c-f106f1571084@sirena.org.uk>
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
 <1a75c8e5-975b-4225-9e25-5b6b1148fb50@sirena.org.uk>
 <2d887588-cda6-42a9-bf0b-890b89826b57@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hmGdR5RgUZctl1XF"
Content-Disposition: inline
In-Reply-To: <2d887588-cda6-42a9-bf0b-890b89826b57@amd.com>
X-Cookie: Whoever dies with the most toys wins.
Message-ID-Hash: 6XVGXWQADOBK6KIZL3OTWRF3PK2QUCAL
X-Message-ID-Hash: 6XVGXWQADOBK6KIZL3OTWRF3PK2QUCAL
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6XVGXWQADOBK6KIZL3OTWRF3PK2QUCAL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


--hmGdR5RgUZctl1XF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 06:21:23PM +0530, Mukunda,Vijendar wrote:
> On 06/11/26 17:54, Mark Brown wrote:

> > This has really confused my tooling :(

> Understood, and apologies for the confusion.
> Since the original series is still under review, I sent the supplemental
> patch as a reply to it instead of starting a separate series with a
> dependency.
> Going forward, I will post such changes as a new series and clearly
> mention any dependencies.

If you want to add something to an existing series post a new version of
it.  It is not sustainable to manage a mess of interdependencies between
in flight serieses.

--hmGdR5RgUZctl1XF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau3VxAAKCRAv73Ows9A4
iZ2CAP46NBtxfL8hCUZOKrEQw42Agi0JhojneAcIGHLfbLMoNQEAjPbfv054xjHa
j4XKJRgXWFK4ZtAvOFovFUf9WZJWgQU=
=hmy3
-----END PGP SIGNATURE-----

--hmGdR5RgUZctl1XF--
