Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDB2C3DA4A
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 22:07:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0E112C1B;
	Sat, 17 Aug 2024 00:07:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0E112C1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723846031;
	bh=/EilKSQ0mXGnk5AMMvGjVePctCjusnvFF4kZOpss1L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GXpURrACBae4ZXl/kLsSxHWYihW3zOK8w3odU3P8OXsKW3DIcRRI3OGl4LyC5cqUg
	 C0zcRLgtLdX0MLJOSla2LqivfR0DG8ZsrSw5W9ZxBRwhusWZMhWx7nzU2LOhlLLHgU
	 5kMLZaVxSEWEblkIKjp1ghbp+7Vbtp8NKO8wBBa8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0BAEBF805BB; Sat, 17 Aug 2024 00:06:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7523CF80588;
	Sat, 17 Aug 2024 00:06:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76053F80423; Sat, 17 Aug 2024 00:06:29 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 12A85F800B0
	for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2024 00:06:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12A85F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DXlrTNl6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 51908CE0D9A;
	Fri, 16 Aug 2024 22:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3939AC32782;
	Fri, 16 Aug 2024 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845980;
	bh=/EilKSQ0mXGnk5AMMvGjVePctCjusnvFF4kZOpss1L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXlrTNl623Qf6SG5C8zaxAv4i2cG/G3Grvk4ywWUSJr4Uo57uQw23yGdS4yBS+EPx
	 mntnVdSf0V3WuAXOBbfD2sRF30KwTCOx7a7GpmMHd4+xi/wFw/sNGCiMMueBia6rNO
	 tAlBv8j2wqdGHpBvbbFhTqZ3LC2TDzimmMjVsa+lW57BATFW3MSR2c6/fbWE56BuDh
	 xGHHwEPBJmT/XwNzG3sqyxPrslF/Xhj+ZWo4ZnZl9PZnF9xr4vnAfK7ZH4F7rp1JC1
	 3Qz52bmv3H1QAFoQQWBIP816Jdcxgof3862K0npuWD4kdWV36zbDm+Vrp4D9gaIUzK
	 08M40d+2gusPw==
Date: Fri, 16 Aug 2024 23:06:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	tiwai@suse.com, perex@perex.cz, amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
	andriy.shevchenko@linux.intel.com, cujomalainey@chromium.org,
	lmajczak@google.com
Subject: Re: [PATCH v2 01/14] ALSA: hda: Move SST device entries to AVS
Message-ID: <ef967f55-fd8e-4491-84f6-76808d839dae@sirena.org.uk>
References: <20240814083929.1217319-1-cezary.rojewski@intel.com>
 <20240814083929.1217319-2-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9dkE5JiScp51KwAN"
Content-Disposition: inline
In-Reply-To: <20240814083929.1217319-2-cezary.rojewski@intel.com>
X-Cookie: Are we running light with overbyte?
Message-ID-Hash: CVDSKZPILUVMZPDM7CH2CBIK7FHCFVW4
X-Message-ID-Hash: CVDSKZPILUVMZPDM7CH2CBIK7FHCFVW4
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CVDSKZPILUVMZPDM7CH2CBIK7FHCFVW4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--9dkE5JiScp51KwAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 10:39:16AM +0200, Cezary Rojewski wrote:
> The avs-driver succeeds the skylake-driver. It suppots all
> configurations of its predecessor and more. Reflect that in the existing
> selection table.

Takashi, are you OK with this?

--9dkE5JiScp51KwAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/zVYACgkQJNaLcl1U
h9AlDwf8DQk9L/552nT1Wvxyjqugf0bkMVTlBbquu2pfXp/zMhOiFjZ07Fpq5AEO
FMS50p2TaKC4RS5G/goMEPoCFlkz2lIAvSKbfM/av6XyA2ivbVZPKdF0YApAhJRb
60rKPiBXM2VMNP126PWm0sk4TjF36IAP0Ej0rig9nWHqfm5jKzWmSxqCOq11qWmm
zri2l/9MYgKtLTvOQnF4zzIXo9RO888i7H2pau0kZJwHbQ0v0S7jjtBaki1kbMIg
0mE1VUk/JM+Om7NXg2dyfAHUUHTvPNK7EZomOx3ZcSnLTJurRfTfjm/hAGdzMvAP
8SXysufSJU6464knp2QApK4q0lDzJA==
=H7hQ
-----END PGP SIGNATURE-----

--9dkE5JiScp51KwAN--
