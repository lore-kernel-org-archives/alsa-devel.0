From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE
	internal
Date: Mon, 27 Apr 2015 19:28:01 +0100
Message-ID: <20150427182801.GX22845@sirena.org.uk>
References: <1430131465-17991-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0305493195406260366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09BDD26167A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 20:28:13 +0200 (CEST)
In-Reply-To: <1430131465-17991-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0305493195406260366==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2d6RLRichCxkoQyB"
Content-Disposition: inline


--2d6RLRichCxkoQyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 12:44:25PM +0200, Lars-Peter Clausen wrote:

> Whether residue can be reported or not is not a property of the audio
> controller but of the DMA controller. The FLAG_NO_RESIDUE was initially
> added when the DMAengine framework had no support for describing the residue
> reporting capabilities of the controller. Support for this was added quite a

Applied, thanks.

> This patch makes the FLAG_NO_RESIDUE internal and no longer allows audio
> controller drivers to manually set the flag. If a DMA driver against
> expectations does not support reporting its capabilities for now the generic
> DMAengine PCM driver will now emit a warning and simply assume that residue
> reporting is not supported. In the future this might be changed to aborting
> with an error.

I'm not sure it's ever going to buy us anything to error out on stuff,
it's not like the no residue case doesn't need to be supported anyway
for controllers that just can't do it.

--2d6RLRichCxkoQyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPn+wAAoJECTWi3JdVIfQOB4H/Rer9AFGVhfNySxaJ8a7HAbb
5BWXENFiJiUhS/8II3Y0AeWVM8ZZJ/+dqEmAeM5tRCI0nmhHURn+Z7EDV755iehD
K2+cTo0fOwzz8tV1i7plFYDMK+h9y3qiMsQ7ZFYbjWOnvLHGdZhprVsF0vt8/XDU
9LEn40ZYyq9/MlvUow9W0PTz8M47RjHEa8pzLxakvcTrZZR6zlv9fNt2WI/a8nFJ
PYZ3AY0fBlckOJDBkoh80jn6VMJZCvKK/2F013uvTZnW/WXTdGHtCUdbIKFG7X+X
DDe8JBsxLEWf2idO4JGJrEzWIy8R+CUIjQnVQUyFa91CitScC4/5oCardCGlZpI=
=Kzrr
-----END PGP SIGNATURE-----

--2d6RLRichCxkoQyB--

--===============0305493195406260366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0305493195406260366==--
