From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 01/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Wed, 10 Feb 2016 13:52:38 +0530
Message-ID: <20160210082238.GT19598@localhost>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-2-git-send-email-subhransu.s.prusty@intel.com>
 <20160209194206.GO13270@sirena.org.uk>
 <20160210043358.GS19598@localhost>
 <20160210072328.GP13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2675148210014247338=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B7B4B260603
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 09:18:58 +0100 (CET)
In-Reply-To: <20160210072328.GP13270@sirena.org.uk>
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


--===============2675148210014247338==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 07:23:28AM +0000, Mark Brown wrote:
> On Wed, Feb 10, 2016 at 10:03:58AM +0530, Vinod Koul wrote:
> > On Tue, Feb 09, 2016 at 07:42:06PM +0000, Mark Brown wrote:
> > > On Sat, Jan 30, 2016 at 07:13:35PM +0530, Subhransu S. Prusty wrote:
>=20
> > > > +	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
> > > > +
> > > > +		dev_info(&edev->hdac.dev, "%s: disconnect for pin %d\n",
> > > > +						__func__, pin->nid);
> > > > +		goto put_hdac_device;
>=20
> > > Will this get noisy?
>=20
> > Not really, we print when we get the hotplug notification. Usually that=
 wont
> > happen too often unless someone is moneky testing :)
>=20
> That sounds like it might get old very quickly, we presumably already
> have the graphics stack doing the same thing.

Last I did not see that, but yes lets make it less noisy, will move this to
debug

>=20
> > > > +
> > > > +			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
> > > > +					pin->eld.eld_buffer, pin->eld.eld_size);
>=20
> > > ELD is an acronym, please write it properly (there's some other examp=
les
> > > in the patch).
>=20
> > ELD is quite often used acronym in HDMI world, It is already there in
> > drivers (did a quick grep :)
>=20
> I know it's widely used, I'm saying you should write it properly.

Okay, I think your concern is on writing, sorry I though about the term,
will fix it now :)

> > > > +		} else {
> > > > +			dev_err(&edev->hdac.dev, "ELD invalid\n");
> > > > +			pin->eld.monitor_present =3D false;
> > > > +			pin->eld.eld_valid =3D false;
> > > > +		}
>=20
> > > Is it really invalid or did we fail to read it?  There's a difference=
 as
> > > far as debugging is concerned (one means there's an I/O problem, the
> > > other means that the display is reporting nonsense).  Perhaps this
> > > should be silent and let the read function be more specific?
>=20
> > There is no way to know if this was IO or garbage from display. So we j=
ust
> > throw up error and retry few times.
>=20
> It seems implausible that there is no way of identifying I/O errors, and
> even if that is the case the point about the message not being terribly
> helpful still stands - moving the reporting to the point where we decide
> there is an error would be a lot more helpful.

Hrmmm, looking back and checking the get_eld does print more verbose
information on the failure, so this one is really not required, we will
remove this

Thanks
--=20
~Vinod

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWuvNOAAoJEHwUBw8lI4NHVK4P/1G4r9qn2jc81rCf/rrVQi8+
l5v2hJCLNT4kvq3khuVwC/fuyQf1IzDUeRz2upmOi62Hp5sV1X01NpAz7QJcv3vW
xFAe9s2Pfx8pCmOpOn3/T0eMjv+kf2uhadW/gPH4beWPfjOl1G6o9u94LcvGa1AA
9RivSmOkwsI+gDQEE+fpELRZbRiKNBDNLjim9l9XBrqjdx2Yds4u+InfWckcp7EL
wTIL5zilYR1LhLiLXKQHAHdfZmY02OKqQ1I1ar5Rp/njdaDB0JRXAXvSiIUgFH1t
F98MlinjMmlOveedASV6Eo4i18avapUx8IBtsdkiHLReLWY2K7I3bUqqRjpg8GON
BkVv+h4XJNks+JeVCcOxZMD/49Xim3HzgzKSXZCd9OcBS/OOSYp62ucqq8A2lRg+
jRueOQUo+2SQ1wKsCaFI8nVgu+L6FRbw6bfD7JBhs9UWnicFUsyJMudF7oogWlNP
CPk8HkNfKz/oiMnXHdi4OvgF3Rf5vJZB4bKpDrc6UDLCjsqo+QWk9Wv/RHZv5SgX
h6Nn0UE5mtWOJd7DVxQBfz5ATBZQ2Sozx8hHwflLjTJf9PpU5W2rTgRTjwPhDjk1
8Wtv0X8hG/4CcW+6bAN/EkdT0XojJg7APr3fflJw76JuDlHV6Mevv41+/Uz0a6mU
9LIMJxDPvr2ih2ngLxOE
=5mqe
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

--===============2675148210014247338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2675148210014247338==--
