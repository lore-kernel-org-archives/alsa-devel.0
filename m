Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D3C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:12:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1697460228;
	Wed,  8 Jul 2026 21:12:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1697460228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783537969;
	bh=AHJGdgLVcs9+b0U+hYJ2REpkRPctlOTm/9KrFAqcN68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XLBn9lNsRJPIKQ7CLr4UmCpaLYjT/jD+xCFXDTUFkAjm4gvG/p6p9VoWl3PX+aQAR
	 Ygr2aXdOZm4O8PQDfY/EhoqKKbZsb7aBKYpTYTYsIAqtvNqhG62lMeAytDDA+niY3X
	 cHdoQ0l+jITiGX7jWol1d2EaZs1ekPQr35M91W/o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82EB5F805F2; Wed,  8 Jul 2026 21:12:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 271DBF805EE;
	Wed,  8 Jul 2026 21:12:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F41A6F8055B; Wed,  8 Jul 2026 21:12:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783537923;
	b=MohGmHbs21NVevnUaEY3jg+7DY9EH2GvKMLljxfpxURLA+5AY9RYRePe0jJfFbYQqu5c
	 cYb0gj0h2FVztF+9gtFyLIbSojBHRxehkJI3PVGw8J7Ja7vkHxw1zBx/mGkeoulebPMR2
	 LPB5SwgaiqFLhjoQkctE94ZrG/Ba0dW4W4AmWEN+/SZPhgL0XNTFx2ksUn7XToI/3u2wV
	 1aiGU3ncx/TyT+SUcck8PQ4DHEWFdnjU2C2SQGc4rpMrrn1kJW5RXTJ7p9UVHt4QKsE1L
	 4bSNwSkdZizwGZLwbUEJALVPhRQFIvKnVYoE327gd5aRUZIAWNPeyMleLH4agsqcPpA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783537923;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=AHJGdgLVcs9+b0U+hYJ2REpkRPctlOTm/9KrFAqcN68=;
	b=ndOLuWjh27fpsskX095FmdZZlAZWvwEI8dK+e9zSdH+xpKNtJb1nmK3Z5nU8c64KE/PF
	 mytUCTTLJ9VFQyRGxuvQYboyuhKD0rCOn3U/gOO+o7VIfTOjYSehow43GYzTJzp9aBxAK
	 l+52rzALqZkWdw8TYSODYns4y7RbYXObd4R8THx60aKexPZ6URFNF+JWzgY15jz8fB1WP
	 4KzQpHZYxAA9SuGsgL1bGcE43HwVDk/4wCQ4u2b0uAODvz10ic+4COBJWuaf2Idxf2he0
	 hAjJfrFp7Z4wInMyt6nonRY5IPyHFUck3tS7OtWdm7inmGpQAcmxZEVy+8eTSqe89rw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WBwiNzL4;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4917BF800C1
	for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2026 21:12:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4917BF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WBwiNzL4
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AB0F6001A;
	Wed,  8 Jul 2026 19:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A93B1F000E9;
	Wed,  8 Jul 2026 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537919;
	bh=7gW1UZYVyjQ2M2NqvU0zYgWO0SDITcTPS+KqhiirHDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBwiNzL4xrokL7T6ob4BOeOInvFa/3JXuUp/Xmg5auqvTnW+OTnSwRnomvag3+hZt
	 pqUITBKMczmaxOkLdKrOzYftsH607vkqxh/DOCJ25dj1wj4PMpk8zYxMIugOLDPOW9
	 WtzOdKYikSBiOALBdDnP6zXbI68jSQJ4lv4e+bUWUzDvzMM+zdiABhYB6POxLnsxvq
	 Y68fYLjR0WV74q18eBlETPd7GIuh7MMb7arGVhIgKQtP9JUg0LC22HiMkOmLmvcrnD
	 UlQ6387nPXsLF3rP8GJg+XwDEyfNSJdzDUfB/7wA/iMNhzFf6ixzFZpZ9v7w7hqd9j
	 K+IufqGu3daPQ==
Date: Wed, 8 Jul 2026 20:11:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v6 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <a5139285-2017-4c94-92f2-f87fbef6fa6a@sirena.org.uk>
References: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
 <20260708093506.895481-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPb+sFRLKRrMY7hN"
Content-Disposition: inline
In-Reply-To: <20260708093506.895481-3-YLCHANG2@nuvoton.com>
X-Cookie: The other line moves faster.
Message-ID-Hash: ZEOE7FUBQMINTJPOIZHCU6VLFF7PVSK2
X-Message-ID-Hash: ZEOE7FUBQMINTJPOIZHCU6VLFF7PVSK2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEOE7FUBQMINTJPOIZHCU6VLFF7PVSK2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--bPb+sFRLKRrMY7hN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 05:35:06PM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> +static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
> +       const char *fw_name, int dsp_addr)

> +       ret = request_firmware_nowait(THIS_MODULE, true,
> +               fw_name, dev, GFP_KERNEL, ctx, nau8360_dsp_fw_cb);

This gets run every resume but there's no cleanup so if for some reason
we get suspend/resumes running back to back and the firmware load
doesn't complete, or the driver gets removed while the firmware loads
are pending during normal probe, nothing cancels the firmware loads and
they might end up completing.  Both suspend and remove should clean up
anything that's pending.

There's a bunch of issues reported by Sashiko:

   https://sashiko.dev/#/patchset/20260708093506.895481-1-YLCHANG2%40nuvoton.com

some of which looked valid.

--bPb+sFRLKRrMY7hN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpOoPoACgkQJNaLcl1U
h9ApFgf/XITbLpbuaEsOktfRrg4vKBaYvkVaUPW5mhT7anTKrSX69Ce+SEnRWo8V
cmTotB0Z8zn8ziV3QYo+zt+q/ecmEkEHCSWVmdUPNDhdRwriNMB7u1JZ1R9Wo/ho
BIIARxALZI4I06wE0gJii1sY9oh9kIFJOHzcIWDjEHdDQXXdZI6JLTivh4etD4Ac
9sK4KQ3XKuphSCu07zP1Y/+lcGjss7+N5VyY2OpSKZ1oVKLzqXsLsJI7pYUw1L90
+kZRHM5Ea1CzQ2cnY17SYQeDmKz2aNVLs3F+dzjBceIPshYqI2FW4fPlcZPFPU20
mtZD0lC4x+xcMc/1ePCj0er3ucfZCA==
=wcRd
-----END PGP SIGNATURE-----

--bPb+sFRLKRrMY7hN--
