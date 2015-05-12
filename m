From: Mark Brown <broonie@kernel.org>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 18:30:37 +0100
Message-ID: <20150512173037.GF3066@sirena.org.uk>
References: <20150512161849.GD3066@sirena.org.uk>
 <20150512101258.GL2761@sirena.org.uk>
 <20150512171346.GA20321@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150512171346.GA20321@light.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, han.lu@intel.com, yang.jie@intel.com, alsa-devel@alsa-project.org, Matthew Garrett <mjg59@coreos.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 07:13:46PM +0200, Dominik Brodowski wrote:

> ... and PulseAudio 6.0, as you stated in another message, but which is no=
t in
> Debian jessie. Therefore, commit b1ef29725865 does cause a regression (ev=
en
> though it's just a side effect): the Dell XPS 13 (2013) works just fine w=
ith
> a standard Debian jessie install and a current kernel. Sound worked fine
> until commit b1ef29725865 / works fine with commit b1ef29725865 reverted.

> New kernels should continue to work on (reasonably) old userspace; and
> currently I do not see how this can be made to work with commit=20
> b1ef29725865 and no quirk / override. As soon as I find the time for that,
> I'll try to create a patch for that -- unless someone beats me to that.

IIRC I wasn't getting a useful GUI out of the box with Jessie either,
though that could've been installer stuff - I can't remember any more
(and the support for high DPI displays within the installer itself makes
me happy I've got an eye checkup booked soon).

> Well, sound _is_ quite important to me; and as stated above, the laptop
> works just fine otherwise on Debian jessie (well, except the WiFi adapter,
> but that's another story).

I just swapped my WiFi adaptor out for an Intel card, fairly easy to do.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUji8AAoJECTWi3JdVIfQbnAH/jcQDL69z6mnf+iqmHDpTQZT
2+SYw7r3t3YQ+S54r2Ww8CDICRnp0OO3qc89itZzQa4NoCnvhmujk6G1j3GpXSkZ
KZoamEVjDUiRckCrg79UYk82wQLwyKviAj+H6iub9EJ7pKN/4Cl9Im3dbJftzASj
TTMeLSBD74InDHUDNPKgKff+1sbN47fVPpHk7RC+dMEQm6wl2dUypz8kobWh8/BS
jBNXbykP4zcwnDpUtpGCnyzAFm0I19nSsqC1wlvLtRbqOkLvxkaUgSqeQU1kzfVw
lk1pUN5APcRp9sooQytPSYVKB+lZaSCjoJAb9nXrkAJAV414Us5VIUTBQOutR/c=
=z66c
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
