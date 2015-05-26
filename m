From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Simplify format_register_str()
	without stack usages
Date: Tue, 26 May 2015 16:22:04 +0100
Message-ID: <20150526152204.GS21577@sirena.org.uk>
References: <1432644014-16475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3366874124588281950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BAD826158C
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 17:22:14 +0200 (CEST)
In-Reply-To: <1432644014-16475-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3366874124588281950==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/7rxiSAA1JAos7i8"
Content-Disposition: inline


--/7rxiSAA1JAos7i8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 02:40:14PM +0200, Takashi Iwai wrote:
> Instead of allocating two string buffers on stack and copying them
> back, manipulate directly the target string buffer.  This simplifies
> the code well.

Applied, thanks.

--/7rxiSAA1JAos7i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZI+cAAoJECTWi3JdVIfQFAgH/R7hhY3UKIwCkdHOFr3OHGLV
CPoHMMpwnTEcC6HhW8SFCqiu0vcI5jzxiUWqQGWkARY2CRqyQ+Z0EdzSPIGKGyjz
CIGCplniBpFfvZZrbBSiG0/rGznZ1kg0DleSRvdS+ic0d4XWP3nM7ySlwXB74ONX
+ouXyuioJ+ghBm14T0Yp7wmP0EmwrUk5chajBM/DIDO6k/xloudpjUtVhQ9ZStSm
4VnyYZQtgWNT3wHoLOrPj4FsP0v97gvLh1ihGkX8/a1G7tXjvhXQUwLpWLdJQGAn
NOK9fe8Prz2jjn3qHRiR5wdiIJeOioSoGRh4XAdssS7zYhcFev/k+KVLgwqUTqk=
=9A5F
-----END PGP SIGNATURE-----

--/7rxiSAA1JAos7i8--

--===============3366874124588281950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3366874124588281950==--
