From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 01/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Wed, 10 Feb 2016 10:03:58 +0530
Message-ID: <20160210043358.GS19598@localhost>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-2-git-send-email-subhransu.s.prusty@intel.com>
 <20160209194206.GO13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2339936268107302442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D4BC260544
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 05:30:18 +0100 (CET)
In-Reply-To: <20160209194206.GO13270@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2339936268107302442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2016 at 07:42:06PM +0000, Mark Brown wrote:
> On Sat, Jan 30, 2016 at 07:13:35PM +0530, Subhransu S. Prusty wrote:
>=20
> > +	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
> > +
> > +		dev_info(&edev->hdac.dev, "%s: disconnect for pin %d\n",
> > +						__func__, pin->nid);
> > +		goto put_hdac_device;
>=20
> Will this get noisy?

Not really, we print when we get the hotplug notification. Usually that wont
happen too often unless someone is moneky testing :)

>=20
> > +		/* TODO: use i915 component for reading ELD later */
> > +		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
> > +				pin->eld.eld_buffer,
> > +				&pin->eld.eld_size) =3D=3D 0) {
> > +
> > +			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
> > +					pin->eld.eld_buffer, pin->eld.eld_size);
>=20
> ELD is an acronym, please write it properly (there's some other examples
> in the patch).

ELD is quite often used acronym in HDMI world, It is already there in
drivers (did a quick grep :)

I will update this and any other acronyms..

>=20
> > +		} else {
> > +			dev_err(&edev->hdac.dev, "ELD invalid\n");
> > +			pin->eld.monitor_present =3D false;
> > +			pin->eld.eld_valid =3D false;
> > +		}
>=20
> Is it really invalid or did we fail to read it?  There's a difference as
> far as debugging is concerned (one means there's an I/O problem, the
> other means that the display is reporting nonsense).  Perhaps this
> should be silent and let the read function be more specific?

There is no way to know if this was IO or garbage from display. So we just
throw up error and retry few times.

--=20
~Vinod

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWur22AAoJEHwUBw8lI4NHjq4P/3Uj2u0XBPoNmM94wHzw8NEr
Xqv3cdG6a6hnlsPrN6bSYePlfFNPMO4NjUZgX1sWTWvAj0OdtgJB/qkelDBrJ/nh
a1Lf592KAtAxvghR+ZRAihWvnQSX91xPTuAAa+S/NtoWs0duEGH0nj59DCnqemmk
WK/bXXYQPJGQZMGXYpvOdluT6HZ6awM+Wxcm54q+Pdv2irabQvQLYrJREYilF1No
JyfrpvpeZa4yYH+j92+jLPeNsib2hJuopZpJ83FUmGbyF+zYA/NFFdSrb+9raHAs
x7FYCiIjm/ormhA7mXTPbd1o5OPhhr9X8DpFe6EqnrKUiZDufHVMjuLWyEYyUftU
8m3+lWDF4jr6SO3x5exTHLiiukTP+4B0Oszkg0ucsU/WFCeCTJ7irMz3Ha2lXlcB
AGlQGAyPdRt1kFtv2gVkpBqqYXdIJx3CJbHokE0sNQEGiZJeG3OgF+xfKB23n5V/
lNigeyamhDAUVkF94XegZW0OH9lrKw+V48GPAg8d7zYVTGndWxM8/iRpk+ViX8S9
pNdv5PS2mIa8HNOaSQAfZgONz+ZTVF7ydgkjTIhv3eetsroETB7onOIbgAysukcP
3zm4yRy7buNVaRLkq2zFYDLzBnA3toKlSaQA6U9yQoqZzR/Pg8006lrUwpGXiqQA
mHpq+8fai/ysE+tqrZXH
=Pr/d
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============2339936268107302442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2339936268107302442==--
