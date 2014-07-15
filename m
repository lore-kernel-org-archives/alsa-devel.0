From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 00/13] add mrfld DSP support
Date: Tue, 15 Jul 2014 10:54:59 +0530
Message-ID: <20140715052459.GD4387@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140714185059.GA6800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2414977723379680816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5682D262626
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 07:28:21 +0200 (CEST)
In-Reply-To: <20140714185059.GA6800@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2414977723379680816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2014 at 07:50:59PM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2014 at 10:14:44AM +0530, Subhransu S. Prusty wrote:
>=20
> > Here is the patch series for adding DSP support for Intel's merrifield =
platform.
>=20
> Hang on, I've also got a patch series from Vinod sent the day before
> (ASoC: Intel: sst - add the merrifield DSP driver) which says it's doing
> the same thing...  what's the story here?
Hey Mark,

You should have two series in your inbox:

1. "ASoC: Intel: sst - add the merrifield DSP driver" This is a 7 patch ser=
ies
sent by me.
Just noticed cover say 8 somehow..
This add a new DSP driver handling IPC and DSP fw loading.

2.  "add mrfld DSP support": This was sent by Shubranshu. This is v2 of the
patch series posted few weeks back by me incorporating feedback from Lar's
This 13 patch series adds the DPCM and DAPM widgets to handle DSP toplogy

Yes naming could have been better and more clear, sorry for that

Thanks
--=20
~Vinod

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTxLsrAAoJEHwUBw8lI4NHjP0QAI9ZhOl8LXFaFVz76veV8/En
KSTykqWiEKY/j6aP8cHaIUFxJQ+K7zQTifIunET/ytagFw8RhTa560zXlo/00NNC
pL5hhb5vS0kqAVIvSqqHq0OdwpRwDnYBI4/vcr4ZUYiER6SS/WwhzfCk8hRlObiC
i1vFan7WmTCQ38yhqVjZUqpN7GnzFJKWzy4DM70vtmmTmOIhyYMB/Xb42jFMoPjT
wKLVh9yqfd67K4y/FJ9YqkO2xZHvdvzArwOiUSGyXf6nzLkVBAOgISG8OPrDN+dB
Jx2xly6T+nFUiHVhk2IewhW5Nt32KZ3xQLfvmbo7j/lxc1jbxkzNdGEAcPAWQzrx
fQ+z4tnt4Iu09HwxLWL+5JK9+hFSIvbAQufhMQsTApybLzBynJ58aZ9fs/HKpuCw
HGxkAQdwZAOVy3r/lZ7jaivU0iZEGvRQqfojP1xtlx74cgiMDKYm8GhFHVrkA5Cu
aWCC8pjfmSqul/U6+oaMdw3E6zSOsMAfOiRjHVM9b1F8nOAWlAsR1jp7o+kV8VQ4
ma/wurouAh9XvMCWZrditVEbmo/Iu+MW9JuCq0wqeGMHt7mHrRsNnLmidN1ydAQe
UbbdrWGw1JJ6B395tPTQvL1f14nSd9ke3tnDPiHYQU7YNOlm1Mmqj+82q0yHroNR
KC2tjGpFZ6zJThXrAqP1
=IniS
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============2414977723379680816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2414977723379680816==--
