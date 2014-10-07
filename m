From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Delete unneeded
 test before of_node_put
Date: Tue, 7 Oct 2014 20:02:21 +0100
Message-ID: <20141007190221.GD4609@sirena.org.uk>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
 <1412706598-18796-4-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4895609053135817063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E912A260570
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:02:33 +0200 (CEST)
In-Reply-To: <1412706598-18796-4-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4895609053135817063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dqsx3Lh6rjXyciUn"
Content-Disposition: inline


--dqsx3Lh6rjXyciUn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:29:58PM -0300, Fabio Estevam wrote:
> of_node_put() supports NULL as its argument, so the initial test is not
> necessary.

Applied, thanks, but please CC people who typically work on the code.

--dqsx3Lh6rjXyciUn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDi8AAoJECTWi3JdVIfQL+IH/j2eiWl4cwiN9bjahtCsS8qE
7Rh/VKppUJFsK9T/0gdq34fZV74N3sNxG6qTXnErQQ4XSi/tlGrWQcWxO5PXYt7h
p3wQpqTZ2C/2JUryiE+a6LNDhxi1pkjd6XpRxaPKW+OTS41LST/2OlGtz3F5gD7O
x4zl/OIQcvQklGlEt+ifZSPfHkloyA4oNE+4dLrWax2KYDFLVG1dP1zNah7oq3mv
CrRFZfw358Miq5+M98hHr41RVsf4XKUCmLFCz2Xk+THkP0RnJuPA5Riz5fhuKMpm
7ZD9+PXwrRjTRjhhqe6ROeHcYCaI3ACDFi7ET4kjDm/xrjcdUcLmJA46tfK+S7k=
=8Yh8
-----END PGP SIGNATURE-----

--dqsx3Lh6rjXyciUn--

--===============4895609053135817063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4895609053135817063==--
