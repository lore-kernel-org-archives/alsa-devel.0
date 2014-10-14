From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] audio: sgtl5000: Add MicBias
 resistor support in DT
Date: Tue, 14 Oct 2014 10:03:03 +0200
Message-ID: <20141014080303.GO27755@sirena.org.uk>
References: <1413268992-15248-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <1413268992-15248-2-git-send-email-jean-michel.hautbois@vodalys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0888431062527295612=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 957842604BB
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 10:03:22 +0200 (CEST)
In-Reply-To: <1413268992-15248-2-git-send-email-jean-michel.hautbois@vodalys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Cc: fabio.estevam@freescale.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0888431062527295612==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DwegkxrocNF/g53g"
Content-Disposition: inline


--DwegkxrocNF/g53g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2014 at 08:43:11AM +0200, Jean-Michel Hautbois wrote:
> Some systems may require a different resistor than the default one (4K).
> This adds a property in sgtl5000 codec.
> It keeps the default of 4K when nothing is specified so it does not break
> existing code.

Applied, thanks.

--DwegkxrocNF/g53g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPNi2AAoJECTWi3JdVIfQkhUH/2ufmUEtYUi68AxLKoF8xmTG
SNnkXi26n/d3P7l/pPGbDIq7hNPiM3nSUAcYLECqGkw26KjW2CXyqCJxGFvqhBsd
Ccq1NXBvfEVfq/eaEA8XA9qte9XfFdNbCIijJRM47fjpmnYpasj/vT5clmB2AhrE
IvPGdezpkdQihQPQvuxPOagYt34+W86rORYT6yoyk+8SJIPe4CsLsg0MeEd0NgC1
h7nSIJy1KF+XtYNdQM37vSmq+ly6w1XcMeZ5g3NbE6RlrpvCgiWREHIR9t9gyYiA
fhah7uaBUmCNjN38HOjU+Ph+OPjm9ZLbOXfPu5LfSMTieGmu5PtPHpAylrjLc9c=
=h1+Y
-----END PGP SIGNATURE-----

--DwegkxrocNF/g53g--

--===============0888431062527295612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0888431062527295612==--
