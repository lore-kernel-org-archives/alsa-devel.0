From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 11/13] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Fri, 18 Jul 2014 19:56:23 +0530
Message-ID: <20140718142623.GH1985@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
 <20140718121920.GO17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3440285396242285927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B1D532608D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 16:30:36 +0200 (CEST)
In-Reply-To: <20140718121920.GO17528@sirena.org.uk>
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


--===============3440285396242285927==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 01:19:20PM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2014 at 10:14:55AM +0530, Subhransu S. Prusty wrote:
>=20
> > +	pr_debug("%s: widget =3D %s\n", __func__, w->name);
> > +	for (i =3D 0; i < w->num_kcontrols; i++) {
> > +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > +			mc =3D (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> > +			val |=3D 1 << mc->shift;
> > +		}
> > +	}
>=20
> So, this is the usage of dapm_kcontrol_get_value() (quite a way away
> from the patch exporting it!).  The usage here looks *very* strange.
> We're calling the function but treating the result as a boolean and
> manually decoding the DAPM data structures in order to get the control
> shift...  that's odd to say the least.
>=20
> > +	SST_FILL_DESTINATION(2, cmd.output_id,
> > +			     ids->location_id, SST_DEFAULT_MODULE_ID);
> > +	cmd.nb_inputs =3D	fill_swm_input(&cmd.input[0], val);
>=20
> So what we're doing here is parsing the controls to get which inputs are
> enabled...  it's not altogether clear to me that we shouldn't be doing
> this at control update time.  Presumably we'll also need to be sending
> these messages when the controls are updated to account for changes that
> happen while streams are active.
yes thats the idea. Here we send as mixer path is On. Yes the mixer update
if On does send this as well.

--=20
~Vinod

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTyS6PAAoJEHwUBw8lI4NHlUgP+wfgPKjfRAS/ObLBTbEaHYud
Ar4ZAAKNVnb1cr5yVwgBzQy0r/RbGOzChFlJYHvHdbMckJZs8i6g4QQF0iqIsCW9
vPsojZr7rNAuBfpEH8rma6aKDC2yZCGa+KpRIWBV5Zipkzz8tvuvh+AvCQ5wMItY
tTC1BqdcF6gSndZgcAs1y0yCR+lXJzlIcHg02R9ZDwYGB2nGh3LHGcEvkqKOhqX6
g50fo8M34fezzLroCyrSU+ptqw4MAVeEku2WAfrKVXli2v/UkmN/GEwYdsHdZ/1x
z4hwzXS6uz4wRzkKdQ+C4zyQBKZ8Q8EU3L4ZKftlYX6PnkSyAee6O6Ye0KGu3GQ6
YfStJD3N5iuR8bla0pvUBat+hXYm1iCAKK2MExEZjS59TEHxr6NsDkWbdIOe/JbP
A73Ab4nrRU43JxoxCsOe3HpSJpFHO8295Avf9P+OhNt5ig8I+g1Z1JSR2CFD5fng
21b1NLcSvl4n0t/sFnmcf7mLgMyutsz8qttYgAkoT07Nmakv+/CEjXrROUqVuDAi
x/d7iNzGYZBSfxi7Tg3bd7bcRYjfnaze6Y0iFxpEUtVo4b4Yed+Uubp3/mlME5oL
f4uZWUYshig7EbavrRsvlZamwc77h5uBbfVB7/FQ2K4hPlGmAtIxUln5m0UZE3pe
Y9ZlzTrDAiCu86cywAVD
=hOtO
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

--===============3440285396242285927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3440285396242285927==--
