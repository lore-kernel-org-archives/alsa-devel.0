From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ak5386: Add regulators to
 documentation and fix sparse warning
Date: Sat, 29 Mar 2014 10:17:08 +0000
Message-ID: <20140329101708.GH21628@sirena.org.uk>
References: <1396029905-6807-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6109912375862479041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E310D261698
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 11:44:24 +0100 (CET)
In-Reply-To: <1396029905-6807-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6109912375862479041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 07:05:04PM +0100, Daniel Mack wrote:
> Document the newly added regulators to the DT binding document.
>=20
> Also, "static const char const *x" is not identical to "static const
> char * const x", which sparse now complains about. Fix it.

Applied, though this should really have been two patches as there's no
overlap.

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNp2hAAoJELSic+t+oim9WCUQAIS7lvB8j1U78yZ60TzCZ9Tm
X5/irOq39/qHVg8Smsq5RnYGMhZm7L9GAKTCoFEQ+hMf1miL66qOkJCkk+nHXJ45
FZesFlSNiUEy38fCH9ONkISTGPucdO0pATyc6HqlINZqWUAt1UXlwWmLkP+BZKLO
LZEPKjVc1qtWYvQ7KjwCOV1Ka8mP/2fJNkjy7hJRZt+tk/h/FW03tCCGWB/o5QrD
9LKlzeQDtvw0/pMBGqQRFAnKuL+P/yApvfLQK27LNICYP/JfUc9CVN5e7w/C3j1K
KiikVSXv8yYMtBezbvLbl/fbzxxDOxRjk+rovWPUd5iGStywnKE5Yh5HutjfPD/W
nVtpeY5FjrR24jxM/S0CG4+SFlgIwzAkCCrE7wCow9dbo0cS1JJPEgFUewP1PqXP
03cpztudapcvMRLAN9YG9XcO/R5jNesC/jTDzEGGMHec2L7zB41rQc8rTjegZkHS
mHziy2FGkmQm/Cg0Ex4p6DGFNqzPHXlgfOM0Lmnv3JwNxkWMwmWdhgkpTxmpvU3u
4jiygGcWhPnG1S7Zcs0KelR4GzadJSfmfv8bAMWgPI4aOV1JSjJv6sw0YVr9OwAQ
Ui3Fy8erBapKi1Uzd2C0TWVoWDsavojd/qQ1cK5ZzL8nXQ6d9XKh1Cgbzbn9hinB
uvFKO9krjHvFby053L+o
=QLcN
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--

--===============6109912375862479041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6109912375862479041==--
