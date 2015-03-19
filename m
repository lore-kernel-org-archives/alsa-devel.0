From: Mark Brown <broonie@kernel.org>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 19 Mar 2015 15:18:51 +0000
Message-ID: <20150319151851.GW2869@sirena.org.uk>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <s5h3851t6xx.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDA3F0@SHSMSX101.ccr.corp.intel.com>
 <s5hd2455a07.wl-tiwai@suse.de>
 <20150319144240.GV2869@sirena.org.uk>
 <s5hpp85rqg5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0548497230262962143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C67A126071E
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 16:18:59 +0100 (CET)
In-Reply-To: <s5hpp85rqg5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Arun Raghavan <arun@accosted.net>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0548497230262962143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qxpYSgLynlcP4boX"
Content-Disposition: inline


--qxpYSgLynlcP4boX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 03:51:06PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > The theory is that this is handled by the fact that the userspace ABI
> > includes a reference to the struct device and therefore a chain showing
> > where the thing is attached; anything registering two different jacks
> > with the same name attached to the same device probably qualifies as
> > broken.

> So this implicitly assumes the name uniqueness.  For HD-audio, this
> was a problem because we need to generate jack names dynamically; for
> example, there are laptops with two headphones, and we assigned
> indices in such a case.

That's on the same card, though?  I'd expect a device creating two input
jacks to do the same (putting the number in the name, or some other
identifer like "front" and "back").

--qxpYSgLynlcP4boX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCujaAAoJECTWi3JdVIfQlv0H/R3Sevvg3SPWJ53JbJzMXZre
qfnrwyAwflZ/9l8gjoqJ++fLcIzHNyNG3zkRotOOb27Zxk+0yFVFo6CjdY/Q+pZA
IPdZreyyERfL3iJGoN29BwBpJLTU5ZnyOgH7IZXLp8tsVTO9xWGh7s3PFZJ86KyL
7OGxWhOMI7Abgj2pax/sK5ZTNfOTg1jTiI4QqvRn9aC7nSzY3C+3AN09jeKlw+Hq
Lb4KIRJCa9bd061LvJlEwbmGzYqUDFdB1nj9IBgVsgZ1gay2c+YofAPPxcrKyxqu
AvXJ5604f3X7Pmad8/ee18dc6ib/eRqSMjuGNTd/SZfFxQB5AvSH30E5a2oQEeE=
=mJZV
-----END PGP SIGNATURE-----

--qxpYSgLynlcP4boX--

--===============0548497230262962143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0548497230262962143==--
