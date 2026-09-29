Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8290CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:47:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A086601EF;
	Tue, 29 Sep 2026 19:47:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A086601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790704061;
	bh=qRE9FLRZv6t9Gg2if/1SH8ToijSGWRaqd6AqIf9l8xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=c8lETUKiPTMModkHKHMFh+NDKPgYWzXUsywrUWzb9DPEzapsmSc048BrFHyb7voDu
	 mVng4ZmPMRrYbIG1FXEeh5zpBMZoyFt7K2nK+qhD717YByG/+EsiUt6sDWz7o0nSo9
	 1Y2/5VJmOHx1i59bUlqMfKTjypEYq5vsUd5cdIE0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C8EDF805F4; Tue, 29 Sep 2026 19:47:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB9ABF80602;
	Tue, 29 Sep 2026 19:47:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B427DF8055C; Tue, 29 Sep 2026 19:47:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790704021;
	b=iiWCnxwMxoiSvyndjgzQIjispu78cMW39Op7XJ2y1IrHKUJtXf74yhW8UIw04r18mPo+
	 MjkG/JdTF9YZO91P0javQzSK/D8OR8ws2v7oF6urrQtbPlMWZNgn2PcJbkn9Xhk3Va4bU
	 nIGs/4GaGKs0etx9j4/Q1DmgUy9JGB1oEz3EpnyFIPM150Gg1nJnAAWa8rTeKlsADtuda
	 ePXjeFOvAOE2A+6FxA5MwdXymJqX+rlJt7PTkjbdkrveH7hAjSisJGzeiPGWUEBD62YL3
	 kZe7pmrRjBUPWbIOQ1RGak5gXnbTdWcW5US5G4lk5mapmZkUaNx7lITVLIWbt3qPHag==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790704021;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=qRE9FLRZv6t9Gg2if/1SH8ToijSGWRaqd6AqIf9l8xE=;
	b=Ud4T/jKKZQwrUCX6xuEiO5ZTEnoZyDxXUCePFC+v0sOJ8p8oOWUfv0usg0COfaELvkQv
	 +JKjYCj1Z53PycCRjizLYgsZHJnBrwzvMtpDnukbyx6jJCVo+Q+gWKPioXQ65kbzXUHG9
	 DW84fYCazEmJnnw7Gf3TdEWfWDwHs66kx8KmZjmovV9HRX1PfGQLC7Y2bn298m2r+/weM
	 WhR6qU7VR+AaFxHPTpOrf9w42/AEPA/eXD1hfa3fDV8YhZmXdlG3zrh8hPP0UO5d0uHTm
	 DpAd/WdBbroJxfdA14MYb85q2R1LuVyraJ/aXfEj8uUzlBMUIKsuGjAy+wX4LUTPrvQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WaLOxEBw;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80696F8025A
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 19:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80696F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WaLOxEBw
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9449C6022B;
	Tue, 29 Sep 2026 17:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC331F000FF;
	Tue, 29 Sep 2026 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704017;
	bh=8JuSY4TBNaMMaGAbno4p7qnN8hZwTlvnqnM/r7z+//I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WaLOxEBw6iPFvWIKZyYDfCs+Fd0DcDMet5QM59y3R46NKYqu0sPhNVqLteQh0bnol
	 vGKwKINxT/GP32jbO/398g7xyMVj19plm6So/e434PBL7GZq1Thp8WZx4iUjlSV530
	 Zr4MCs69S8mW5kCiNGN6+XN2bkNVA3akA0h0UmpbJdRMpxBeub1V4nZ1FcZ1gm1P5G
	 LugRtgayAMFyliTXOXguqt0+MbVbNzUF+J06Mw2yUgEZGXayVaZSJF8AvgzQUXSClp
	 E78dG1xlE4OARsGpFxYRPix84KtzkEIKeeUVoye4/sSsSvpyEYm+aaV5MI2Og/jElX
	 bCKnc7xd6mUNQ==
Date: Tue, 29 Sep 2026 18:46:52 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt721-sdca: Adjust blindwrite flow to fix type
 detection issue
Message-ID: <caf34e12-fcea-4814-abac-26674988bc0e@sirena.org.uk>
References: <20260929111709.398548-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FKFA8P+4WCVPjKa"
Content-Disposition: inline
In-Reply-To: <20260929111709.398548-1-jack.yu@realtek.com>
X-Cookie: 1 bulls, 3 cows.
Message-ID-Hash: GBOPR4OTJDQ6WQT63XULUVFC5OAU3FKF
X-Message-ID-Hash: GBOPR4OTJDQ6WQT63XULUVFC5OAU3FKF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GBOPR4OTJDQ6WQT63XULUVFC5OAU3FKF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--0FKFA8P+4WCVPjKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 07:17:09PM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Original blindwrite flow fail to support nokia type detection,
> but it's works normally in iphone type detection.
> We adjust the register settings to support both type detection.

>  static const struct reg_default rt721_sdca_mbq_defaults[] =3D {
> +	{ 0x0900006, 0xe000 },
>  	{ 0x0900007, 0xc004 },
> +	{ 0x0910000, 0x00a1 },
> +	{ 0x0910001, 0x1256 },
> +	{ 0x0910002, 0x0000 },
> +	{ 0x0910003, 0x0000 },
> +	{ 0x0c00005, 0xf140 },

Is that register volatile?

>  static void rt721_sdca_jack_detect_handler(struct work_struct *work)
>  {

> +		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
> +			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
> +			real_JD =3D=3D 0x1 && rt721->int_cnt =3D=3D 0 &&
> +			!rt721->imp_sensing_done && rt721->jack_type !=3D 0) {
> +			dev_info(&rt721->slave->dev,
> +				"%s: resume with jack present, reuse jack_type=3D%d\n",
> +				__func__, rt721->jack_type);

Does this do the right thing if the thing plugged into the jack changes
over suspend (eg, close their laptop, unplug their headset, go home, plug
in their headphones, open their laptop)?

> +		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
> +			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
> +			rt721->int_cnt =3D=3D 0 && real_JD =3D=3D 0x1 &&
> +			!rt721->imp_sensing_done) {
> +			dev_info(&rt721->slave->dev,
> +				"%s: BRANCH impedance_sensing (SDCA_0 set, fresh pass)\n",
> +				__func__);
> +			rt721->imp_sensing_done =3D true;
> +			rt721_impedance_sensing(rt721);
> +			rt721->imp_sensing_ongoing =3D false;
> +			return;

Does rt721_sdca_btn_check_handler() also need updates to reset all the
state on removal?

--0FKFA8P+4WCVPjKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq7+YsACgkQJNaLcl1U
h9A/Ywf/YUw4tG6tOf+BJhH8tmBbb2Udb0D6ymHrYjXhZ5/5KYQcPMAX1ZhzZA0J
gM59PRYWmVa6WWW8F2bLCZ2ytJGpCeTJSASTusXKVUW1J77YlYie9dBgXzBXXlBh
jljvS1MyOTDk9wDWOckRpuvsWJvaM1BN3h4w8a+WKr2C4/Gpgd1nQOXeihZwWdca
74VNpIAi7x+8M0fbeuxGTkrrNj1YwpMb5ktFOgXNS30o/wSK+ob+MXTMrrvgynO1
3FTbPfc34LcY2jRQnuTJnbVTcrUWSJx6JznJWTtGqdcdpgsVaHQ9FzWqnaGCR8Nw
NTE+z1RsiK47SkN+OUDucfzzBxiGYA==
=RZ2G
-----END PGP SIGNATURE-----

--0FKFA8P+4WCVPjKa--
