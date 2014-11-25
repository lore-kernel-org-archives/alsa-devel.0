From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix the issue that the
 regmap_range "rt5677_ranges" cannot be accessed
Date: Tue, 25 Nov 2014 12:30:47 +0000
Message-ID: <20141125123047.GX7712@sirena.org.uk>
References: <1416880301-6815-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0947954585038750531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E08952605B4
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 13:32:42 +0100 (CET)
In-Reply-To: <1416880301-6815-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, anatol@google.com, bardliao@realtek.com, benzh@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0947954585038750531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nfnKjHknX58/oBIK"
Content-Disposition: inline


--nfnKjHknX58/oBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 09:51:41AM +0800, Oder Chiou wrote:
> After the patch "ASoC: rt5677: Use specific r/w function for DSP mode", the
> regmap_range "rt5677_ranges" was not registered in rt5677_regmap_physical, and
> it caused that the regmap_range "rt5677_ranges" cannot be accessed by the
> specific r/w function. The patch fixes this issue.

Applied, thanks.

--nfnKjHknX58/oBIK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHZ2AAoJECTWi3JdVIfQU30H+gOQJdtQwDEhTh6xRDr211Lb
CRDQ3CFjCCFe+DWLzPVHl0xdCcJAQ4NlmUa1OL1feDD88WBEes5i8fnSxcqX6LAo
t3wpKB1MNzkeR3u6StBpr7gGmX2J4lOzsyyEryRR8P+GBAX5Osjim4T5O+UDRa+z
JOOruLd5aWWLmOWcHropeUT8WTLIaXFFSGe6cPZlu/tYHzvPthBhFzA18it+RcYa
mN6OoLRyZpBaLqb01CzAQDIB4lYiYDpw2JOgMTVYCGdVnlZ0r7x/8y4db4u5Af2d
emci/7/0IyTRG4zMxpkz9/cX5CMpgfIVCByNmgB6mw7LBrv5NKqiyCf251SZ50k=
=w1Q4
-----END PGP SIGNATURE-----

--nfnKjHknX58/oBIK--

--===============0947954585038750531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0947954585038750531==--
