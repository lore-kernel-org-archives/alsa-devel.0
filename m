From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: da7219: Convert driver to use generic
 device/fwnode functions
Date: Fri, 6 May 2016 17:05:36 +0100
Message-ID: <20160506160536.GU6292@sirena.org.uk>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <20160506122643.GS6292@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D463C2EF@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i6eMXvFBn1dR7Tww"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D463C2EF@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--i6eMXvFBn1dR7Tww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2016 at 02:33:04PM +0000, Opensource [Adam Thomson] wrote:
> On May 06, 2016, 13:27, Mark Brown wrote:

> > Is this *really* sensible?  DT idioms don't always match up with ACPI
> > idioms well and this isn't a trivial DT binding.

> For what we're doing here, both DT and ACPI match up well, and so what I've
> implemented works on both sides. There are other examples of this already in the
> Linux kernel, so I don't think it's anything particularly new.

No, not really - your DT is fairly unusual in how it's done and the lack
of ACPI helpers is not a good sign on that side.  The _DSD things are
really only supposed to work for simple properties on devices.

> > There's nothing device specific about this, it should go in generic
> > code.

> The intention was to just match against DT or ACPI and nothing else, so that
> didn't feel generic enough to be pushed into the fwnode framework. However
> I will take another look.

That's currently the entire set of things that fwnode supports so...

--i6eMXvFBn1dR7Tww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLMDPAAoJECTWi3JdVIfQ2bsH/0fD6vBQ1XFjMsgR90ldaynI
32DVrcvTUVpjw40kavpPv0C2liG6X4BSuPG8l9n4RSxtSdPPztXUx3cXrAmAIGG7
Cw9uBdUBD32lUkK0+s9YJ8+ImoYwLOL0likaIWCuNpzUd+tRLPB6FaPB2dnbWq8d
gGvV2d/GN9YSXwgnex6Xtj/sXq/GfACqMcpSgB5BBAIV1bXsuu+B3JHiIZ61hxUm
IXt2PlBvERqVv+ua1hVGwdR3JJo54t3paKSwTKezBW5sShqKxveaDA4ODFnLQ1/3
+tl0iLVDoXR+vohit8EsgRnZrBKVJXwbCYvwI+ODSoMYS64lWhXDMkBQCiD6s3Y=
=vIwo
-----END PGP SIGNATURE-----

--i6eMXvFBn1dR7Tww--
