From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
Date: Fri, 12 Apr 2019 15:27:48 +0100
Message-ID: <20190412142748.GB6235@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
 <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 09:17:35AM -0500, Pierre-Louis Bossart wrote:
> On 4/12/19 5:06 AM, Srinivas Kandagatla wrote:
> > On 11/04/2019 20:28, Pierre-Louis Bossart wrote:

> > > 0-day/Kbuild starts complaining about missed module dependencies and
> > > compilation issues. Since codecs and soc drivers need to be compilable
> > > independently, let's fix this using the following model:

> > > SOUNDWIRE_INTEL ---- select -----------
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 v
> > > REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS

> > Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and
> > SOUNDWIRE looked totally redundant and bit over done.

> > Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more
> > align with others

> Good point, but no. This is intentional and follows the Kconfig pattern
> pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47

> yes, this SOUNDWIRE is overkill for now, but let's assume there is a seco=
nd
> non-intel implementation (which I understand as very likely given all the
> threads on ARM64 support). In that case you'd really want a top-level
> selector option that has no actual compilation impact - not used in any
> Makefile or code - but enables the sub-options and let users/distros sele=
ct
> the platforms they care about.

I don't understand what you're saying here - what is the intended
difference between SOUNDWIRE and SOUNDWIRE_BUS?  Having the separate
option for _INTEL for your controller makes sense but otherwise the
normal pattern for a bus would be that you'd have the root config
option for the bus (which would enable the core code for the bus) and
then everything else is hidden behind that.

>=20
> SOUNDWIRE_BUS is really the lowest-common denominator that will be used by
> all drivers at the end.
>=20
> > regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire
> > slave drivers isn't it?
>=20
> yes, that was the intent.
> Thanks
> -Pierre

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywoGMACgkQJNaLcl1U
h9BKWgf/Uu12+7GZaZlYY+rgsISG7oJhhvwc6PKMSDUkKB3TPs5PYY50WEJuAz3G
Yc0EFNJpJleCQJ7+Cwt1bhV8fZ+gMKmuS6DchfTQIpdCq/cs9iD3vqDCOdBE0h/i
ufk0Du3ztMmg4YG49lvPQane1xuuG6twho3OdONZndeTKsJy16fqpp5fhNs2FAD+
VAGuxJBBx2YTGgO+g7Oog9wv5n1NcwGwbUH7BBKPceUwh2P8bKXBtVa5ai6+JWW3
W2wPS96Swegy1/gLu0RIERQNVy9mrx7dbiX+4omgtdYuhsPReJhmG4tQrbWonYg0
axdGsoYgOFcRZv78mX/MuxqNlL2kzg==
=y7Jn
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
