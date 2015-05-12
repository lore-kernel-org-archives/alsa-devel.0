From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 19:13:46 +0200
Message-ID: <20150512171346.GA20321@light.dominikbrodowski.net>
References: <20150512161849.GD3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150512161849.GD3066@sirena.org.uk>
 <20150512101258.GL2761@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, han.lu@intel.com, yang.jie@intel.com, alsa-devel@alsa-project.org, Matthew Garrett <mjg59@coreos.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mark,

On Tue, May 12, 2015 at 11:12:58AM +0100, Mark Brown wrote:
> > According to an off-list discussion, the sound breakage (and not just s=
ome
> > jack detection issue) seems to be caused due to alsa-lib being too old.
>=20
> Right, it needs the userspace configuration files installing.

=2E.. and PulseAudio 6.0, as you stated in another message, but which is no=
t in
Debian jessie. Therefore, commit b1ef29725865 does cause a regression (even
though it's just a side effect): the Dell XPS 13 (2013) works just fine with
a standard Debian jessie install and a current kernel. Sound worked fine
until commit b1ef29725865 / works fine with commit b1ef29725865 reverted.

New kernels should continue to work on (reasonably) old userspace; and
currently I do not see how this can be made to work with commit=20
b1ef29725865 and no quirk / override. As soon as I find the time for that,
I'll try to create a patch for that -- unless someone beats me to that.

> > Under the no-regression rule, this means that either b1ef29725865 needs
> > to be reverted or we need to find another solution to this matter, such=
 as
> > an override. And I think it is needed for longer than just for 4.1, as =
it
> > will continue to be cause regressions on quite recent userspace.
>=20
> Does this also affect other behaviour of the system?  I'd be pretty
> unhappy if it introduce power regressions for example, I mostly don't use
> audio on my laptops but I care a lot about how long it'll run
> disconnected.  It *is* quite a new laptop and my experience installing
> was very much that it was in bringup (though quite a bit of this was
> userspace).

Well, sound _is_ quite important to me; and as stated above, the laptop
works just fine otherwise on Debian jessie (well, except the WiFi adapter,
but that's another story).

Best,
	Dominik

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUjTKAAoJEJqXYIlMjaMNlBgP/3oa6qL0YUvrGpuU8oZl/A8f
sS3iJVKSa0/dSMK5Jps4VwjYeXr34cYKDfimv59DymVloqz+ioM8okW5WzSPvKrN
Kj3vy7RuyzJmf+3gtwKH5odSQD3A6IshK3z2CpwNGBZXpOsJFBhyX3Ot70oNyCCD
+3ZMhBNW7zypcO5Rxw8xrRXRdczAaa/pyoVeVFUZCvRQYSt/TI5EgRXZnPY6IV6I
GG9rmBRFaQbCTun1PX4ySUJYWOz79wmuGb8p+RnWKk4eSF+okMfCbcZ6+PtuTXBf
fhX6Iv6/EjDWHEJIIWEJ7xOY24JOW7KDTOg9yvb9pKXUoa5wPfvAVX6lEWAgTz1c
jrupkjEJ/j+/EppvlBu07KuBGOHgMcct/srNDkpaT1MuRGf9nz7AVXSMO47Rq+qz
+yf1zlC7Y4mzurdEiYMM3lEW4pOWKXMwGZVHqWpIXgY3mDlfoagM06xij6geXAve
ar6POsCICwFnJkIjz8XaxQrQ8CQKjxpy5AMVQ3G55iJgIKd6zAKFsax5iDgTCIHg
ZvTuZdw+uiw/mzqT+j1Jnra3bVXD717YOBE8rUhRUMYbPqHnBv1NXlk2CbPodgVa
DPpZS3NRDoNjocMRmZgCaHl8w898K/xsG6s1sdvrllC1OWMArFN3AlZQ42+5qEjE
Ak+IzDoStRUJVm0ut2Zi
=0y5Z
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
