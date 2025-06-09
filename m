Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2639C5B552
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:17:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0F1060200;
	Mon,  9 Jun 2025 14:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0F1060200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749471428;
	bh=6Kag9Ku/q13qtFPk6HDqeKqGdosUpBqql0sD8SctYbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U2VbghR342ZRaE1l1K/jjMYdAZvqMhv7iXvyKq6g4W/Odzw4lycAvtU424X9f/WIz
	 diebtyCUJxJSotPcSoJuvCUSNDapUjg7wM4yXjcliWTa8+lBTIqE5JpB1bOv0zSQdk
	 9ifNrR6zSkKjRUdCf4oEpk0dFCKWR6eMO9P6vSgo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CC46F805C8; Mon,  9 Jun 2025 14:16:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47669F805C6;
	Mon,  9 Jun 2025 14:16:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FC71F8049C; Mon,  9 Jun 2025 14:16:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C059F80038
	for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2025 14:16:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C059F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G57svMu4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C9CF4435ED;
	Mon,  9 Jun 2025 12:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D2BC4CEEB;
	Mon,  9 Jun 2025 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749471384;
	bh=6Kag9Ku/q13qtFPk6HDqeKqGdosUpBqql0sD8SctYbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G57svMu4nbKd4CGPIIngocdVOTrkAUN2YwFX8F7ErGjGJ8ZHbdF6YLpEBbRafVySE
	 QJ28QcahJxmJViIkpS4bBaHTvuwzt4EQsONnjWd0J32GVZdWjf3ufqgYsb/Koy7qux
	 qPEAdlhB6Js9aUsZV/Du0Jjsgo4PpFKlL4nWoKB07pwH9gSMvED+M7UM9u/ekH9mvE
	 GjK326HVS2aWOc/Ar8Hp2dAU10K2/p6+5HoWQJcQ5FRrANjqh9By7gtenAkHKRXyLr
	 XVkI5BvlbINBDQncumjMjY7oRtv653X32dLdSeYBCHTAtmCtuf/oklydofgageUk/w
	 xRU+iG/mejHPQ==
Date: Mon, 9 Jun 2025 13:16:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	syed.sabakareem@amd.com, mario.limonciello@amd.com,
	yung-chuan.liao@linux.intel.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Fix pointer assignments for
 snd_soc_acpi_mach structures
Message-ID: <ea8fa344-0429-4dca-80a2-aa792128576d@sirena.org.uk>
References: <20250609121251.639080-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HYjgf6wuR0aqqtNh"
Content-Disposition: inline
In-Reply-To: <20250609121251.639080-1-venkataprasad.potturu@amd.com>
X-Cookie: Restaurant package, not for resale.
Message-ID-Hash: XA3PO5DJBOZWHYD7KTF7RZKJPI5U6ZQH
X-Message-ID-Hash: XA3PO5DJBOZWHYD7KTF7RZKJPI5U6ZQH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XA3PO5DJBOZWHYD7KTF7RZKJPI5U6ZQH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--HYjgf6wuR0aqqtNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 05:42:32PM +0530, Venkata Prasad Potturu wrote:
> This patch modifies the assignment of machine structure pointers in the
> acp_pci_probe function. Previously, the machine pointers were assigned
> using the address-of operator (&), which caused incompatibility issues
> in type assignments.
>=20
> Additionally, the declarations of the machine arrays in amd.h have been
> updated to reflect that they are indeed arrays (`[]`). The code is
> further cleaned up by declaring the codec structures in
> amd-acpi-mach.c as static, reflecting their intended usage.
>=20
> error: symbol 'amp_rt1019' was not declared. Should it be static?
> error: symbol 'amp_max' was not declared. Should it be static?

It's fine this time but these staticisiations should have been a
separate commit since there's no overlap.

--HYjgf6wuR0aqqtNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhG0JIACgkQJNaLcl1U
h9Cbnwf+LTWqBSmB2IAuSm6C+Tsj8O1H9Sjadg20290UFCx8Xw5HsOaBhAcGHs4Y
78jk6uWG6cPTWhqcC2gKp6PZIEkxL7tgQfuuHpsCkuaMXvmRt5v/tCGBUGDb8nkH
o3+NGhmw/iZeRb7rsTKXez69JMd0sMjiVy/z63mV5YsSa5dWKkFGo6p8yIgkP8i/
8oHNww9aPdRjT95ytzs/4QZjUYdq0LV79UXoMBy+TmmNwwMM4516fAzLNI6DRaw8
oJAAwtcXdVUikL8NqtGBUruAov/QN7+IkrDNF//U8k1C4dRkCsb3+QsD0ppGRmjQ
catCRSaVvm5EUuEyIpcpCfYdCE5mGA==
=Ko9S
-----END PGP SIGNATURE-----

--HYjgf6wuR0aqqtNh--
