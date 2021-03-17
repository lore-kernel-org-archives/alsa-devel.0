Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C04C433E6
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 14:09:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBBE64F8F
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 14:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBBE64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82C8C18AB;
	Wed, 17 Mar 2021 15:09:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82C8C18AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615990191;
	bh=PgZFY2/HyaTuLCJjmIh2aGC+HzTLjV+FcBUmoQhkcXw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ivji4Cb2DE1GdZuxQenpuiDylaX38Vsl/sGhxDLZjqGB/50Jdgcq9ASrh8DMiDYoa
	 Cnojbx/s9T0CeX2CTD3KRUIoZiFaIPUVGu/pj+dym/V0Y5aZgNNkkcL3t1hjucvaJ5
	 div1SiB6iz9l8BnlbqBVdjzr2+pspbzyBjZFsdDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA2B0F801F7;
	Wed, 17 Mar 2021 15:09:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A6A8F8021C; Wed, 17 Mar 2021 15:09:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 330EFF8013F
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 15:08:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 330EFF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IEk7R2vy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 960F864F5E;
 Wed, 17 Mar 2021 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615990125;
 bh=PgZFY2/HyaTuLCJjmIh2aGC+HzTLjV+FcBUmoQhkcXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IEk7R2vyfUU/4NjnRBluTdqoNFd25HXaKvvWXQ/iG7b3dZzwZ/72+rky7SvRgEniN
 3nMccBNbCBq2mrZ1Sj7sXSo/J1BaeepXi7h6qgxR+IjNoJRPHTnjhj5yrGYKkDDidc
 YgQM1fwWjTFD63xOGk5KHSMM3461haXQB5lakJW10x1lI0BaD/xzpLBU3tzkGUURqr
 Wu41juoqKDl3BZTV+xEj7ofdAerHOpPs+NcLqm/5HZmb4FU1T+QwAXcKo+K52EiexZ
 FTAU6aNduqqnuuKwtQFedy/DMphCl0PL1jIi/6bOuAg7wE8gsFwgMY7dzxqhWRXbnQ
 nmhzuv30wUfQA==
Date: Wed, 17 Mar 2021 14:08:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt715: add main capture switch and main capture
 volume
Message-ID: <20210317140841.GC5559@sirena.org.uk>
References: <a35835bae45f4f468dab8ad0df5ece10@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <a35835bae45f4f468dab8ad0df5ece10@realtek.com>
X-Cookie: Please ignore previous fortune.
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 03:16:53AM +0000, Jack Yu wrote:

> @@ -57,14 +57,14 @@ static void rt715_get_gain(struct rt715_priv *rt715, =
unsigned int addr_h,
>  {
>  	int ret;
>  	/* R Channel */
> -	*r_val =3D (val_h << 8);
> +	*r_val =3D val_h << 8;
>  	ret =3D regmap_read(rt715->regmap, addr_l, r_val);
>  	if (ret < 0)
>  		pr_err("Failed to get R channel gain.\n");
> =20
>  	/* L Channel */
>  	val_h |=3D 0x20;
> -	*l_val =3D (val_h << 8);
> +	*l_val =3D val_h << 8;
>  	ret =3D regmap_read(rt715->regmap, addr_h, l_val);
>  	if (ret < 0)
>  		pr_err("Failed to get L channel gain.\n");

This looks like an unrelated formatting change.

> @@ -188,8 +205,8 @@ static int rt715_set_amp_gain_get(struct snd_kcontrol=
 *kcontrol,
> =20
>  	if (mc->invert) {
>  		/* for mute status */
> -		read_ll =3D !((read_ll & 0x80) >> RT715_MUTE_SFT);
> -		read_rl =3D !((read_rl & 0x80) >> RT715_MUTE_SFT);
> +		read_ll =3D !(read_ll & 0x80);
> +		read_rl =3D !(read_rl & 0x80);
>  	} else {
>  		/* for gain */
>  		read_ll =3D read_ll & 0x7f;

This too.

> +	for (j =3D 0; j < loop_cnt; j++) {
> +		/* Can't use update bit function, so read the original value first */
> +		addr_h =3D capture_reg_H[j];

Why not?

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBSDWkACgkQJNaLcl1U
h9BAoQf/b21gnwTSXVxqHZal7RLJt3o7j169RC56mrBHiTfU6Oc3t0xFAI48qHSI
xcDocnS0ZizeeW3YQHf2+7q6OJyXLYAIuy7pU5vQ4xSbFKeAsBSoNb+KvB1nNoRa
qHApwc4OlLcJxReuPG8Al4BcZDpGO2TuHcCBm8ETK163+Inok7nF4YhkN1lDCDmC
NY7rVqsOX1RTKFF1KOBqWW5h2JI5ecrawz3Yfl6BSKxEmmmTiu5YZ3K0vNNa+Zkq
VEcT9bbqB+3zFw8MJwncKgM3u/5GygRFUkUNISSpL3QbI4dww7JUc5N7dhZJ3e+p
eMkvUwo4B1Yq4DMxOS6JZOIAvCHxfA==
=Zard
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
