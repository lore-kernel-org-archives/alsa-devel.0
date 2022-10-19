Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B331C43217
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 15:31:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADB3CADC3;
	Wed, 19 Oct 2022 17:30:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADB3CADC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666193485;
	bh=KbpFf17Fs8uesDt4MwO+iDiMglDae99et8YXveCfYBE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pigd+OjX/6knBayFQWLPvoRhi1YjI8KT0b89Qw6J48KKm8G6P6GRyo4n12w3uuCkI
	 ii04OwEPoF4xXX9NhwRC1aDmMvx53GwxxnNUeUZN1VzG9Oo5gcGrZWVKpEMt1g0bVY
	 avXIKJkuRV6dBQ+ORtYeLaYL7xQFFlSn+AlutAaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6096CF804CB;
	Wed, 19 Oct 2022 17:30:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E2CCF804CC; Wed, 19 Oct 2022 17:30:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64753F80137
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 17:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64753F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LnOfM73E"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B508FCE20F4;
 Wed, 19 Oct 2022 15:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23CC433D6;
 Wed, 19 Oct 2022 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666193412;
 bh=KbpFf17Fs8uesDt4MwO+iDiMglDae99et8YXveCfYBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LnOfM73EzfDc9csGyPs8AZcppDQrpgiFd1XhABH42Yy/zOgDPSxgQCzdcPhR40+un
 4Uqy7Detq9i1YMNUwRthH0GB5s9EEz7DfqS1xSjUh3nlj5LOLBNwgUHf8kr/+Zc70B
 s+y0fZWrrH8WVO0+ULO68efbdyRJxOFwL+NNgX3W4hF2gH4Xkz2ylRRKKGvT8rXvte
 zRXVetAVhXBKODkkJ4QvYxt6q8K0+P/IyZPYIo6AR9NmBfZWkp5Ae54Rkeyl9QJr+J
 yzfMZbzlzTkEm4E44Aw/i2i3k1hMMsQUVwBBVuV/ZU/GEuhWgZueiAhNtCb62pPvd+
 EPD7V/iZBpFoA==
Date: Wed, 19 Oct 2022 16:30:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 05/17] ASoC: remove unused ep93xx files
Message-ID: <Y1AX/AkUwKFCOQ2T@sirena.org.uk>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fa40iDI1U45x1LDe"
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-5-arnd@kernel.org>
X-Cookie: There's no future in time travel.
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Ryan Mallon <rmallon@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org
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


--fa40iDI1U45x1LDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 05:03:27PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A couple of ep93xx board files were unused and got removed, so
> the corresponding ASoC support can also be removed.

Acked-by: Mark Brown <broonie@kernel.org>

--fa40iDI1U45x1LDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNQF/sACgkQJNaLcl1U
h9Cn1Qf/XqU894hIJIMkbghx6OOqUvxAGU4bdRqR5HCP6qB3XxFB6V7nbadpabwm
0JZqSHJpOn4oRlNmnD8kUI0U0PXZ1QfJhq0oPlBNCUU2ID03VKBDdD+wxkNRF//9
gboL6JJpVFI3XDOkmxZzFozUFF/56Y3HDF0aqdt+uX6zdCSTftJm5FjJVWHqEaD8
5EmijSrlvOsia0jVg9fTlucQKPYrdpBntDOy07jD0UZiA2NQjnoAhkOUBDcgQJar
dRB/gjX3t7zsf/Ycciz3i03IedU2nc26uvZJxEG39/I5GOn54DYhbundTyFmX4ka
z1CkIENotNYGRsaRsWX7HkhAve8sTA==
=4PhZ
-----END PGP SIGNATURE-----

--fa40iDI1U45x1LDe--
