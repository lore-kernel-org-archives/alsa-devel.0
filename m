Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E272DC43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:33:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DED5F60208;
	Sun,  5 Jul 2026 14:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DED5F60208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783254782;
	bh=kCnFH0V5bkUOIV0fiHl29DKKYu4m94o1jAMzJXsZ7vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Md2VANJmTvKeyhmFWwer1YH5/TFKokk/0qD43OhLV3jmqSvDpgAhIcPo5jTaE1TBt
	 AAsiUMXmsRFArVPhm5eGpTbFxbfdMKfya1xz4LKMdHboqQxyemHBf4fb51la/Qytvi
	 fvho0dtsdjzQY5RAH/2HrSQwKqkKtHnpcvUu/eJY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AA88F805FD; Sun,  5 Jul 2026 14:32:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DAAECF80524;
	Sun,  5 Jul 2026 14:32:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4E03F80526; Sun,  5 Jul 2026 14:32:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783254738;
	b=sC/PP3OgppgJs/rVfAD/aRMyg+aponqOtQhkPMvyhSX/JZ7TeMlrICQwyQXVixDIfFhN
	 BwyRVtIfvVLvT6INuNmOT0VypUqguNMVvZiHFI7YMr38fogK8cI0t4i4WrNTNUizT2aLJ
	 YL07Vwk/u+lmfeEXe4n+2TUfyFsuXY1g/z/4q375SxuzdV3TnVZAj2Ej44bUaXuXlZ03c
	 Ndv1HjI/xr4+wruNnz0GbipEWNmnz4GeTR2TDVd9ViOVbLB8DlQTNyOYMdUl7ZJB07F9l
	 N9m6EOErbjJNPCYEJZ+Yo5Bdt1I/8u4AVDKVFGVnnyQ94BWkHTgBJgsPIj53wWHNiLA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783254738;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=kCnFH0V5bkUOIV0fiHl29DKKYu4m94o1jAMzJXsZ7vM=;
	b=l4tbQaf7VYsQrbcTlXDZSbzgmbBl/79x/Fzuo73/OeHL/iU8AeRmt2NxMA8qxELeBcJ4
	 a1pMLjo3GzA9VYBtNZGW9+1CTlG7vzTAkN1dIhoaap35QkQmFvNnporiyDMsOGpjcJWb1
	 ++/taF15jey3FHVMppYGLQDAjHptc/HWasa7uR5MMRRv3AbWqalC77ws0FHBcRtgY6VG4
	 77+NZISlRb9ILzbTAhbq7j6WAVmq+traLQ1TcTtCpIqJAfz5Cilkf4mUsaR/TNiZqhRMy
	 SG8dJ/uKljhpgLkpQBPsh2s9trBdyW83fG07JtjtQurAefNK2ItL6/ObxJHMQ/r9z8w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LnUhwDHo;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C339F80524
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 14:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C339F80524
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LnUhwDHo
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 88F2A40428;
	Sun,  5 Jul 2026 12:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B71F000E9;
	Sun,  5 Jul 2026 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783254734;
	bh=CUmcoIH8UZfQOi92h9YHbdWwrZUGogZhLPJcSsnuaE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnUhwDHoT1C2NwsP2qpQUJPINDRwCgLMsyP1P9fmVkRgM/PaVZk2xVU+LWoaa6DO2
	 hcc2s3uYQYvhPOzdIp0hohZ70JPlsjRfVandee4VUaTE4AjVmcAoMUKr6hOiJVJIIF
	 YfPk27/06kyXvTeLhEa572sGVgW8XW7fdJGszb3+aAwR3Vi7+nMU+cM08V4kkykZDl
	 h6ZvRz5NUzxi4qR58Pp3YLrNUqsiSLp4gGYVX5G0TAPiVPXnoGHYmQu00kw5zQr0Bv
	 Ji83tV8I2/Y0XuiIySRHLImrNwEfxagbCGDQuhUA7sr6FqKU2GIYWWNDaqCxL6CeRU
	 rTJOKVZYTgR+A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EF3E51AC5AC6; Sun, 05 Jul 2026 13:32:11 +0100 (BST)
Date: Sun, 5 Jul 2026 13:32:11 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v5 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <akpOy2HJsDCu7wVx@sirena.co.uk>
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-3-YLCHANG2@nuvoton.com>
 <66ce56eb-95b9-4915-8658-a1e4d1eacd7f@sirena.org.uk>
 <3b32493b-b827-e4ed-3ad1-281dc19faf40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9OleKUcYTZwvIODp"
Content-Disposition: inline
In-Reply-To: <3b32493b-b827-e4ed-3ad1-281dc19faf40@gmail.com>
X-Cookie: Absence makes the heart grow frantic.
Message-ID-Hash: M2BL5UZO4DEVGQNTOSAKI6AZ36WFEH47
X-Message-ID-Hash: M2BL5UZO4DEVGQNTOSAKI6AZ36WFEH47
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M2BL5UZO4DEVGQNTOSAKI6AZ36WFEH47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--9OleKUcYTZwvIODp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2026 at 11:26:12AM +0800, YLCHANG2 wrote:
> On 7/2/26 23:15, Mark Brown wrote:

> > I would expect TDM to be configured by set_tdm_slot() from the machine
> > driver, not from userspace.  I see the driver does actually have a
> > set_tdm_slot() operation...

> Our DSP functions require specific Slot mapping (e.g., Slot 0 for AECL, Slot
> 1 for AECR).
> The standard set_tdm_slot() only defines active slots but doesn't handle the
> functional mapping.
> We originally intended to allow dynamic mapping via UCM/userspacea and then
> apply these settings using set_tdm_slot().
> How should we implement this mapping according to ASoC standards?

This would usually be doing using DAPM routing if it's expected to be
runtime variable, define AIF widgets for the bus slots then route to
them.

> Should we define the default mapping during the codec probe stage,
> or is there a preferred way to handle this via the machine driver?

Device properties, this is better if it's supposed to be fixed for the
system.

--9OleKUcYTZwvIODp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpKTssACgkQJNaLcl1U
h9A/mQf/c053HM+naqdF17/uVmgb6e04rPNnqH7Us+kvxpfWyPS0bp+3vo1P6Ur0
POHx0sPld8RauUxTig2rXk+Kt87Asn3/wm4kTQrOvOBv8airOLBViFeIQHoIrajo
JdH678NtqoVhc3zy5W8pt+/6zeTbQK4obbfOzjtWEe6EbsrXiy3B9BUnxbe2bt5k
E3coE4U4a587PPepJe5ue7eJfyc3xFHTHlsLxtWXsO+P0oSZXwrt2CB74Cvjvzwc
Yt1JExI6vhfLnLt/2YR1PtTiMH9srG/xVBQo7USnxq1SxDnV2y8nelMpyE9LjkAH
KZ9YYwMy9ji8OzML5MUqNYGiVXihiA==
=bhKF
-----END PGP SIGNATURE-----

--9OleKUcYTZwvIODp--
