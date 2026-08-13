Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE13AC5B572
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:21:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2623A601F8;
	Thu, 13 Aug 2026 18:21:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2623A601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786638090;
	bh=ZiQrxzhJDHJSEu+NKhIl4bDxMSm4cQOhwSoDUghs2XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NBGf0bMG02GIXDTK82UXbDXTfGdI6g92PGgzDZBQqToUAOPdo4DBOIhwy9WKjUamP
	 86IB8qvyhy8AV3rdMv03M2uXnCc6C2krca1Xs8eVOq6C3mS6Ge8Pji2fl5m9GOG+0S
	 o5kadQDs+YdGjMz47CVoNm6NqmRNMjpPFSybghxo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CE83F805F3; Thu, 13 Aug 2026 18:20:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BDB1EF80601;
	Thu, 13 Aug 2026 18:20:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00546F80553; Thu, 13 Aug 2026 18:20:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786638050;
	b=q6Ix/k0hHyBjUD4o4Cj1/Blrm7y1PheDDvwmrxwXpd/S1JrHvOGF0T8QL67FdQQaL2ul
	 FZLSX1iSq6U7JUH7F9OlCMWui2PV2hI6jWdL7g5YW2kDcvNnZsZgCbAQJ29tBSt97o2PD
	 SWlpfSUdeoJCbv70vCINsfQ6QBdvHrLPh6e30h3kLQq41udotiMLu7mh/jdZp9HwjCbIZ
	 rrMrIcDJCdTOWN6Hd0orur4IXtIGgVzeXk1XfJgxi2KcpP/o7lcNS7it4HlHA4c392VyR
	 m5EKSN2OWPtD8/ElUWBTnp3Q8weAwX4q2uQIqcPzz26JpqlvrHGnsCNUeaZ2VlaMLrQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786638050;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ZiQrxzhJDHJSEu+NKhIl4bDxMSm4cQOhwSoDUghs2XE=;
	b=LMnmgqCWKRpl/oqF+kzyrzTHmsDhL0pgeYpavhjZ42syeydsdJIu9ZoIFC9c0VQ/2m4E
	 9FvWi0up0XLDY5mp/E7qmB7fBU5YVvx1fwW2cjpJkQJ5Y60QGN9uykbjDMV1FDpuG7XX6
	 s8dr3KvHeHB/y2kBvCwnMQkVIDYZGNgx0fCheaoriF7ZGqqwENSFvvVCZzo+7Bz7NTHFA
	 FogK9eDDqJ8q0imzSIxODOYBfTUeKcYOlh0yQMNpOj6urfHkZFtb/NpydQ8mZVl4Gf2AQ
	 BBvEj2ffmimqUgd+QxY39/HgmHTT6sYgqMmfhe2QTLsKjrgHhHVCKfQ7rYaSCsfl2Zw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fVeWJ+ad;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F2277F80027
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 18:20:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2277F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fVeWJ+ad
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DEE34378C;
	Thu, 13 Aug 2026 16:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C31F000E9;
	Thu, 13 Aug 2026 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638045;
	bh=C2tF7MoVfhoVhR6e4oKHQaLxMK9zEigM8IPLfjfRXiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fVeWJ+adS5+OpDGgw2Y1+tgyDlJryWpXw96QUDMxsXTzd9g82ssbztul+g7eAESGs
	 NI6IrvAtPTDF5B0H+uTyMuvetKfH2ZGHosCUUV9dEqUrGziav5Nsh2owQk8dmpWwxo
	 //XUYMUyqivdZW6PrRpC77Bd9uHsMQHtlU702vBbGlpRN7E9CDCZezNuYgMbHa+HS8
	 licP8p8isAv9yitknJCgXSTZKInykr9/Mp2Eq544jV2Uki5Wtc48aTRxlVLKpXCqHR
	 YVu0zaSwMhDRmH7t2YJyDp3v1ZuJrpmH+LksU83bBaksemW9LpaO6Wqni1MFmu1U6b
	 0eYQsiylD8xqA==
Date: Thu, 13 Aug 2026 17:20:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v8 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <d57c05ce-929e-441f-b02a-2e1598a06ee7@sirena.org.uk>
References: <20260813064327.1127236-1-YLCHANG2@nuvoton.com>
 <20260813064327.1127236-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AgQO6F8dSbRgE6Yy"
Content-Disposition: inline
In-Reply-To: <20260813064327.1127236-3-YLCHANG2@nuvoton.com>
X-Cookie: Immanuel doesn't pun, he Kant.
Message-ID-Hash: WZNQSBI4RKVRTNBG3OV2HHTUCXC3ISBR
X-Message-ID-Hash: WZNQSBI4RKVRTNBG3OV2HHTUCXC3ISBR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZNQSBI4RKVRTNBG3OV2HHTUCXC3ISBR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--AgQO6F8dSbRgE6Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2026 at 02:43:27PM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> +int nau8360_dsp_init(struct snd_soc_component *cp)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
> +	int i, ret;
> +
> +	for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
> +		ret = nau8360_dsp_chan_kcs_setup(cp, nau8360->dsp_firmware[i], nau8360_dsp_addr[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Should this or the binding parsing code do something about PBTL mode,
the binding says that the left DSP firmware is ignored in PBTL mode but
this looks like it will still try to load the firmware.

> +static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);

This is registered as a regular kcontrol so should get the DAPM context
with snd_soc_component_to_dapm().  Same for _put().

> +	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
> +		dev_dbg(nau8360->dev, "PEQ access is not allowed during playback");
> +		return 0;
> +	}

What happens if something starts playback simultaneously with this?
Nothing stops playback starting before we start accessing the registers.
The check will also fail if we've got an active capture stream, IIUC
we shouldn't have one without playback since it's an amplifier and
that's presumably for DSP feedback but at least the docs should be
clearer.

> +static int nau8360_hv_pre_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +
> +	if (SND_SOC_DAPM_EVENT_OFF(event)) {
> +		snd_soc_component_update_bits(component, NAU8360_R9C_HW1_CTL2,
> +			NAU8360_HW1_CH_MUTE, NAU8360_HW1_CH_MUTE);
> +		snd_soc_component_update_bits(component, NAU8360_R99_HW2_CTL9,
> +			NAU8360_HW2_CH_MUTE, NAU8360_HW2_CH_MUTE);
> +	}
> +
> +	return 0;
> +}

This is registered as a SND_SOC_DAPM_PRE() so it'll run for capture
streams too.  That's probably not the end of the world since IIUC that's
only used for speaker protection data but it's still fun?

--AgQO6F8dSbRgE6Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp97tcACgkQJNaLcl1U
h9BF7wf8D5dBFlj7AiQei8Nr98NDLQy9SjP8QVGdtbBgyPzpU4E5K6gWD//63TtY
Nfe2LSIB5czpaFkGVc8AC/tdR3pw5g4612qt6MtdTikckdcieso7aVcx//9S08Ny
iP+15/jWA4E+NoszxkkuIWdt0BZDcYGkkgRpt4/cAtidJ9rqwxfUs8k+4rcGOKIS
kHEuIgDl9MUL79Az4vLSCdAyheq3E7hVc8bTxeSPBx/A0l4DeFA2+FyixsORBEvu
ojJndnYP0Jkal+RnQKt/fCUY3lf6pyocc6XQ9RehabJ6JuMJSwmIGeI7EENHq7I7
Xxz5xK5XX0NKRzTMVFUjllzGA/udYg==
=7G6m
-----END PGP SIGNATURE-----

--AgQO6F8dSbRgE6Yy--
