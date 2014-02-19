From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Fix build for sst-dsp.c on
 PPC architecture
Date: Thu, 20 Feb 2014 01:54:56 +0900
Message-ID: <20140219165456.GE2669@sirena.org.uk>
References: <1392828357-7610-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1269844660318213418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E550426531A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 00:20:30 +0100 (CET)
In-Reply-To: <1392828357-7610-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1269844660318213418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sATYihPtMaajJnn6"
Content-Disposition: inline


--sATYihPtMaajJnn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 04:45:57PM +0000, Liam Girdwood wrote:
> Disable build on non X86 architectures except for compile testing. This fixes
> the following build errors on PPC and adds an option for testing the build on other
> architectures as suggested by Mark Brown :-

Applied, thanks.

--sATYihPtMaajJnn6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBOHdAAoJELSic+t+oim9VVUP/3coXRLjdp+kLLW+W07d7LcS
0EEp37+7WaX5bOHohZvBNWT7s4fAloqHyyKIW3j8x9EkmEg/LiVqvNedKzQxjz29
AMorL9bC+DDWNRJljcUMEvH/dha8ZMgteRo1fzVQi/uBQpi+7HhNi/jBkhyTdW5S
jUq5lTvS77+OeY3+zze4zTbA1giTKpzmAZgRJpXVrag3oqkQ7B2vOI6Al3woZjog
29SbqC92JcgiJd6Z1C2Y2t9RtIGKroSNL0OCdVYDiPeZBI59arQBUMbPOI06Cz4O
lSMJ0bKHDff4XEuNcRnrxIMqm0cUh4VygpL3IA1LvEbBgHLMKGxWo5TxvvGz47yQ
WEELU8D+WZRSNQYmN3+ivd3ksmoUoA4BXDxrs/owF0MQ4dQ/9alVZT6RF4YnyZlF
XWLQFPBFWqZrTzpqWaDRNOquD+MZvwsp90iNmEeAaJNoDLuFJmZkD0i/tWE8zY4e
T1SjxUawzwLwQwyfoLAXtsccFKruMuvLe6wxtJwuLb0bIqJXZ/97YdTOqdLc7FJ1
YYSmWqqyDkcB+4FZD5g3GDO3QZ8UFG/43gDeFhq+LVqzdFCwGwIEm+FR3Hm/t4Fe
A/wjY49CuTA9joaeJlQl06gjZnU0AVnoSBHNVKjNqTzEkuBKi6NFtYQIAUgxINIi
qDpaoxBkA6b2SeBE24wP
=HWn/
-----END PGP SIGNATURE-----

--sATYihPtMaajJnn6--

--===============1269844660318213418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1269844660318213418==--
