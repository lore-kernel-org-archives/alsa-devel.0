Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFAD3517E
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:24:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC4E601FA;
	Wed,  1 Apr 2026 15:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC4E601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775049848;
	bh=jNun7tEBCVvKCvcUzpjDV4DojQLFWfThwxsjBIm6tRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RLzBrTpvtWKmGrwLV1/dhUXqD7BkUVw7eynw+ByQtMV3nBU4/RpeKiwO00PmKdWUp
	 HYdU7DlPrl4r/8w9bhnqR0V2oo3wndD0SI7QtIHsIXNAMzjZ1gSZCDGbRgiLdOEVmi
	 Upr98T+soKv0pGBU2KRt0w0DGYjETD4ptkumorwQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C522EF805F7; Wed,  1 Apr 2026 15:23:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9BD5F805F2;
	Wed,  1 Apr 2026 15:23:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62043F80527; Wed,  1 Apr 2026 15:23:25 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0B6CF80171
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 15:23:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0B6CF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Vk7UrD6B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C503409FA;
	Wed,  1 Apr 2026 13:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2548EC4CEF7;
	Wed,  1 Apr 2026 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775049800;
	bh=jNun7tEBCVvKCvcUzpjDV4DojQLFWfThwxsjBIm6tRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vk7UrD6B3V4HYSlxZwPtkC3X1Ggh4dn6O6TmanVRJMoWIoa5BQIx2+FVqIFjyrUQ1
	 xf7b8RvlV4Fs7HEP5TF8YMP/wUa6kKByMg71zF7lSj95a9gTcEY8e2RIljrUlhQALn
	 HwBD3nkC1JuUeim5NvQpifhsI2hgt+G9McoVy3g302rlfm24qSi9qpxkv1hIukvuiS
	 1Tg5GmdCqSU3d6jD/AWO/Pyh+f0meiFWoY2OhApX8WVbTnsu2Fr2UkBkIdYcSpATRO
	 vbEHVU9im5+aUjNbJ99iqKOSIeFe53sh7PJbRHHSHfPokaASIR3oeO4+hhFq2k97L9
	 GdYnahu7JIGKQ==
Date: Wed, 1 Apr 2026 14:23:15 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Message-ID: <e5623b92-fe3a-4c3d-a93f-a9acb1fd8181@sirena.org.uk>
References: <20260401093107.632673-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftVu/RtojPmaMKMV"
Content-Disposition: inline
In-Reply-To: <20260401093107.632673-1-jack.yu@realtek.com>
X-Cookie: Pushing 40 is exercise enough.
Message-ID-Hash: GYIZNIBLVXDCI4HRQRKZX5MU62R2UNQ3
X-Message-ID-Hash: GYIZNIBLVXDCI4HRQRKZX5MU62R2UNQ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GYIZNIBLVXDCI4HRQRKZX5MU62R2UNQ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ftVu/RtojPmaMKMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 05:31:07PM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Create a kcontrol to enable or disable brown-out dynamically.

> +static const char * const rt1320_brown_out_mode[] =3D {
> +	"On",
> +	"Off",
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(rt1320_brown_out_enum, 0, 0,
> +	rt1320_brown_out_mode);
> +

On/off switches should be a Switch control, not an enum.

> +static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D snd_kcontrol_chip(kcontrol);
> +	struct rt1320_sdw_priv *rt1320 =3D snd_soc_component_get_drvdata(compon=
ent);
> +	struct device *dev =3D &rt1320->sdw_slave->dev;
> +	int ret, tmp;
> +
> +	ret =3D pm_runtime_resume(component->dev);
> +	if (ret < 0 && ret !=3D -EACCES)
> +		return ret;

Other controls in this driver ignore writes before hw_init is set,
should this one?

--ftVu/RtojPmaMKMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnNHEIACgkQJNaLcl1U
h9ATCwf+IpeHt/avOLi9Ll1iSkBZyL8llt04K4p9sEMo9v9hsr1o2e7587JtpdGW
jXaNXqfVoORqTWuDs7437M06CIwKNWi0ySQCaPRQqs4JeYj5WapdeKaNRE8/E55g
1vlopfYAdZVEvg0gHBBkPiYgSH2i0bdUwn3WUO4OkvVHKz9t2uHgfP7KgOxrCdel
KCT+vDjrNYs13jQcWKoCgUx3A65yhMWdIc5Xwq1paeSJUkHoaz6OlDviYXNqBr4p
jGE0yeMaUSuDw/tqG01YQG19ZbHTAdVACpSyTogjt5BCgiMjWt4WUYvvs7gmxxtb
i1zSLtgNao+1Tp5hpYGDjx5l2bliIg==
=hO+M
-----END PGP SIGNATURE-----

--ftVu/RtojPmaMKMV--
