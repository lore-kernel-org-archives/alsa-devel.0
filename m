From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic: add generic compound card
	with DT support
Date: Tue, 31 Dec 2013 12:47:37 +0000
Message-ID: <20131231124737.GT31886@sirena.org.uk>
References: <20131231113138.102044cf@armhf>
 <20131231115927.GK31886@sirena.org.uk>
 <20131231133610.2d14bc29@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5577314776996342028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CAE5B26171B
 for <alsa-devel@alsa-project.org>; Tue, 31 Dec 2013 13:47:40 +0100 (CET)
In-Reply-To: <20131231133610.2d14bc29@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5577314776996342028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EzyTiZo8w1pFn3ee"
Content-Disposition: inline


--EzyTiZo8w1pFn3ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 01:36:10PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > It would have been useful to have provided that feedback at the time
> > rather than waiting until after it had been merged - it was in review
> > for long enough.  It would also be good to articulate the issues with

> Sorry, I spent a lot of time on DPCM, and I was not yet ready to propose
> something when you accepted Kuninori's patch.

It'd still have been worthwhile to say that you weren't sure it'd work
even if you didn't have an alternative; you could perhaps have worked on
it together.

> > These are Linux-internal concepts which shouldn't appear in a DT binding
> > or at the very least need definition.  One thing to consider here is
> > that these things are all about the internals of a SoC and you'd
> > therefore expect that they would be defined separately from the card so
> > as to avoid having to replicate information in every card using a given
> > SoC.

> Do you mean that, as DPCM cannot be in the DT, there should be a
> specific driver for the Cubox audio card (Marvell Armada 510 + NXP HDMI
> transmitter)?

I'm not saying it can't be in the DT, I'm saying that this doesn't look
like the right way to do things.  For example we could have a way of
specifying parts of the card separately so the SoC can be referenced as
a whole by the card, or we could have the internals behind the DAI
hidden from the DT entirely so the DT just links the DAIs together and
the SoC internals come from the implementation of the DAI devices.

If you can't figure something out a more specific binding is fine, but
if you're trying to do a generic binding for everything then these
things need to be considered.

--EzyTiZo8w1pFn3ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrzmAAoJELSic+t+oim9ekIP/2NFKTxQXIbe4FrUiL3x58r7
Z/Awu4SJpxrCs7/6oRnNCPH54hT8S5cRZZX0aqzLOxwnFLGDzjD9hugGTZdYlvCd
lKaVxLCFKwI/dxc/krkOi0Fmes+1itSMCmG3imBr6UWPozcHbo/gzLjb656SYtAR
X58wA5hd/0EY3lA49JDZx2KZNnMLcubA+UgOlbWU1gr2FGdplIsknOhBvtU/WIp3
KxWMbbJU/xbed02/HseOgv3CdCqx98ngt7CvwS2s5+ZZFKs4RZf+ZDW66nLRkZMC
Fe/1p2mD81Y8HGwjJNliDXt+fyfOLCrN+pfYeob6Nqz/yyUsF5rZmK/wfBYdBLr6
6eY3jHufRmw3QuoaKcoCB7UmSFZKyADX2DjKnSYOshlMEdpJf+J9SfMmI0ji60Mn
LaUUySRYy03W/2eMmT+Q5wi0BEIPB8uLqLk4SbERPIm+0r09Lz+i1HfBQDhxrnQn
7Dbf/k/uGrpDVCgdp92NsVXyiy8qrlEgjjgJlhAsCTJZl3AmI1gB2pE2yN2ksvqy
FPCWc/hWjgSIanKQXAi8tk09vWvnjoDHo45cIFEWOD6WlGK668MiZLRCdHvc+UxZ
MG/YLvSwBcyFJy9q1FRjh2znfHlXyhLbhW8CVD/sjotap4eLvWKAECKcN5kkt25P
V7c4i6aU91UJpU+rGbX4
=prZY
-----END PGP SIGNATURE-----

--EzyTiZo8w1pFn3ee--

--===============5577314776996342028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5577314776996342028==--
