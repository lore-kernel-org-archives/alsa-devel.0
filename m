From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 17:18:23 +0100
Message-ID: <20140728161823.GY17528@sirena.org.uk>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2042728154919013917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5112E265125
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:18:32 +0200 (CEST)
In-Reply-To: <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2042728154919013917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="frK4hI1X9U277v5Y"
Content-Disposition: inline


--frK4hI1X9U277v5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 08:54:13AM -0400, jonsmirl@gmail.com wrote:
> On Mon, Jul 28, 2014 at 7:20 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 28, 2014 at 08:24:39AM +0200, Lars-Peter Clausen wrote:
> >> Cc ASoC maintainers.

> > Jon, you should really know to CC maintainers.

> Are the all CC'd now? I thought the ALSA list was sufficient.

No, you should always CC maintainers - never assume anything sent only
to a mailing list is going to be seen or read, certainly not with any
degree of promptness.

> on-chip codec - it is ADC/DAC with FIFIO directly attached. There is
> no separate bus. on-chip codec supports things like mic1, mic2, line
> in, line out, hp out. Most boards populate only a subset of the jacks.
> Right now the device driver makes a dummy codec and internally creates
> a card and links everything together.

> http://git.elopez.com.ar/linux/src/abc050fbbaa5302b76ac585954cd207961fc9159/sound/soc/sunxi/sunxi-codec.c?at=sunxi-codec

> Then someone came along and wanted to add a MAX9768. We're stuck
> because the way the driver is built it doesn't support the external
> MAX9768 codec driver.  MAX9768 is just an amp with I2C control of
> volume.

This doesn't seem hard - just extend the binding for the device/card to
allow auxiliary devices to be specified (the matching code supports
that).

> So how should the device tree look for no external amp? Right now
> there is just a device node and the driver makes a card/dummy-codec
> internally.

Your CODEC shouldn't be a completely dummy one, at a minimum it has some
external pins which need to be described and documented.

> How should the device tree look when there is an external amp?  Maybe
> this amp should just be a chip of the device node?

Just the same as any other card - allow a phandle to be provided to the
amplifier.

> How should the various jack populations be handled in the device tree?

Assuming "jack populations" are DAPM links just do it the same way as
anything else and use snd_soc_of_parse_audio_routing().

--frK4hI1X9U277v5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1nfMAAoJELSic+t+oim9XhIP/RETBsQkgsVAyQkAlcP4AwT5
A0kIfvZa1OhYPpfvVEml5MAF01DDdrL+fSWWH3FcS91WkaGqbZt7tsIB0dDrzY6P
SEUmAsSPjczsYvMdNaAcH+NJ/gDVIxf72qhv/fUzzRjVpjpxiWQlbD4m+dkYVOfz
ldse0/uneXA0bbB+he+WtKiFA5jFX7ByETLgs/k/GPS7tFbIIUAg+1fjFkqD+mE9
DYo2VCq2DkYP5pWrTc6v6vrJ5jBmna+ukQyuHb/FgQ9z9B1hylcqqXlns4RsjlrU
aK6glAkEXvDfc4pGqKa7tTvvaymgPsNL/oijn4skOMq0cyT4PKATw4fOFZ4CJA5b
zfoMlsf+j49vw0PEAMFbZifUoA0h5NrpVG0rXFPb1cjA0K10BG22Q7d+AC2DV5mc
Pwb3TotasjmwNtB3n0hEGLagCOMzB8RA1q/Q7s4Oou3jb9t3arDhK4AHZuw8vqAi
yNv6CXikS2HTckk+dxd6K7x2mZp1hf5Hv8cOu7pLlz21q4J1CZSDGDrqkIl65Ar8
qgOO6aR8+BxlJDARCPpNiRsRjKJhzCUYJv6IjdU5aFUeQM6NQMJkTKSlx5XzIfRf
emdCRHd18ZRg1fASEsPUXbfwEv8uNVItcV06y++TnLe9Y1zMWkbhyNv2uRYJU31P
kGHtk0EmJW1nJyeMCunw
=EO7x
-----END PGP SIGNATURE-----

--frK4hI1X9U277v5Y--

--===============2042728154919013917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2042728154919013917==--
