From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Mon, 20 Feb 2017 10:26:32 -0800
Message-ID: <20170220182632.gtjwnv3lvq3n45m4@sirena.org.uk>
References: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
 <20170217104047.vhrcehhojpkdeksu@sirena.org.uk>
 <20170217104354.e6ylky6xqjaasl6m@sirena.org.uk>
 <58AA5532.4040206@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0085805238572284584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CA34266917
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 19:26:45 +0100 (CET)
In-Reply-To: <58AA5532.4040206@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0085805238572284584==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="me4ouhlyth37jtsf"
Content-Disposition: inline


--me4ouhlyth37jtsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2017 at 10:32:18AM +0800, John Hsu wrote:

> Thank you very much for help. I'll investigate what's the problem.
> May I ask you more information? I need to know how to produce
> the tab/space conversion issue. Do you save the patch mail
> to text file with patch sub file name? Then type the "git am <"
> command to apply the patch. I can't reproduce the issue in my
> ubuntu linux with the patch mail sent by me.

I save to a mailbox then use git am --signoff on the mailbox.  I can see
the problem in my mail client directly as well, for example by editing
or replying to your e-mail.  Perhaps check a copy that's been through
the mailing list or sent to an external account rather than just one
sent locally?  It might be getting changed when it goes to a different
mail server.

--me4ouhlyth37jtsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirNNUACgkQJNaLcl1U
h9CiRwf+JSevnxdTPHF2VPMixX6f2/uDo/oi7MKS0d5oUTu9ZIXdo8KTcgfPAsV/
z1u3Rz4Hc3WNLiq8Fi4dwSYOet+rkEK+O3h1rGMs1yRxuLXAUXUecZMRSvGIS360
ZY7mhwsWhUmueYmubqFV4rpYK20aJlpJRGulr2HmH78Go+dmpR32pdi70Bxbrvw1
hNLU+uai436Li20iWIWl2K57uCm5elPOvNDw2UlpwqEszch9WBI+imUkd7JecMkU
VV/4NGfcwuxraf3w3eHMERpQuj6myTO7tBPegrkF5nLex9eZdu2axAUAg2RFY6lp
hhBrDaB9+fNKeeZLwB6oqHrQF5kW8w==
=zwXV
-----END PGP SIGNATURE-----

--me4ouhlyth37jtsf--

--===============0085805238572284584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0085805238572284584==--
