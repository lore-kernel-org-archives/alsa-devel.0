From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm0010: Fix resource leak
Date: Wed, 31 Jul 2013 14:51:00 +0100
Message-ID: <20130731135100.GS9858@sirena.org.uk>
References: <1375273732-17492-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7899834548368488584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C43BD2654CD
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:51:03 +0200 (CEST)
In-Reply-To: <1375273732-17492-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7899834548368488584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ycxYX4IAELFb+cE1"
Content-Disposition: inline


--ycxYX4IAELFb+cE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 01:28:52PM +0100, Dimitris Papastamos wrote:
> If kzalloc() fails for `img' then we are going to leak the memory
> for `out'.  We are freeing the memory of all the tx/rx transfers
> but the tx/rx buf pointers will be NULL if we drop out earlier.

Applied, thanks.

--ycxYX4IAELFb+cE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+RZBAAoJELSic+t+oim9G1cP+wduGoUOagBYgVga8xujGGp3
KUtFRrXjf+2jwusZGYB3cb6eDq9AgAjhS++pENQhz5Ketx/A48zyizlKa5iH2PX8
gIKa1vgZbOpdjPB9P0qMfAfu1ZzamD4FNLCpkB82PSoEXQTeRw4lkih+3jRugJIW
+m9Fmd6Ebc1SC/UYK90ljvb1NxL8U965Mk56pOVq0u4v5V3gePpQ0ioTJft03g1F
rn5tK0Ytiz6pL4LgPvt4yWybX5WgSgjebVAh6I4dCigNjOWBb3l/XYmyOTyaXhLR
BGGwuP1bltoP86yUvEZfSWhwyc55Frg47z3aYJLITe4JJAyDOsPf2KBVyVcsR1v6
3x/cO34RFjpKtuFEoP1uSeGN1Qsg14nIJPO1H3vebkXs5WxhdMM+SRNOsWcgu5Sx
NPwJw6wU2bCs+doUh1YpynnyX43TgmPw4qQpU/bChE6KzDvCFEslmiETEG+zi6AP
jOXu4ib3tgR12wW8pfa5xcFy6shdaKVtFCX2OOpX2cwpfQf4CaO6ctZcmQHghMCV
jsTEZ5RcnGxgmBRft+kinvHWQoHYMxFowIqaPZ9THfTo8Z+Ephgyo9YWOtAGxcpk
iBGNVGalK/oGUeQ0VBxeomsujCxKurBgqVaWxcd8+8aonenM+x5S9DoF6/q9Xs7y
B4DzwFNgTsMTNWPCvSgZ
=2qac
-----END PGP SIGNATURE-----

--ycxYX4IAELFb+cE1--

--===============7899834548368488584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7899834548368488584==--
