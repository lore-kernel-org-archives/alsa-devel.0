From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: soc-pcm: Add support for
	unidirectional dai links
Date: Thu, 29 Aug 2013 12:45:30 +0100
Message-ID: <20130829114530.GX10783@sirena.org.uk>
References: <1377752099-21373-1-git-send-email-festevam@gmail.com>
 <20130829104742.GU10783@sirena.org.uk>
 <521F2835.4060109@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3894367302232696549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB662654E4
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 13:45:33 +0200 (CEST)
In-Reply-To: <521F2835.4060109@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3894367302232696549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TNwgp3ukRgvXRjlQ"
Content-Disposition: inline


--TNwgp3ukRgvXRjlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 12:53:41PM +0200, Lars-Peter Clausen wrote:
> On 08/29/2013 12:47 PM, Mark Brown wrote:

> > This doesn't make much sense to me - it should be possible to tell from
> > the capabilities of the two DAIs on the link if they support both
> > playback and capture.  Or has the board wired up two bidirectional DAIs
> > on each link for some reason?

> The MXS DAIs are unidirectional, but the direction can be configured at
> runtime. The alternative here is to specify the direction at driver probe
> time instead of in the dai_link.

Ah, OK.  That's somewhat interesting and is something that might happen
for other devices - Fabio can you submit your patches please?

--TNwgp3ukRgvXRjlQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHzRWAAoJELSic+t+oim9G0QP/jYJAGDf3u4zqEzMOb0nALG+
N72dMOAnjWWHKXLXAbDqWQPxomrsYrSL3KTmnA0DWbun+tDZ/8P/GhJYQLm/n8t5
TomXevhkweukuPHy1cHKLdNjP/kbCOigvH6hUNMvSWYsNgQSQCaii8UCiIoFVbDq
vtMsDvaMtxhea49AcD4bRXfTsbz7+pnNdFBDGrchv+w4/G2xuX7Y54ZqfNvXe3Rf
IPdTMa4qH+s1NTL1xnlosgGAjyC9x0uiQq9b7/Q3st2UZRDskv1x4zF1yo8uqWV5
XruFPS+4684C09zNn5i793a+OkbqZ06w6Uq7+t2Zgq/r1iw7XU5Kcz15YAtJHRet
Cws455JThuizSM1OfaY8TEIkjBu1bQxH46FlrY6mofv0aJznUIqYdxjRWqL7bQ4B
d9y+ilUuRL6Q+Jf7WDR6w6EtBIMdokE5RZ3DE4FDYfFaot+mpvt6kiANzQR55NZH
697QME0xqgJHJEp9aMsBexBI70XnDTL2DTLQOMdfW+/s72QJ3+uMAi9bSszt6eEF
tvOaLVAagrpm3k44Ix1RbL6kWWBoabrw7re+oVUaG6bNuGnd3+xR02su1+hOvGNH
J6+CKPi6tASEU007oeRVQWjI4TYVvaFMJ8ZupE8A1Mc3gp9uerdsfrLVTAP+RHwU
Y9lR/bBwYr07aizJ2kmI
=eLZP
-----END PGP SIGNATURE-----

--TNwgp3ukRgvXRjlQ--

--===============3894367302232696549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3894367302232696549==--
