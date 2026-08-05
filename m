Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A6C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:31:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82AC660225;
	Wed,  5 Aug 2026 12:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82AC660225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925908;
	bh=kSGCtVbR8cRvgnRNNhaP5p4VqSrwSfcjG6gaozNQzZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CDuIKrHDY3X2HQhidiW6Vma2Hh4EY1ihWLA7hYg3DiX7MvJmWjLrjVFa+iKBTQBN/
	 j/e36jSUWxycUytWxckNPi2DeNBmAtvXy85n946Rhf3Rsm2dHrdwHC4jyHlLGlMuMh
	 QQ3y0vusLkgPLInVneVLfApkK+4MNx/Pm4cP7ADE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CD8DF805F4; Wed,  5 Aug 2026 12:31:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B80F3F80600;
	Wed,  5 Aug 2026 12:31:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8069F8027B; Wed,  5 Aug 2026 12:31:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785925864;
	b=X8zod98xfCBHL1cdrZpSg1992jjSBaUUyaHVMXYb4UgRUbMgwB2jCXNrbTFM8U3yV6eL
	 pd4JtDy6ThExTMYwCdCl3l5O+lV/nSg0v05tcVt0ZHBQQaetZqfkdhQLfggUh5nPafyHi
	 +dlZIjv6dwVhpV3oBKNkGkFmLqI2CAkV7AZBajGTNXiwZRYW2rUYv33Qduu6nM30H3YcZ
	 YAU5dusIBgq05izliUnFOMBp9A0oO9nzns8nRwL8uGFMbL3caeCg/4xGnKV4KH/pNEUEN
	 w27+g6L2JiA/akWBIQpw6wmdUxnqPdxH2xpO+i6d2XuljYXx1RGVY9LSWsiDBo+Vr8g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785925864;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=kSGCtVbR8cRvgnRNNhaP5p4VqSrwSfcjG6gaozNQzZs=;
	b=PrFi9DaTlv2YrfE/DpiFqauvt3O9YUnd4BQFFt91lmJnXkTt2jSdzzsuEx/XB53FTvyQ
	 LkRzXKmMR73a0L/Mmm2nj+tXDep4mC7F9PssuttVDd6kjHEZH5ZbZn4mECJAURmACCBwl
	 YQsTwGEsG5ABTfxeWF0FEcynOZ849TE2OlIbTjoFDSoCmqLyksZKBfFuZBI2m4UQXa5Va
	 9bEdeQ7SdFZTUj2n6SlbtO0CU6oFF4ZOXp7ysAjdoKUces2m7z0j+CIvlvZ1ewIKHKzXp
	 LK/D4Y1ewBS1wEWk3E6D2Cq1PwxBwynwEoeeuhcCUmG7RClzjuMx9GHoYehXtX7h9xQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bRQmVAs1;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33000F800AE
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 12:31:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33000F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bRQmVAs1
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6198340C1E;
	Wed,  5 Aug 2026 10:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A661F000E9;
	Wed,  5 Aug 2026 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785925857;
	bh=9QY8sLvXEjely0lgxRQ0MGVx5/6YTx8OdpKaPvj/ilg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bRQmVAs1ydr0/qlnTbFTfCz7MR1kmj/sPgEslnKKih+m3Ebc9+rxpXI9yXsdaHLBL
	 G56670VSWm2rmwWmG6kQYpBiOtBhEQ3tsTj5ahP1qbqDI+FLEQWYQOmYDP3M0l97lU
	 ipghHzCsoWYd90bRulbrPipRQX4GiQLmMI+i+kz5HMoXDLExg6Y3fUYXL+QErW/1Qc
	 qr2EpdueetbmMfTC/VLOl3ViO5IugZgbQDbCMHDzYILitcFXog5MVHWl/EloWdN62Q
	 X6D0ssZPWyoG9FfGgoAtQr/0OEERJ+CBurRB8hS7fzxTqGWo+Q7pTmblKWZBa5oNyY
	 uBWvpvFBiIQwA==
Date: Wed, 5 Aug 2026 11:30:52 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
 <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wSX65rLJnZG4q4ts"
Content-Disposition: inline
In-Reply-To: <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
X-Cookie: Stop ahead.
Message-ID-Hash: SJIMG26Y2M34EO5VCKXTSMJM7VJLSRDO
X-Message-ID-Hash: SJIMG26Y2M34EO5VCKXTSMJM7VJLSRDO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SJIMG26Y2M34EO5VCKXTSMJM7VJLSRDO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--wSX65rLJnZG4q4ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 05:03:01PM +0800, YLCHANG2 wrote:
> On 8/4/26 23:58, Mark Brown wrote:
> > On Tue, Aug 04, 2026 at 11:29:51AM +0800, Neo Chang wrote:

> > > +	switch (clk_id) {
> > > +	case NAU8360_CLK_ID_INT:

> > Usually we don't have a lot of fine grained control of the internal
> > clock dividers of the device, things are a lot easier when the device
> > just figures out what it needs based on it's input clocks.

> To make sure I understand: Should we remove the internal clock IDs from
> set_sysclk and handle clock configurations automatically inside the codec
> driver?

That's ideal.

> Does this mean we should avoid configuring them via the machine driver
> entirely? If so, what is the preferred way to handle clock fallback when
> playback stops or MCLK is absent

> (e.g., via PCM shutdown hooks or DAPM events)?

What do you mean by clock fallbacks here?  Presumably there's some clock
still running, if that's the only one running it's reasonable for the
device to switch over to it.

--wSX65rLJnZG4q4ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpzENwACgkQJNaLcl1U
h9BDkQf+IsVEz+3iVy06KiM4odUUtyikOkdVqwgriauT33Rl8oBSYF7XFDPDdXv5
L8OPFenTor5m9go+wFhfL8hdsm91usoOCjoGSndpgLGJGzjEZNtSJFHhRBuIZShf
E/sm0KenjEeabySrOoTFX1MIxffDzUhgFyBAjW++00dxVatMcGsVmrb3RLZDrhQA
Go4lH31Xo2nazrtieZfJqPb1Ie/98ptaOa/6bK/qUBEP7IDrMgHU9kFZWGAHJqef
zySGvM4zVN6LRDmVzpbnbOozzwskq5/meHsdQL3ky/scuH6Lw9Sm3mtvwF/vnHdB
qFJFEiRiO8QD6w0EFXVXJ1mHoU2cIQ==
=pQ/m
-----END PGP SIGNATURE-----

--wSX65rLJnZG4q4ts--
