Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D3CD5BD5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 13:44:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D659760273;
	Wed, 27 May 2026 15:44:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D659760273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779889488;
	bh=B9uKDCmuE+HIELsxBmZ3MrYYA+QztaM8DICspZlqOKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I0eB3aYzx4/XEKbAxHvCK6v9CgZj2X62+KrW23kxhHdIQtq9v6TmYMlVw1QD8Zijn
	 +my7eJxgZzj3EDml2ivNHzfT4prIh/d9YrkixkTskJ4aP9iQeg8zHOUFwN/wumJ6SF
	 Q3HDAE+AtmWKPNCeTW6rSejHNL3Pj+Gvs5TZCeW0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC954F805E7; Wed, 27 May 2026 15:44:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 625B0F80549;
	Wed, 27 May 2026 15:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBAE5F804FF; Wed, 27 May 2026 15:44:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 61F10F80087
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 15:44:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61F10F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ys+Ks2OR
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AA3E401D6;
	Wed, 27 May 2026 13:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E34E1F000E9;
	Wed, 27 May 2026 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889438;
	bh=ManTLR8cnSqPRzXSHvGGL9dszH+Gg40OZ2hHPnTSUFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ys+Ks2OREIDkyVb/ydbR35kFybCJlsdSwM5yTaq8bGwg26wBLGRsnay09YHYNqcVs
	 trcDxvICwyrtJ36NdlKlfZls3xBp0Dcxo8h4TkD32zQbSI4b0v8tLEtc9Bdx6WAUEn
	 PrMFymT9kF+3D5rtPw/4oOKZ05YvaSV6UtDahcs+nhllzC9I7fijiENsfC5Vkd2JKi
	 If0ghTVjA9gvk61zq2ghhxZpgtr+7QXh5FELs0SyvQJ075rhK0j5EPr3qibRS8Zknl
	 j+3Rv+hZeYqJVMzFc70wa3QiaOFapfAxC8TUdEAJ3M1f7z68ZvAC/i651bxg8ElIuW
	 9EgPq5K9OQvJw==
Date: Wed, 27 May 2026 14:43:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v3 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <d4cf4ad9-82fb-4beb-be5b-b3687f822fcf@sirena.org.uk>
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
 <20260526015826.440769-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VqmZj1l8twwgh5fH"
Content-Disposition: inline
In-Reply-To: <20260526015826.440769-3-YLCHANG2@nuvoton.com>
X-Cookie: You are fairminded, just and loving.
Message-ID-Hash: YWUAN2QP2LKJSMAMXOF5IN7B7CUHDDGY
X-Message-ID-Hash: YWUAN2QP2LKJSMAMXOF5IN7B7CUHDDGY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWUAN2QP2LKJSMAMXOF5IN7B7CUHDDGY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--VqmZj1l8twwgh5fH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 09:58:26AM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

A few things below, you also have a bunch of what look like legitimate
issues picked up by sashiko (some of which overlap with what I've got
below):

   https://sashiko.dev/#/patchset/20260526015826.440769-1-YLCHANG2%40nuvoto=
n.com

> +static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

=2E..

> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_=
TEST,
> +		NAU8360_HW1_MEM_TEST);
> +	for (i =3D 0; i < params->max / sizeof(u16); i++) {
> +		value =3D snd_soc_component_read(cp, reg + i);
> +		*(val + i) =3D cpu_to_be16(value);
> +	}
> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_=
TEST, 0);
> +
> +	return 0;
> +}


> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_=
TEST,
> +		NAU8360_HW1_MEM_TEST);

=2E..

> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_=
TEST, 0);

We use an rwsem to protect the controls from userspace so we could get
more than one caller in these, you need some driver local locking.

> +static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx=
_mask,
> +	unsigned int rx_mask, int slots, int slot_width)
> +{
> +	struct snd_soc_component *cp =3D dai->component;
> +	struct nau8360 *nau8360 =3D snd_soc_component_get_drvdata(cp);
> +	unsigned int tx_slot_used =3D 0, rx_slot_used =3D 0;
> +	int ret =3D 0;
> +
> +	if (slot_width !=3D 16 && slot_width !=3D 24 && slot_width !=3D 32) {
> +		dev_err(cp->dev, "Invalid TDM channel length: %d", slot_width);
> +		return -EINVAL;
> +	}

This stops the support for disabling TDM from working, a slot_width is
required here. =20

--VqmZj1l8twwgh5fH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoW9RkACgkQJNaLcl1U
h9AOAwf/XCpGenqAsg5VdLiNBYcT/3lty5A1czozWimgLpuXdu6a8xLeqFCYlOfQ
ECzRk/arz8HxuonhicRhMQ45lzA3O56D67Y1X1ajLIQLkaiqlmSILTesbQ9xFRyQ
y3LSIqCcZA15FWDEHjFI9y9OpkIiht5PSSzoxEl27991Do8FkGrcizSgU/DTlfiD
Y5D7Wp5Zbx4BIxwWsxtkG54n207YmMUBETfsaLbmn6rijv9OISrfXFAAdP4YNMmM
aCF3r7e+lpamW5PAaiUdQp8cKntSu36zHGeY0SmkhAhMU/ClR6TB0ZdnI6YT+DPT
2axvsMhw+oCPaBVr3+Pb4eQFgzyX+w==
=IE9q
-----END PGP SIGNATURE-----

--VqmZj1l8twwgh5fH--
