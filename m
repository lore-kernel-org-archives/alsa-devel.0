Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9061C41535
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Dec 2023 13:13:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D302B843;
	Fri, 22 Dec 2023 14:12:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D302B843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703250788;
	bh=xS/5BkwNjiV5hpdPugZJOwMiBhSFW+hk0HU2Bv6voh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZgQouixMzQ6jzgYRYk5wQ0/LP35f9I1B1VsxUen1xXvLY3hS0TLUZmEiOXYTEa/an
	 12nxBf1Xij+6FbD+irGonc/kwc8Bk/t42qj/5mP3NNRY/ZrLzlfjZQu3HqBfZFBNim
	 K2/Ma7c+3qmI1HGlQqB+wcHr8zRydEn0o0YugJQ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C596AF8058C; Fri, 22 Dec 2023 14:12:35 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F09BF8057F;
	Fri, 22 Dec 2023 14:12:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9780FF8016E; Fri, 22 Dec 2023 14:12:31 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9B511F800F5
	for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2023 14:12:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B511F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pdxtu3RV
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F3097CE1DD5;
	Fri, 22 Dec 2023 13:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B373C433C7;
	Fri, 22 Dec 2023 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703250741;
	bh=xS/5BkwNjiV5hpdPugZJOwMiBhSFW+hk0HU2Bv6voh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdxtu3RVRyGkr7oHJwIx469kclPpWiKmkQsLgLwoeOgAV8kj4j1Mp3hZWfDCQIXjV
	 Kq6u/c+mAXgNReDmX9lpy10wUcVwNGAN/sBxUG4qovAz+7fMFwYJ/N1KNZE5IsZzT1
	 iqmEwHbbVAaS+tU286mq4vuUf6bCJB+wj+iYCYfMWfJvbVkxJSArWwplAu4lR/oVKq
	 gtCLgNf9Uldggif9zfA4ow/JLeD3ouBciDd8VPld3VuLcztt5NzWeH/QcEBv/U5esV
	 x2miXDH7ckIPAs3QaNQH64AK5/HbLzLQzExPSaEzhazvgIRmDy8O7xOPi7U0W7hhO6
	 Uhl9ScBMFsSCA==
Date: Fri, 22 Dec 2023 13:12:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: do not use regcache
Message-ID: <59d1b8c5-d57f-4e0c-a083-2afa1151823b@sirena.org.uk>
References: 
 <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XgMk3W0ruc1CbKKK"
Content-Disposition: inline
In-Reply-To: 
 <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
X-Cookie: Familiarity breeds attempt.
Message-ID-Hash: I3EUT57S4W2SALOIWD5YUA52CLRKR7CK
X-Message-ID-Hash: I3EUT57S4W2SALOIWD5YUA52CLRKR7CK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I3EUT57S4W2SALOIWD5YUA52CLRKR7CK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--XgMk3W0ruc1CbKKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:48:56AM +0100, Gergo Koteles wrote:
> There are two problems with using regcache in this module.
>=20
> The amplifier has 3 addressing levels (BOOK, PAGE, REG). The firmware
> contains blocks that must be written to BOOK 0x8C. The regcache doesn't
> know anything about BOOK, so regcache_sync writes invalid values to the
> actual BOOK.

Acked-by: Mark Brown <broonie@kernel.org>

--XgMk3W0ruc1CbKKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFiy8ACgkQJNaLcl1U
h9BUmggAhajnsdiUj4Nk7Jcnz2WIP3eRE2vHqZPTJhYsfkBd7u3Yn9DMdoH0goPc
UcxQT53S55+f6UNFGS6NcrDs+h3iM0i5PIfrfCSMCdIuYs+87yGJhITecY/cT828
JYN7tDEHav3SrMdpbEqtEFpSUhyaoRkxCN3l/e4RP5Szi4uYGtqcxAXP7xR5HjsJ
fHwyDCYucrE5cBDKUCkhInxWVP5X2pxrTN9KbgRYuc3TTKW05q4AeRKObrHGuDlc
8kIoxdeyzC8Kp30037CJdJftbR+Zolyy4s3WGpMugFSuJvizSVqh/pIS1Y/cA5Mo
IWOo4LBa+sesOuYFbs2nUbhdTB5sLw==
=Z9xT
-----END PGP SIGNATURE-----

--XgMk3W0ruc1CbKKK--
