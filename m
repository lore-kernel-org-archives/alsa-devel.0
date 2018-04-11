From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: Intel: Add Geminilake Dialog
 Maxim machine driver support
Date: Wed, 11 Apr 2018 17:34:14 +0100
Message-ID: <20180411163414.GC12166@sirena.org.uk>
References: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
 <1523442303-12710-4-git-send-email-naveen.m@intel.com>
 <8fefaa36-2682-a604-4af9-6d4a2575c4f9@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4327283631354702772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 82123266E30
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 18:34:19 +0200 (CEST)
In-Reply-To: <8fefaa36-2682-a604-4af9-6d4a2575c4f9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org, harshapriya.n@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4327283631354702772==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 11:20:10AM -0500, Pierre-Louis Bossart wrote:

> > +static char glk_spk_dai_name[10];
> > +static char glk_hs_dai_name[10];

> Off-by-one? "SSPx-Codec" would be 11 chars if you include null termination.

Or avoid needing global statics entirely...

> >   static int broxton_audio_probe(struct platform_device *pdev)
> >   {
> >   	struct bxt_card_private *ctx;
> > +	int dai_index = 8;

> maybe better to do an explicit search that hard-code values?
> This will actually not work if you have an additional FE for headset on GLK,
> or you are assuming a dependency on a patch added later in the series - not
> good.

Definitely, this is just a recipe for fragility.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrOOQYACgkQJNaLcl1U
h9CtLAf/SU0MExPN1DBthsqFx/+NDrc4FBVwdZ05qyVeI6cxFamqqo+ISSiIRRTn
GOLl7lx6sSknPZhc+hLo3C37+WmQJh3HWvAEsvxe2Lu42g+xFzulwFsCkv1nz6Et
2zQQuvf3WUmHlqQWPe0/Q62kCzVYjqGNz6lVYbG8KJI4tLd3hXzaaFtnWDgeO2ap
CuobQGzpARZMl5+lfUxIr2kSY6ChtGAE+lNjrlfxRPMZvC8LmBQW90+yUUiZc0Qn
Cgt0PDzgcXVrskLUcOTTQhxzBbadgGXogjvn0QNhNuNVoD6KXxfn6QLKUGTawUdm
QRAal3DwKxpYKvEKkAAi4Vyu3W3krg==
=6v4y
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

--===============4327283631354702772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4327283631354702772==--
