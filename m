Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AE6C5DF7D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B011A60290;
	Fri, 21 Aug 2026 17:25:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B011A60290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787325927;
	bh=SBGml8hrQ2aFRGNL2p+ZCGxmIsUl/78d5Et7UrK0FMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tWmPnBKWFS2cEClNI0CqMLP+TvnqiNnZJdtGLwEJSPV3MGAQFVQQ0zCLKDDllPjUw
	 05OIdtDdGRl2VL1bBKLLDecVdcn0gyd2Q2Eg9eoJVltbfZz3bqzvIcpS6/X63WSgCV
	 TtyBrMoTLRCkowgb7zks9sJPIow9w313Sr9ShlkA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57BD8F805FE; Fri, 21 Aug 2026 17:24:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B196F805F4;
	Fri, 21 Aug 2026 17:24:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBD62F8051D; Fri, 21 Aug 2026 17:24:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787325885;
	b=R88hqNy8ReN2wBdt2PPc0ZoqRg3QE9KgJczYRZZEPmwtqxnQPL1V9FDO9XcPTVRXGbjE
	 LDXgrLLu6KPcdxJYtw2EO7GFFPBsrDt2G7PNd5YUGx9GyFDZfebiGdURC5w6vb4bOgMPA
	 ADCDwMfnNZ/Hn9sM+SoTzBaoQ4tF/OJIa+Q+2RgB1Bclz+6j1S4qUsGCHxgjdZarXDYdX
	 wp9/Ip9pH6eiDX+UiG5HxTdmWI4KkFyKd5FTb/K3GD1x86mwrLhBW7hsvFSE0As38hoCv
	 MV5CBHEwfF79OLbmTEwvTswq38Vklkjf5VfJzbuPv/k3Vf2jBdLYIqFK/444iVtNLzA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787325885;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=SBGml8hrQ2aFRGNL2p+ZCGxmIsUl/78d5Et7UrK0FMI=;
	b=MP7uwZCj1qUWMC51pT73L+W9kgwV38nt3c7xQfvjtLRR7Mzsja+xICFORTxZp1iRs1jX
	 LwF8jt7i7bMN64nbwmyVjZnv6SHcEucl06YRCFRdjBsDL5fMuoomqb0S+bypqvSGyDjYF
	 /tDOaBC3wyIUmDCFUbRsEMyipthSnElkAkpEicLT1pk1kFfqAfvHhbB3S2Cah/lmt5yLd
	 lGKQbOwwxbvdMxmtZDPEPjJEs1imDXgUOF7JB3clQBbmrcmmYKoNuM/VFbLYqI/Aq3L+X
	 Hxd+xDW0B23JSE7NYdTmPe/GIkbEAHI7bK4YR0GSxAXMRVALv68brCLSmMc0eHZNDjQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VWsTPTjF;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A90EF80246
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2026 17:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A90EF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VWsTPTjF
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 03E6D42AAE;
	Fri, 21 Aug 2026 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB01F000E9;
	Fri, 21 Aug 2026 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787325880;
	bh=dnL5vbj5IlrgthDUXFHTUoJ8e1RoFREik7AkKfQotBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VWsTPTjFck2IV5MzjnjvlEZBKFtNtr6UK41cxwdBCwKDSEtRJNhn68AGM9VYnrIEB
	 MKH+8eHrVZiztyqudfUZP1eDnusyNgkJ4CeS3oWD3kgVC9dmA0cuqFIh3yO4giZHeE
	 eklKneFSNty/eOOT8CLXBi8Ha9ECzg1WOpSCO81Nb08enxxhCY+DteS07YbezzXyx5
	 QdMySiIZuwghX3UrEBTyMSYJSmSfsxTGObMbGd1vXkKec+elDUGNQSDMcdww0QjBnO
	 neb1rL/qmTbkhV9p/yGnbNHCbY2Gdm3abxaFXmY7QKsRwQZAdEybzW96LCy1ZfEDZG
	 y801IxSjrscbA==
Date: Fri, 21 Aug 2026 16:24:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v9 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <7e7b8329-23d3-495d-ad48-9ea70189c46c@sirena.org.uk>
References: <20260820022925.1174132-1-YLCHANG2@nuvoton.com>
 <20260820022925.1174132-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FbvYG0boBekWO757"
Content-Disposition: inline
In-Reply-To: <20260820022925.1174132-3-YLCHANG2@nuvoton.com>
X-Cookie: Package sold by weight, not volume.
Message-ID-Hash: 4ZMY34GNWLRDDHYZJSTO4EPZNYGWVYCU
X-Message-ID-Hash: 4ZMY34GNWLRDDHYZJSTO4EPZNYGWVYCU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ZMY34GNWLRDDHYZJSTO4EPZNYGWVYCU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--FbvYG0boBekWO757
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2026 at 10:29:25AM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

A couple of issues here, mostly this looks fine.

> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(cp);
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
> +	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
> +	int i, reg, ret = 0;
> +	__be16 *data = NULL;
> +	bool changed = false;
> +
> +	/* Use the DAPM lock to prevent race conditions during DAPM power-up
> +	 * state transitions, and check component active status to prohibit
> +	 * PEQ access during active audio streams (playback and capture).
> +	 */
> +	snd_soc_dapm_mutex_lock(dapm);
> +	if (snd_soc_component_active(cp)) {
> +		dev_dbg(nau8360->dev,
> +			"PEQ coefficient access is ignored during audio is active");
> +		goto unlock_dapm;

This should probably be -EBUSY or something, though that will upset
mixer-test.  As things stand since the values change when a stream
starts and stops there should be an event when that happens, and since
we report success some value ought to be filled in for the read.

> +static void nau8360_dsp_fw_load(struct nau8360 *nau8360)
> +{
> +	nau8360->load_fw_done = false;
> +	schedule_work(&nau8360->load_fw_work);
> +}

> +static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct regmap *regmap = nau8360->regmap;

> +	nau8360_dsp_fw_load(nau8360);

This only kicks off the firmware load, it doesn't wait for it to
complete.  That means that if a stream restarts quickly after resume we
will run into issues - I see that the normal playback path just errors
if we try to start without the firmware.  We should wait, either here or
in the startup path.

> +	if (NAU8360_IS_DSP_REG(reg))
> +		*value = nau8360->i2c_read_buf[0] |
> +			(nau8360->i2c_read_buf[1] << 8) |
> +			(nau8360->i2c_read_buf[2] << 16) |
> +			(nau8360->i2c_read_buf[3] << 24);

get_unaligned_le32()?

--FbvYG0boBekWO757
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqIbbMACgkQJNaLcl1U
h9ARoQf/Vm6uj3Mw8pW8Ni5unT/J30hjetyZ2zxoIepaS5lXsLB5W34wxwhZhTQq
D3wbdzK1JJnvXXivIoyoJjY8EZZlXCp7si6f89XtOokkQ8Mvw21EgUetKaDBrNfw
j91Nw8GBQnY5B+jM4qSvgmHi0nE3lujSpcKm6WQyUrGO2iMJpanztxuv8Py6DCDI
ojPbtfNA8mCWtiA3gLJC4R3O1DbJZRuKJLpgCyp35NMnttJDaajjdAhIgPAfK/jV
thzBU72FrQpI4JsDNgT7j9aXXFQBT1k62EKBOEfAB+CFvAz2sgdkd5l/70FCEnRV
65SCV405IUFuSECXuVpFIzRAJ57p6w==
=NzXF
-----END PGP SIGNATURE-----

--FbvYG0boBekWO757--
