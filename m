From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Mon, 20 Jun 2016 19:32:53 +0530
Message-ID: <20160620140253.GR16910@localhost>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <5763DC72.1060200@metafoo.de> <20160617121548.GI16910@localhost>
 <20160617123156.GO26099@sirena.org.uk>
 <20160620114429.GP16910@localhost>
 <20160620132640.GT26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3171168150252657899=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5B22665A7
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 15:56:37 +0200 (CEST)
In-Reply-To: <20160620132640.GT26099@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============3171168150252657899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDhuxz86kt5qlkuV"
Content-Disposition: inline


--sDhuxz86kt5qlkuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2016 at 02:26:40PM +0100, Mark Brown wrote:
> On Mon, Jun 20, 2016 at 05:14:29PM +0530, Vinod Koul wrote:
> > On Fri, Jun 17, 2016 at 01:31:56PM +0100, Mark Brown wrote:
> > > On Fri, Jun 17, 2016 at 05:45:48PM +0530, Vinod Koul wrote:
> > > > On Fri, Jun 17, 2016 at 01:18:10PM +0200, Lars-Peter Clausen wrote:
>=20
> > > > > Why and why is this something that other cards do not need to do?
>=20
> > Other systems do not have a DSP sitting and need to redownload code whi=
ch
> > takes time and results in card being resumed even when the platform is =
not
> > ready.
>=20
> So what you're actually trying to do here is serialize the resume - this
> isn't just a thing with DSPs, it's also a thing with I2C, regulators and
> so on.  A quick glance suggests that disabling async suspend might help
> here.

Okay let me check that

Thanks
--=20
~Vinod

--sDhuxz86kt5qlkuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZ/eNAAoJEHwUBw8lI4NHY9wP/1/QxVvDNXOnCF5UWngmQHst
UUqXfAkUYqFzP1p0wDX1Qy+hUb5huh5gkUHWBOIFrQ8TYvaDhcEEB018AXe8NNnN
1iK46XHOj4/13n7Gv/gvcuMzKrrrcs9HOAMwQATu/mCG3/5+/UqqO9CvldwT8zta
tAe88irBcFKYr8/9HZDQZUO87vfbQ0cUdUkWdG0nLopJHG3DU5rvUr61lRmQU++S
q2D7Kal+wza4m3DSe7uLipuc7EDtDdae59lO6LD42/X9n9pNwyKS8xHpr2POUH2W
Tq08mk8AUlBZTUoIuNCbVToiZmY5ptAR3g3x0lspR+Bp+H919HbcUGEvq6kgkD3O
6xmq5iW/8jhgoTzlfBkcKGY8Q8mmv+jg7Fp7WRrVxdXNIKe1ksNHw6HxB1AN3fEn
e3F+do5qTzErSJXcUjKnmdoFAv7a+rqmDB6w2JPCfLCKJcXAHfmFaoYFuuvSR20f
nqQtP7/LHPYevpj7MoutHFtxJR895gPIZIaaIkj7wl/apyGBA6Idd1OWBig2q+ro
8oj7i9JaITcYmdFhzAvMQbRY1Jx9+GEnH0TQhlOaIHSxC+YreZrd6ID10gdCujR2
MwwdfvlCnNEW2riv8EY6sOYITmoxRimCfEPE7/cib+bOcv2J+pKPovVn8DFl3zsi
6OKOfYqLOpjnXijyS0V9
=cAqL
-----END PGP SIGNATURE-----

--sDhuxz86kt5qlkuV--

--===============3171168150252657899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3171168150252657899==--
