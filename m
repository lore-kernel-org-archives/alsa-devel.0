Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50AC79F99
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 19:20:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17C8F601E5;
	Mon,  7 Sep 2026 21:20:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17C8F601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788808855;
	bh=B2X4bWGMk/FhaOtRzqPtbwCBIe/I5ub1vzMOSMrZ/dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C8xypPrerYeIvCyOv68AQN5lt1YwDVzweUX9v2BGfjkPH1HXmKT7Fw4DEi0TRfJ3K
	 xXIwj8ZwrG7NfHZdocGUvkPMicoy7wVZUc6Fm7u14lbtQ+PWRjM/FnVQF8B7J76IoA
	 1IdY2DuxS6stqFJbxF3OCEJ/0t1SWE+go+K6IgX0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CCF8F805FE; Mon,  7 Sep 2026 21:20:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E413DF805F9;
	Mon,  7 Sep 2026 21:20:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AD10F80571; Mon,  7 Sep 2026 21:20:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788808814;
	b=Cye1i3M1Qcn+5RMlWm9cqUbveUNj29XHkf/odAnrJjoVHIXNpsgRBUCML1cVODJglACg
	 4HOGTQwPspOKBOjizdUUK2dIIlW/8mhtnJnTQJwjV9DGgWFEOVxDJlJ06Szm+pkPer4O0
	 0mxIR+rXyoIG8cwgC0jCDFw40ri3FellNue20cCIx65bRDj64lIj8kXKwMZcexOzlvGBQ
	 pHvroiXv/ALQ0oYFmKjM5mkqyrUsevoX6nRZDRW3HHq3goJ4SlczSisj1Y0oNA0e9P2t5
	 zHWM7PHZWyICfXOmb8JtQXfkp6b0V+9ntnDS83T5JH1FrznEuPBJyD1ZYNhJ2Yf79tw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788808814;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=B2X4bWGMk/FhaOtRzqPtbwCBIe/I5ub1vzMOSMrZ/dE=;
	b=L/rOqZd9rMQ2Vlxr2pMAkvfUZ51Rmj1SAKaFcjOs2cCQEDAWAk4m5y2bgnFeznLKZGtg
	 B2dB98VaA0/Fl37rGvmGy4z3PyCy9vDBybsRKJ4GEPNPn4IM4wA9nxeskMS5F6PcKqa+j
	 DajdxYF8pu4K+7soZhyHRFSCVKfk+s0/SEYDoJzvJlHzX4XMjg7DI3bPujqUEJKn0Ed7a
	 KdB1ei7jww5lsM1Gr9fhaDhwWA0VK1bJTK70Dhj7sCky1KOHCiVHd7Eus3akiFd7B3dxL
	 svjhj2ks98Kfmkzx26ya7eLsWYL4OOEkkZvnsus8+W1DhLBBX1nBchkzXDbcMc70OGw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QaR7vrOi;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2F9FF80088
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 21:20:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2F9FF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QaR7vrOi
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE08E4122F;
	Mon,  7 Sep 2026 19:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B101F00A3A;
	Mon,  7 Sep 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788808809;
	bh=MBF954dvFmkhgI0aFSJi7k7vhmBty1EC28SfxK4YPSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QaR7vrOijinEhd9KEUPySAQE3a5WYYOYaTpktNd01h4PBTdOoQkU6YsCp7p5g/BsY
	 aJwOxHZY3o1ftkakOMn1ObMgdgNw0emPrxgS+f+HDR707+J3NtHKfVJ1jIi1oPPs+h
	 4yeGJ60ThUsimj53ngWWMom4pLdSutXUP8DZNpics1uAwNhw6Qq9kIGpk2JEZ4hze0
	 m72fTjg3Y6PkDfxCTRqp8EX0oEFOnVJPri/3WR3D9O2CvA9pdCdwY2e975FaMcu8d3
	 WQwN/zeCQDNFMzniwOwoyk9BCjUExOKRwSBZxgRpv4hHDBPJT/zkMqf2UJFfuS/lM1
	 hFbG8MAS4m53A==
Date: Mon, 7 Sep 2026 20:20:05 +0100
From: Mark Brown <broonie@kernel.org>
To: David <mafiatamilan@yahoo.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: yc: Fix internal mic for HP board 8C30
Message-ID: <0b298bc2-ae48-4e08-823e-25be3ce09382@sirena.org.uk>
References: <178867857905.85694.5014721659216165123.ref@yahoo.com>
 <178867857905.85694.5014721659216165123@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jp8fH7H7p8UsvJg1"
Content-Disposition: inline
In-Reply-To: <178867857905.85694.5014721659216165123@yahoo.com>
X-Cookie: Who's on first?
Message-ID-Hash: RIOMC3BUZ3NNUWK7ZQAL66WGNKMZY42N
X-Message-ID-Hash: RIOMC3BUZ3NNUWK7ZQAL66WGNKMZY42N
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RIOMC3BUZ3NNUWK7ZQAL66WGNKMZY42N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--jp8fH7H7p8UsvJg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2026 at 12:39:39PM +0530, David wrote:
> The HP laptop with AMD Ryzen 5 7535HS and ACP 6.x coprocessor (PCI ID
> 1022:15e2, subsystem 103c:8c30) requires an entry in yc_acp_quirk_table[]
> to enable the internal digital microphone (DMIC).
>=20
> Without this quirk, acp6x_probe() returns -ENODEV and the internal
> microphone remains undetected.
>=20
> Add a DMI quirk matching vendor "HP" and board name "8C30" to enable
> ACP DMIC support.

Does this already merged patch:

   https://patch.msgid.link/20250715031434.222062-1-queler+k@gmail.com

also get things working for your system?

--jp8fH7H7p8UsvJg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqfDmQACgkQJNaLcl1U
h9BxRAf/cCwAPCz7cNsbjofRRmDXMH/m9AKzvJEsnuD7GpCSiicCsjawdk7l3AOb
IkmiHFAUALP+2WB+7c0iptxSXLnz1VR8CEsb2WRYDsgrTS5K9FKIOfHeJEK5D429
VC+XjJ+Adw72DDPpi55/it6s4HvnAzIZg5nVbXkteBvfeeLJ0SlzHjLTgQzqkLok
ePAnR8sL9KfacqImhNCZ0LwWJi79SNBmi7Rn9BIV7kuLIOCV7zXJUWWMl6KslA1X
KLPjovqr+zhe14wd5f1NW/F0ZYSI2mUOPPadX2RQizWg0Np4KuSRD1pXM1TRCUk5
ivwrwR6N/q754SDrB7NqZtpzfTXvBA==
=dQrf
-----END PGP SIGNATURE-----

--jp8fH7H7p8UsvJg1--
