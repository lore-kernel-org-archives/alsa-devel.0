From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ALSA: compress: Pass id string to
	snd_compress_new
Date: Wed, 25 Nov 2015 11:18:58 +0000
Message-ID: <20151125111858.GO1929@sirena.org.uk>
References: <1448448376-12880-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1448448376-12880-3-git-send-email-rf@opensource.wolfsonmicro.com>
 <s5hegfeicam.wl-tiwai@suse.de>
 <1448449621.3536.48.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830988504937864543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A52F926155B
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 12:19:09 +0100 (CET)
In-Reply-To: <1448449621.3536.48.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1830988504937864543==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Content-Disposition: inline


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2015 at 11:07:01AM +0000, Richard Fitzgerald wrote:
> On Wed, 2015-11-25 at 11:49 +0100, Takashi Iwai wrote:

> > > +	if (IS_ENABLED(CONFIG_SND_VERBOSE_PROCFS))

> > This should be #if.  Otherwise the compile would fail (as already

> Builds ok for me, this will become if(false) if it's not enabled so the
> compiler will strip it out - some maintainers prefer that to #if and I'm
> used to being told to use this style instead of #if, so who knows what
> today's coding style is :) The build bot failure was for a different
> reason.

The compiler will still spot syntax errors and similar in an if (false)
section.

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVZkhAAoJECTWi3JdVIfQYMAH/RDpPAlAyOuhSw7lE9min1LH
jSSY8NXvXb/OuuziIQ3F1AS8psV1C09Lb3DkrJZ3GNmx7qo+SRqBoN5i0T3Eoyzg
X8TDGyCIJXFi32B5NlO/gSXLm2eKse0e+HzYEAm1nBS5opofAtXShQQ2KMPMsV5h
/xfBkw0oTSyCQ18Rq8Z4ACyFxLM2VkpzRjZ4c4EJdxlZnxyyDsFOWUpq0UF+61JU
iph4DYWaC2v8H/h87zD1fWUPt9gDbwwkn+7yOPxoH42ZnJGvj+wieicamoRUDqqd
xfuTA3EAyUrUJWHNrq/KcyLcqDoP6XD59SPDd10ran2k11JY5ytXJT/VqvIW7jY=
=mF0v
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--

--===============1830988504937864543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1830988504937864543==--
