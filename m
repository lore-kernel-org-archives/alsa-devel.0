From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Mon, 28 Oct 2013 09:46:11 -0700
Message-ID: <20131028164611.GL13643@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131024095118.GH31415@sirena.org.uk>
 <526A1568.9010100@linux.intel.com>
 <20131025100618.GR18506@sirena.org.uk>
 <526A4B11.5000802@linux.intel.com>
 <1382961194.2334.23.camel@loki>
 <20131028150639.GA10936@sirena.org.uk>
 <526E8181.2030208@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <526E8181.2030208@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 05:23:45PM +0200, Jarkko Nikula wrote:
> On 10/28/2013 05:06 PM, Mark Brown wrote:

> >Indeed.  The way I initially read the suggestion above the idea was to
> >replace the bus number with the ACPI name for the device which seemed
> >sensible but now I reread the bus number is still there.

> Sorry, my textual proposal above was confusing and should have used
> different variables for ACPI name. What I meant was "spix.y" ->
> "spi-INTABCD:ij" and "x-00yz" to "i2c-INTABCD:ij" where "INTABCD:ij"
> was the ACPI device name which contains the device instance in "ij".

Ah, OK - it's actually what I read it as in the first place then!

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbpTQAAoJELSic+t+oim9c9wP/jooDse6OvPPV3l8W4Afoar+
Prb0U9KwDPOzd1dhyo9mNd7vMgf5VF+uZy8W2IP4MxH6YzXbyawt10AyTfqTkUiA
ss88QWpwxuu/eT5U43bUxQXkGESumyd36GV3T7QcioaxPT0B2EUIGHU2VGznY70C
H3a8NWFfU97FTxCEeA9yXFh2Tr6NLw47dpiZBeKAvttnSDL8Z8Gc6CAFmFMYKuAc
TJM6fO8rZ75SrsrpPwvw8KlUjBBz62ZbU/8lGi9FHBNmt2X/mBXpX6bk4Px0cUll
lcEnSe7H2fQpRcCbrDlDIOOSw7dtXrd0fPN1b+WmwkzOV3JEM9KaUjtt0S+02NDi
1oa2rMBEHkuEhWUmD3lrynCSnH49hirtAm6w1lAmPW268Xz8k+iC3T0OP/XBVSmE
gJwSUUIBU32DKcfwVvz8orsakOc5uanamo6lYUSKGo3g4YsKUQ0mrnwpbXJWpBAw
IhiVEz8HHo7AzfcOGENIzt3PPzwn/LL6oN8Rmzp5i/Mtc9HdgPWAo5sHvtOn1Aq4
jnDTIlZkW1S/H8qBF9gzlyQI3KxeZTvOE3lKH1SBiSNtgt0ODgSv207UU/oiWreC
205NuTc7b9dUUpror9Q7o45KFMsB29mpTQvcCl+i7W/Ymt6y2j24MYETgKlqEpZt
GHC0DQiAG9PybI3jZuG5
=Qt2a
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--
