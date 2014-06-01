From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ASoC: wm9713: correct mono out PGA
	sources
Date: Sun, 1 Jun 2014 13:53:16 +0100
Message-ID: <20140601125316.GJ5099@sirena.org.uk>
References: <1400186759-24248-1-git-send-email-mreimer@sdgsystems.com>
 <1400517347-3673-1-git-send-email-mreimer@sdgsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6423111416489189401=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C8226524C
 for <Alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 14:53:35 +0200 (CEST)
In-Reply-To: <1400517347-3673-1-git-send-email-mreimer@sdgsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Reimer <mreimer@sdgsystems.com>
Cc: Alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6423111416489189401==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y/A/1bIHS6WQt0eA"
Content-Disposition: inline


--y/A/1bIHS6WQt0eA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 09:35:47AM -0700, Matt Reimer wrote:
> The mono output PGA input only has four possible sources, so
> omit the rest.

Applied, thanks.  Please use subject lines matching the style for the
subsystem.

--y/A/1bIHS6WQt0eA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiyI4AAoJELSic+t+oim9fCEQAIciSqBNZJQU9t1EDFQTV6pU
Hw5JEvbWATN8qfoFBaRqRMnrl1I0GaqT4fu63n6xvdFFQgttWQPzkhxZZCQnFvdF
CRmthGbulRfbTOv2wa6rgCrjVE98TluEFgKhNUqe6Gpaj0qaf8WBglobFSP1jymW
rZw/4bCElqB2rGJ1xd2aHU7+PbGxow7QE/UTCODIQW7MK/vxXYIegiu3F4ABB4as
jTsespRRzm2SFl8L++kdIeQqMfFppfcJAhLtdJhvAlN3eu5Bm25eoNCvwTU9mPI1
JhKjrd7X+EDuRGzpqTCEKxuLnmG0dwZs62WE4JUgCWjstdTJ77tyOY6SewHhoYL6
V3fMpvw4DSFfXLigCM1wVkYUZARfXAPsC5JyB93urNUaMwDWXO68m+n42PpGj5Nk
+loWxnU9UevroXtD1b73oC9Y0RqX79yRDZb7GbySBSFxmQxpqS4mdENXL7/0Oh4z
2oXGn74Nc1CPG0QjJJdg0B3PNLlOlA1CMaigq9MRlqQPJdzE7C5BKPsaoV/2EbuE
zof3UTDdi2z3+s7xRKrV/OtpnQvqUh5jLarMRf6dAeAvL/Y3tm/5zQMx0Djl5tnA
VzqhNhktfJRlK4rsdswoY4iPfWuAoBfO9hTYNGWI3QiCttlq9bKZ0Ulm5H+g5sgO
aKRmgQCNVuFjOffQ9/A7
=l9C1
-----END PGP SIGNATURE-----

--y/A/1bIHS6WQt0eA--

--===============6423111416489189401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6423111416489189401==--
