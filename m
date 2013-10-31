From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT
	support.
Date: Thu, 31 Oct 2013 15:23:08 -0700
Message-ID: <20131031222308.GL2493@sirena.org.uk>
References: <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
 <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
 <20131031174549.GG2493@sirena.org.uk>
 <CAHCPf3tt8sbXnABUomg_w1ttBTgBQL=VNwsRoFazzuVdgzzO=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3278992026455906525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E63E2608EE
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 23:23:33 +0100 (CET)
In-Reply-To: <CAHCPf3tt8sbXnABUomg_w1ttBTgBQL=VNwsRoFazzuVdgzzO=g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3278992026455906525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tIZwPmdq+hd82jQ"
Content-Disposition: inline


--8tIZwPmdq+hd82jQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 04:19:05PM -0500, Matt Sealey wrote:

> Yes, I can make a big list and even send a patch, but I think it's
> putting a band-aid on a non-surgical limb amputation.

It would be moving the situation forwards which is something that
lengthy e-mails full of architecting with zero code won't do.=20

> > To repeat myself yet again: what is done to the CODEC here is system
> > dependent.  This includes interaction with other components in the
> > system.

> In this particular use case (init setting sysclk, and bias_level
> callbacks setting sysclk and pll for WM8962), there is no system
> dependency except a fixed, unchanging parent clock (it's fixed at card
> init and NEVER updated) which the DT binding can solve really easily

That is the chosen configuration for the systems you are looking at;
other systems do exist.  This is the nature of board specifics.

--8tIZwPmdq+hd82jQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScthDAAoJELSic+t+oim9bI8P/RVPwzwgQ51Z65GdjzS8hUFF
L4dwS9ubWIjq6yJcKwRR1vFLxmjN9HgpKb9fExQiCzWUr6bj2+97vLXHrG8WkWK6
blAGZY0TmNMannC2HT+osnZ8BQFP/oPstKvtRHcICrxhkg+C/tmymd5lv0fDJGYI
1lqBnK6lp3zgOkJnbN8f0kRD4b99u0IBtfBUsWEXevQyARzrxyElVSXe/A8o9LF4
HC/9WU6/t2chWWcNfxWx1vyxcJ7H/KcKe6V+bQUY7aht7prqiIUmtNbX/hCgqVG9
nm5G57WLhNKsb1+VUUoH4H+GadH5KLBqzke4U/xjS0C4p7nl8nOtUbPP26GxAttY
o3210AD9CBW8C6dA2uNZevsSkgBGu65xtbt1yJxh1Fgsx0zwaqrlb4rhrzj/bQq5
xffPeAUojzaqHceUsn/H4N0kLIrzUgvgxfuTP9nR0rmc2kL1qItFGIF/BTIOCJS+
imSUMSGYkCQSk/EgTllAEF6+QrQVPCRJ1MERvG2iFukPHhsTWjPZ3BmP2VNtwBFY
u+yKd0zezW8pYDU/bv78g4kinKBQaMaUjYitqDW5zN3yT4fEWL7t/xzq+3EJ5GH/
PEdvBXLHtWw4WX/W0+ry0L6kt927KIarCzz3kjXCPzcbMO4deMcBxg0DZLrkN5uf
2WJuT1ddZcri95ZCx38T
=B+C4
-----END PGP SIGNATURE-----

--8tIZwPmdq+hd82jQ--

--===============3278992026455906525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3278992026455906525==--
