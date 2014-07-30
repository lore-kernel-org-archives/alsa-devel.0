From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/12] ASoC: kirkwood: Remove unused
	drivers
Date: Wed, 30 Jul 2014 13:11:39 +0100
Message-ID: <20140730121139.GR17528@sirena.org.uk>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
 <20140729193509.GK17528@sirena.org.uk>
 <20140729204853.GC17763@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7070267678233602039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B35932608D3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:12:04 +0200 (CEST)
In-Reply-To: <20140729204853.GC17763@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, alsa-devel@alsa-project.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7070267678233602039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e7t3zDdoAGSAyuyD"
Content-Disposition: inline


--e7t3zDdoAGSAyuyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2014 at 10:48:53PM +0200, Andrew Lunn wrote:
> On Tue, Jul 29, 2014 at 08:35:09PM +0100, Mark Brown wrote:

> > Applied.  Please send patches against current code, I needed to hand
> > apply this.

> By current do you mean asoc-next? That would not be very easy, since
> i'm patching a large number of subsystems here. I don't think the
> gpio, or the libata, or the led maintainer would be too happy if i
> based the patches on asoc-next! So i picked a plain -rcX kernel,
> something neutral to everybody.

Right, for something like this where the changes are supposed to be
applied in the individual trees rather than merged in -next can be a
reasonable basis.  It's not ideal (and it's pretty unusual for it to
make any sense) but it'll mostly ensure that the patches can be picked
up with relative ease.

--e7t3zDdoAGSAyuyD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2ODyAAoJELSic+t+oim9zWAP/1GvKdQ+YSdF/GgafQ99BgQ7
bqiGxVQNiIg5dYDhmOJn+yIEZtOm9p+aXagGSZYyWfFA0ULp64aTuBJBB/CaUGN8
alDOVdcXDq84GqGHdj5YgD5haDrT77Khw03HRUwcPIwlD4o3ESUKtGHMyVwYOqix
v79Meoj+u9deOJRQbbw+TNm0sY3yEUPKLOBGzYKL34PEDDCck/oU4qGGMtIasEam
fa/M/lVNHewNuRadmPRQn9uRyOeKEe4iPH2CjDkyQJTHBBDzX2P0MwGGwJHXMH5j
nxl18gljK+JlSCvoPwN/RNeuPv6f9HoXOebFFTzcQuv5UmCmpvrnjM4HNlMF+fpp
AXVZQ4KXLMA+l7yfEJ5rG/0vmncRbHfM+PC0hg66qOAPOed2SzyPWYjHIrM2CxTh
i+sdP1PxUYgz9RYW4PXpnjoOj0S1HJjobwYsQljjg5Z+S/iZtaQKh/0s2ACamdVG
nDJkFZ47x3dZCwUR6QNeYe5axqZ+j/oTTqDBF3uUntTNzuoL2YY/DFcgYnNqY57U
fw0MAKjvpq1urZR7rWlTQsmCsgCIxa/ALBAuEYNruwVr1SEg54fHs2BmJj9I6P2G
3tluk4Ce2XHRLDebvlBHVicXz+MxTklZKjNQKfVy++SeYOlh2MV/5W/4wbLpsdU3
XWkG8javOPCnObIUw8zZ
=9uvi
-----END PGP SIGNATURE-----

--e7t3zDdoAGSAyuyD--

--===============7070267678233602039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7070267678233602039==--
