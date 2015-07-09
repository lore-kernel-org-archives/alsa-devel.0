From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/6] ASoC: Intel: Add helper to poll
 register for DSP status
Date: Thu, 9 Jul 2015 16:23:27 +0530
Message-ID: <20150709105327.GQ836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
 <20150708183621.GZ11162@sirena.org.uk>
 <20150709042741.GF836@localhost>
 <20150709104855.GJ11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7032921683503391838=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 47DCA265130
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 12:51:44 +0200 (CEST)
In-Reply-To: <20150709104855.GJ11162@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, "Kp, Jeeja" <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7032921683503391838==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 11:48:55AM +0100, Mark Brown wrote:
> On Thu, Jul 09, 2015 at 09:57:41AM +0530, Vinod Koul wrote:
> > On Wed, Jul 08, 2015 at 07:36:21PM +0100, Mark Brown wrote:
>=20
> > > > +	for (time =3D 0; time < timeout; time++) {
> > > > +		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) =3D=3D expe=
cted_value)
> > > > +			break;
> > > > +
> > > > +		mdelay(1);
> > > > +	}
>=20
> > > mdelay() not msleep()?  If we're waiting for multiple miliseconds that
> > > could be lots of busy waiting.
>=20
> > Usually this should get reflected in 1st iteration as the register upda=
te
> > would get updated farrily quickly. msleep will add up lots of latency to
> > this.
>=20
> A common approach for that is to do a busy wait for say the first
> milisecond (perhaps polling more often too) and then fall back to
> something sleepy if things are slow.
Yes that sounds sensible to me, will add

Thanks
--=20
~Vinod

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnlKnAAoJEHwUBw8lI4NHWFEP/3LarpDlcq5L5otJMS7Lvq0z
pyAZso+rkvvbKpsFNQFFH9ZQBcYftCiiM86kQV+0gPcZw8D49isCLandPbz1RSRR
hsJ72+VMzc2gJuK3Z4F2GYctNg9NmUMIIPVNQim+gIebUTC/zwGa5jIAWqt6n2p+
G4Ny/MitcpwxmfQVGMT4dM9TLk4o7GAWuYeIKEHK9WNk3Lo8YZ+XifabdZy2KVR8
jeJWL/V528UpWvVgHfBUL9jkspga7LxT04xmpndYL2m91Dby/2ODLl8hBDIR4dAI
AHRq9GtmRC1Ec5DhNXoX59s10un0SnKiyssbPKmktca+/4gtTx9FfYC9T1rzJcie
dg9Xuq2BSOCS8CPpzc2g6GuxY43fZWGm7gX0++gfo5bh+4jjh5Eda0Z7tapHj+U1
8LQxvssWs1UZvhqElVQ4i1vXVS8mUTOYwIf9CAf6gu3RwqNpPbEzpsQILgDhOeJO
50BqBcN7XpHW7Fo0WsyxcTsXEUS/fEwouFsCQnJ0oefI9CLHcd3BKR4yYYRFBhU3
qm2Dikb8XosB+vZiT1m5NDYH3uncqG95sn++kpE31USkoWE0Lg0ARnY5DkC/w33i
jJZJPp7mSVpcBU1v4FlO2JhBB4WvJaQuwQ4iU/l1jG8uLnLuTLfU+g4c0z08ydp+
WQofKK4kyyXlUNQ3v8Is
=K6yv
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--

--===============7032921683503391838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7032921683503391838==--
