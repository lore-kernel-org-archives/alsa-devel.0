From: Mark Brown <broonie@kernel.org>
Subject: Re: wm8731 - redundant register initialization,
 stream name vs DAPM widgets, snd_soc_io to regmap_io conversion
Date: Tue, 9 Jun 2015 19:31:28 +0100
Message-ID: <20150609183128.GX14071@sirena.org.uk>
References: <20150605122748.b7534fc4900573ed497928ce@intel.com>
 <20150608095111.GE32730@opensource.wolfsonmicro.com>
 <55772F7B.8020709@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0943039354090738096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62BA826147A
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 20:31:41 +0200 (CEST)
In-Reply-To: <55772F7B.8020709@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Sergey Kiselev <sergey.kiselev@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0943039354090738096==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eW1Iu04vutECMx4l"
Content-Disposition: inline


--eW1Iu04vutECMx4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 08:24:59PM +0200, Lars-Peter Clausen wrote:
> On 06/08/2015 11:51 AM, Charles Keepax wrote:

> >The documentation is fairly out of date here I think and even so
> >it decidely implies a substring match looking at the examples it
> >gives. I might defer to Mark or Lars for the definitive answer on
> >this one.

> It looks as if the code itself always used substring matching.

Yes, that's the case - we've always relied on that.

> These days the preferred method for connecting the stream is to directly
> connect the widget that is created for the stream by the core directly in
> the DAPM route table to the DAC/ADC widget rather than setting the stream
> name.

Indeed, that's the appropriate fix if there are any problems (and a
useful cleanup even if there aren't).

--eW1Iu04vutECMx4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdzEAAAoJECTWi3JdVIfQmD8H/3837N3wcj5nVb82PNheQld/
xxgpIIE/n5WlxWs480XlAVTScH3QdMlxIVgUXZMbp11SD+tcRoqBlF/SZ8vlOYqx
8bCUYDbIkC6OBxNh7z/qewMhjlozuTanDygLKTwNejCk869yvn3P3WNRVBiEJiQi
J50kxJeckDVs8PBnb20GbT3NfR+DkosPXkW2R3d3GzUzQSyoTV6rNhLjcK9f9cZY
zgF0Lax3riXWXU+g08Jo3bpaVCtx4uSY3DsY0AMrVQkNQVn2BX4IiVXhaEPZ0EPa
rD2x9p+VGTVVGS+BDhSptpl47fm9hBiEQt5C7xv9CPOGiigJAjAWMEJtsiyx7Mc=
=suGW
-----END PGP SIGNATURE-----

--eW1Iu04vutECMx4l--

--===============0943039354090738096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0943039354090738096==--
