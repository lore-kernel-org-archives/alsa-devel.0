Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E440C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Feb 2022 16:03:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B92A6185D;
	Mon,  7 Feb 2022 17:02:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B92A6185D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644249819;
	bh=VHu3eNxqoB3m5wKXUbuxf3kb1eYFWyY5p39I32TCy+w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MHdEOKnY/2sHSvWiVqG5roB7W8OlHSuVj7KU2Tgq9l01jLnPhzzGpnBs3Cumwgj1l
	 fnntOTlOZmegJ0TJcErx/INfqpz/riataLSMvxRUiMoPKNsE1BwEo+OjLwj8aY9qnz
	 koT+I6yQ5II1E7B8ob6i0zl5NovmOVOjEBHG550g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51A52F8023B;
	Mon,  7 Feb 2022 17:02:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE99CF80240; Mon,  7 Feb 2022 17:02:47 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA4A6F800E9
 for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2022 17:02:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA4A6F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q694HF6p"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 0E9E8CE113E;
 Mon,  7 Feb 2022 16:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C14C004E1;
 Mon,  7 Feb 2022 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644249754;
 bh=VHu3eNxqoB3m5wKXUbuxf3kb1eYFWyY5p39I32TCy+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q694HF6pbf7wKoZQ+PkurVUl4V7pQnl28bpWKs5YpUiHrK5tdYKoX+kymmrVBEACF
 hitVW4kLdvoaSW/y7gjhb4sOSWemUiVQ/iGISkSbOYn9e97E78I1hbaHXbQatbkiY5
 0fMeANwWUNGu4ZLnWGB7EergbRQYCMZ8AIq2aTppsyhvbHJMa6OSAR6dSWrtddilLx
 V1gafm3vJrDNETkR7fmMc/kcINkuerMMbRpfUbJs3jx476+qL4Kzjq9MjzuM7bZ7HN
 q++6xugAEypExf1M9jXwFu5CauzHewDe002rXhQcE5wyLYLgAaUtLLpsc5efjk8UWv
 kVcgqdGv7vQSw==
Date: Mon, 7 Feb 2022 16:02:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] ASoC: nau8822: export right speaker inversion
Message-ID: <YgFClQRVX5cX6L3J@sirena.org.uk>
References: <20220207153229.1285574-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r8VUl2Y94+YeSmzF"
Content-Disposition: inline
In-Reply-To: <20220207153229.1285574-1-francesco.dolcini@toradex.com>
X-Cookie: Never give an inch!
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Max Krummenacher <max.krummenacher@toradex.com>
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


--r8VUl2Y94+YeSmzF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 04:32:29PM +0100, Francesco Dolcini wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
>=20
> This control inverts the signal fed to the right amplifier.
> This allows to connect one loudspeaker to the two speaker amplifiers
> in a bridge-tied load configuration getting higher output power.

Is the value chosen for this not going to be a property of how the board
is wired up, in which case it should be handled as a DT property rather
than varied at runtime?

--r8VUl2Y94+YeSmzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBQpQACgkQJNaLcl1U
h9CYDAf/aov1CJJ+o9xH8uCLnykL8o5T9dEM+s3pVJPZQjGOZ1QfaDMCB6S6B/nT
4Ay8zhkya1HmNJvea9mGVXcF7VPPADooVafB+TYeusX27S1rsdx51dHmRz6TOody
jmznANZ98teIeHOwVQ65vD/TQD6iYFP8KGdQirtiJTj4qotHjHqu5rigxMUvCIy4
1wlj/FER/OOEF4hpeEYcTVAbMmjPOE5R0C8vo7FYwAJe7yLtXXbZ8b3JFyhrkWrQ
6NyUyk3G3ZY3clK6VgaIXUVxTay12Ibv0hYD1tOjj2P+WQ/3vEWkZJmgdyECpr42
eTsgPJ6xGz3c6mmmiOFck3beqlXuyQ==
=d71K
-----END PGP SIGNATURE-----

--r8VUl2Y94+YeSmzF--
