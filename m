From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/14] SoundWire bus driver
Date: Mon, 14 Nov 2016 12:11:23 +0000
Message-ID: <20161114121123.xhdrvqn4h6jyd2q6@sirena.org.uk>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6nn5rowr377gfoq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--s6nn5rowr377gfoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2016 at 06:10:58PM +0530, Hardik Shah wrote:
> Following RFC series adds SoundWire bus driver interface based on the
> MIPI SoundWire specification 1.1

This is adding a new bus so you should get Greg to review.  It also
seems implausible that SoundWire is going to be exclusively used by
audio devices so you should add the bus level code in drivers/ rather
than sound/, that will make life easier when other users appear.

--s6nn5rowr377gfoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKanqAAoJECTWi3JdVIfQirIH/R0UHeLq5A3U28DWH0O0t2Vl
19gaGNbKzRFAcFzAVI/6BRJZlts1td3DUGeoGVBqvu9LvjfV44QCdsOmVgund+N6
uA0kOYvQkGDR4jF5oWqc6HEUrodxW7qU73ADt/NV/SO7AR+CCig38Gbh1KnHQAo4
reaAkOXfHUJLRWcXn0WmQ+h/5n5VqWz6v0RYVOqBlEiLp+rLTSk0upmQoLmGgBgx
CXbJEIvPIrtqdbZS93Yrh4W+YrE5120CVVVdslfmB5TWbE6Ycl+dtrFXO9eCcMtL
cNhKyeqs/pQW9z3QwkwX/+cQ8aBk1R+aXYbLuNVkPJxURKuJQYV3uyJrYRoJUWY=
=JZcP
-----END PGP SIGNATURE-----

--s6nn5rowr377gfoq--
