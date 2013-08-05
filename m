From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 05/13] ASoC: kirkwood: provide
 KIRKWOOD_PLAYCTL_ENABLE_MASK
Date: Mon, 5 Aug 2013 18:03:42 +0100
Message-ID: <20130805170342.GV9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63wJ-0004lV-FZ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6548080560973058256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 35F2126510F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:03:45 +0200 (CEST)
In-Reply-To: <E1V63wJ-0004lV-FZ@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6548080560973058256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2O5I9rX0uDw9eITt"
Content-Disposition: inline


--2O5I9rX0uDw9eITt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:26:03PM +0100, Russell King wrote:
> Provide a helper macro which includes the sum of all enable bits in
> the playback control register.  This simplifies the code a little.

Applied, thanks.

--2O5I9rX0uDw9eITt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9rqAAoJELSic+t+oim9Xg4P/0xECX/O+AeyIaQV4voQdcyX
qLVWnXnpvbdJ8VpPBAj60N1XuIs9d/yC6dJfu8kIxQxJ5PsHYy98mDUExHRtSe/9
wVA+IqHE/k93h4aYt8IaUS0fDTyL0IIcxZLuo6kadrMAeScWVHqc/5ou5fPBUP0C
N56HPpreqFj6vo4wqmt4coldi49GsX69lB8uNtqKQKTHM7zUw1TzJZLG3nxGI8NE
jCpX2h5/zH/KbcqGc8i+5XTKCuCu+BREe2N42seSfJM3KS1DVowzrCjAS7iIy4DN
2hya58o0TS6w5ElnXfkYJsH/HMAoah2eKdaIyejYDZbz5xJYZNF5FvayuIX85Pp0
whjgnxrCSO36iSdfFQ0L82qFwX2OQx0xq0HVJ7yJKJ9ivDeXVtRjqG25JIuS2vZC
PDFdOkB0SJ0JQwlZtU+zN7DgJoBBCJuDCVbHb+H8bqTBNafvod47OxXHpSkMWpIC
fKbrjgENglksxR4J7ffiUy7Y+eVkf/eXSq+NMRKt/Wq8h522akczS5d/xyABZaJp
1Tk0UCxWpTc4K+X3FHL+gyqaWgAYpQ3hpBKNF5pM1R5//ZKVfk4dJQ6tQMYFiJUK
a2L4vWQk7SdUf729oD78Rm9/fQboA7ENTqFxXThr2ljVU8mr8GUy0I5+ibU6GE9l
wjdpN58eZWvpwRPO+uau
=4yLj
-----END PGP SIGNATURE-----

--2O5I9rX0uDw9eITt--

--===============6548080560973058256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6548080560973058256==--
