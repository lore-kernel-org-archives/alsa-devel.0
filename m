From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Wed, 13 May 2015 08:36:47 +0200
Message-ID: <20150513063647.GA2479@air.dominikbrodowski.net>
References: <55401602.5050907@dell.com>
 <5552388C.9000500@dell.com>
 <CAPeXnHss+k4xqYDZsDycKEAtLGMBbsnsMiHsZ_voigbPoq3vUw@mail.gmail.com>
 <28099406.1MOrFLUSgY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28099406.1MOrFLUSgY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Matthew Garrett <matthew.garrett@coreos.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Mark Brown <broonie@kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 01:38:59AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 12, 2015 10:43:33 AM Matthew Garrett wrote:
> > On Tue, May 12, 2015 at 10:29 AM, Mario Limonciello
> > <mario_limonciello@dell.com> wrote:
> > > Just to be clear, from the Dell side only the XPS 13 9343 has this _R=
EV
> > > behavior.
> >=20
> > The Inspiron 7437 queries _REV and uses it to modify its EC behaviour,
> > and apparently breaks on Linux without that.
> >=20
> > > What's wrong with a DMI quirk until I2S is mature on the kernel side =
and
> > > userspace is new enough in distros?  Is it too early in boot for DMI =
quirks?
> > > That would enforce that no other machines can use _REV value of 5 to =
detect
> > > Linux without breaking the 9343.
> >=20
> > DMI quirking is fine, but it has to be behind a config option. We're
> > going to have to carry the quirk for several years because we have to
> > support old userspace for an arbitrarily long time, and if there's no
> > config option then Linux will be stuck in HDA mode for that entire
> > time.
>=20
> One problem with the DMI-based approach is that _REV is constant in ACPIC=
A,
> so to be able to return different values from it for different systems, w=
e'll
> need to add some ACPICA-ish code handling that specifically for Linux and
> we're a bit too late in the cycle for that.
>=20
> So here's what I'm going to do.  I'll revert commit b1ef29725865 for 4.1,
> but *only* for 4.1 (I've actually queued up a revert of it already) and
> I'll revert that revert during the 4.2 merge window.

Sounds like a good plan. Thanks!

> In the meantime, we'll develop the code to implement the DMI-based quirks
> for the Dells and apply it for 4.2.
>=20
> Are there any volunteers for doing the last part?

Will try to prepare patches for that tomorrow.

Best,
	Dominik

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUvD/AAoJEJqXYIlMjaMN0pYP/jH57FOyDzJqaJf36RWBLlVf
ELzoDw9LS6n/A61tWGjObJNX2MkXFNbO68UCDF8prZFwU3gz8qFcaq+kjAzeHFGe
PBkVZ3+X6meTJX1rRHOW9XHDcn5AVDgb9FGN51gS85PLVG0FfL52HKkOG4Je9TKQ
57W4UD9dvktpIhYToBJ2mBOYYviYhqq8Q1hL8ExMMq6HAmSLGTWhzFpDN91kGn7Q
xJOlBFy+cKA/eeLhL81F9XcyQXG7+KHMzuF/eyAc8P5GfwnQHyob007u20FvNKXY
4m9Rr/hYW0BHSvknLxTMDnuwlBjpbAre7XIlPwNSp0YzqdnF6bsC8Fs9TXngzwfx
/+IBrLeji3VKSFMVmN6y3n4czqROxszXq6zYHs0I07YMZIC76y6t5z2irtYRVE1Y
R86HiIcQteIc2OKztONWnZT6kLpKB9F9UztkIg3S0kcJuZ/HhJAG11U0Kz7XYkyy
9YtWrgSvX65aL4DQ2s1zDSR2ygx6m4Y1jOi2k00OjBz7QSQXrsWe38ylmBKBFXGe
yJPxWXOHXI3gQwYUbncCqgr8UcpVwSQzosMRUns8fkca1XjcNxgeHiMt0dI5LArL
c17AtOtMlUGemk62cizqey8s2PROA1We7fyVO0b2hUHok4ChpFMw4wbYVIS6Yryx
CjiJMyyfd1eP2bzVDGuU
=eJEa
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
