From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 6 Feb 2012 14:26:00 +0000
Message-ID: <20120206142559.GJ3070@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
	<1328537786.6799.16.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982041263109000676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C2B2103B28
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 15:26:01 +0100 (CET)
In-Reply-To: <1328537786.6799.16.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1982041263109000676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W13SgbpmD6bhZUTM"
Content-Disposition: inline


--W13SgbpmD6bhZUTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2012 at 02:16:26PM +0000, Liam Girdwood wrote:
> On Mon, 2012-02-06 at 13:27 +0000, Mark Brown wrote:
> > On Mon, Feb 06, 2012 at 12:25:18PM +0000, Liam Girdwood wrote:

> > > sound/soc/mid-x86/mfld_machine.c:238:	ret_val =3D snd_soc_add_codec_c=
ontrols(codec, mfld_snd_controls,

> > This looks bogus - looks like the missing fanout mux support which we
> > should really fix properly.

> Vinod, fyi - something for your todo list ;-)=20

Well, to be fair it's a feature missing in the core.

--W13SgbpmD6bhZUTM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL+LxAAoJEBus8iNuMP3donIQAIcgv4s+MWu1WjjAFW8mSmiw
PwzKpaYQNhr5cxwwBZnsnASzuRnO2O/SGTcbbbdJN83LWLSoiCrdWs/glSRHm2V1
p2cA6TrzsYn8E270wX9E47dbeQdYFzSee38ecS1pFEMnF1ITJ5QdPE52DcNoqCrC
vziWbyOJyR9PsNgsvTvSXcDb8YE0yHfzAAQnD8zIN1CyIP/VtfhilZQv1/za7LY+
VOpMIUdOZslLQsk0uV2gxK5ur/1tb+1aJLUVB7bhVznwT5BFLG3iJ2vYbJ7nES5E
ylaEgccJGdd70ljxRtt7/R0detznGiqvkL2HyXEF9VgTT145LgskUY/cZ77o4Qv+
of0EiXdkjCjTU34t60KYGiTDJ5wgKlIn3Z3Tcv4i3yM8FWln4Q2/V/UoYSJrX10B
yPdo1oc22bYasmc5nc3D4Tj8qzyXItFT0WWMmwjcQp8AeRc5z8IwvTCy2bK8bghS
zWgGoVTIa+0vf5+VlkH25zGyd1fjjQBmRV8COw4Z1tcQ1mv7R8TswNRY8Sa43bQP
7Gvz8YCZkvMXJnEvxyfxwwvmYRrffLsZiWtnx18wbA4qwzqsraknWV24KgkGhIwA
MFhOsb/r6corkVT5RZUAsf5pIXVnxDXo+GaJ6hWQqoNiXYHy78q9W3gY9QXdyDI6
cVqz33G8wElP3KQ1WOsA
=IOER
-----END PGP SIGNATURE-----

--W13SgbpmD6bhZUTM--

--===============1982041263109000676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982041263109000676==--
