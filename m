From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/11] ASoC: Add helper functions to cast
 from DAPM context to CODEC/platform
Date: Sun, 1 Jun 2014 19:18:11 +0100
Message-ID: <20140601181811.GK5099@sirena.org.uk>
References: <1400415858-11025-1-git-send-email-lars@metafoo.de>
 <1400415858-11025-6-git-send-email-lars@metafoo.de>
 <538397D6.4080105@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7639801159260976633=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D021F265474
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 20:18:42 +0200 (CEST)
In-Reply-To: <538397D6.4080105@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7639801159260976633==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CzAS06hjyJnpEZQC"
Content-Disposition: inline


--CzAS06hjyJnpEZQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 09:36:54PM +0200, Lars-Peter Clausen wrote:

> It would be nice if this one could make it into 3.16. It doesn't depend on
> any of the patches earlier in this series and I think it is pretty trivial.
> Having it in 3.16 makes it possible to use it after the merge window in some
> driver cleanup patches without having to do cross topic branch merges.

I've applied it - as a general suggestion if I've said something is
being punted for a while then replying to the series probably isn't a
good way to get attention for it, I very nearly just punted on this
until after the merge window.  Resending individually or pinging me on
IRC will probably work better.

--CzAS06hjyJnpEZQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTi25gAAoJELSic+t+oim9CXoP/Rj6nNb2Q45WTWUYkYAbI2VP
VYiWlVRvfGiGPc86LayZAOSB3mfHeFgCFMmBjn8/TxDcY/q/4b2t9AZ2w+jF9uua
rVP2iR4smlpZCQ55pcwmJ4qhsofanWa5Uvi8SoGox1mkAuy3bggm2l4dEj0VnRHJ
PcmWnvEnlxMLGDLNXGNLLcg4fQWC3LrYJPsuC+2GFMrgASy/cMEeSYzoULG1JfRu
FILmGrVqynNNdvVRfsh+QmKafBFrslFKxjUqIN/G4mjO/+GT6I6sffun94ZXYvmB
Pmva4BjPNcZRtZe8wE1429PAGBvwLBIsJJNIqub/lGfzh6fE/x4toRh0U7DHGDh+
xoHHfEZXxKjd90uevo7/t8nO6uP+Fueqg0j5fXbo1E5f33SyI3mwtNm0fl/K7oOz
ZBBTEAXAZLYSuUpsImbaftyWDhesZ88bbqVh8ZZABtMrX0hYLSKtQGc+4Nb12FZw
5S/QMtHYowjrMEPKwtmwC/++kkel0W7t73vtiu4ZzSrwfD9P1+x5wZJW32ij0YYP
w3rkkJMFbl6jRDTfJ1TCh+UaqsfjmOfu7TEU3lLyvFkeoQpl/qPWUtTWLJ90v3+q
5Meayu37t+lAvU05c9oA6FcFOvPKOEvra8yCyiZlxP0rzm/wI9lZiF+QeqOhcBDC
huNSfxGpcdAHSXVuqbZW
=LAGF
-----END PGP SIGNATURE-----

--CzAS06hjyJnpEZQC--

--===============7639801159260976633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7639801159260976633==--
