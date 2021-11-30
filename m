Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A68CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 15:17:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9B442276;
	Tue, 30 Nov 2021 16:16:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9B442276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638285452;
	bh=CsuglpE/divFk/5CQWjHUMB7KiYZRmVgd/wkp2Q8Q44=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dTYxIh1HqvUgru7VDCPpauDEk5le9uDb7xGfxellwwfxb0poWBOl8SsoEm6Z25SKW
	 I6pdV05pa2X+1KghWDyA5qlHjVuMUP1hSHCIf+S7nfYj54ihO7LOBPyVvl44Cde2wm
	 SXaAsacTAnm17+gBsqTpiX+6TZ25Ci8ounn/POeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51E84F8028D;
	Tue, 30 Nov 2021 16:16:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99587F80290; Tue, 30 Nov 2021 16:16:40 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79493F8020D
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 16:16:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79493F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hl8pDsVk"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E1CE7B81A1A;
 Tue, 30 Nov 2021 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4884CC53FC1;
 Tue, 30 Nov 2021 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638285390;
 bh=CsuglpE/divFk/5CQWjHUMB7KiYZRmVgd/wkp2Q8Q44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hl8pDsVkBR89t8Weo7V3jLHabABj06Xa+cUu0TUExCcDe6bkpcmHo71IF77u8mp9O
 LrSanYUkqr4rsCO/qakHXAKyhJ8xppn2MNZDTtdmD3Fca0S28aw2g52TwYTWfQsKSS
 b23452oHk8nMshc8Spg3e7l5KCuiI1DYMSZ7YF9azPK6Oswgl0NhAc1XZqqDlFjF/l
 rEuJAJsy8r9PXXWNjk/Nsz4ukHkzSaprOf4puA+DnZ1sXjbmH6TpL6ZqA2/4sIx/8H
 jWjX3kaf4jDBSkxzRDZQdMIbQh/904d5UMNph8YvQgDmo6xVW/YnwpazGBjMkQAbjB
 fu3sZ5oT3afoA==
Date: Tue, 30 Nov 2021 15:16:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.15 01/68] ASoC: mediatek: mt8173-rt5650: Rename
 Speaker control to Ext Spk
Message-ID: <YaZASLLyOC9EwnMs@sirena.org.uk>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EpYEx7V8UqnZBosf"
Content-Disposition: inline
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
X-Cookie: Check your local listings.
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, stable@vger.kernel.org, tiwai@suse.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--EpYEx7V8UqnZBosf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 09:45:57AM -0500, Sasha Levin wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>=20
> [ Upstream commit 0a8facac0d1e38dc8b86ade6d3f0d8b33dae7c58 ]
>=20
> Some RT5645 and RT5650 powered platforms are using "Ext Spk"
> instead of "Speaker", and this is also reflected in alsa-lib
> configurations for the generic RT5645 usecase manager configs.
>=20
> Rename the "Speaker" control to "Ext Spk" in order to be able
> to make the userspace reuse/inherit the same configurations also
> for this machine, along with the others.

This might cause people's userspace configurations relying on the old
name to break.  Obviously we're hoping nobody was doing that since
that's also true for kernel upgrades but it seems kind of aggressive for
stable...

--EpYEx7V8UqnZBosf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmQEgACgkQJNaLcl1U
h9C12Af7BOB8qKYgh1ta/a6KlxNqPdnCcPfgt75Zppjx5a+wS5BhWIW8uhF0Bs67
UjGiaO1WRqrfwtcFWXadhQxa1BrpskWt3afgg0KFYtcjf3KFXCFcdVFhdzRMcCe3
SY9eGKabGIsXJdQ18qKRBEPnQ+gXSQbCatqs2cgCgdS07R4nwfFb008U5P3zFysq
PmN9hWOfC5A0cX1EUWPR/zy7qNdFcCEDQu4n5kJTVdpEjKE7lqEA6wy2zw3pQXyZ
dIb4IGxWKyuZ5yt5D0WPX0IlasJvU6QxPxtDgoVYFLhqi9KPivLJJZ82FO2e0Aw0
oZ3H5YPHbUl9/DueY8z+0kk6ZATmCQ==
=q/3k
-----END PGP SIGNATURE-----

--EpYEx7V8UqnZBosf--
