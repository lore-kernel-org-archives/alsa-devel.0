From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Make snd_soc_dapm_kcontrol_codec()
	inline
Date: Mon, 16 Mar 2015 11:40:35 +0000
Message-ID: <20150316114035.GN28806@sirena.org.uk>
References: <1426411641-23769-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1119146289703328114=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 41CCC261171
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 12:40:44 +0100 (CET)
In-Reply-To: <1426411641-23769-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1119146289703328114==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5NmCl6OEQDB0SMwx"
Content-Disposition: inline


--5NmCl6OEQDB0SMwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2015 at 10:27:20AM +0100, Lars-Peter Clausen wrote:
> snd_soc_dapm_kcontrol_codec() is a extremely simple function and inlining it
> typically results in less code than necessary for calling the non-inlined
> version of the function.

Applied, thanks.

--5NmCl6OEQDB0SMwx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVBsEyAAoJECTWi3JdVIfQJbUH/AiOdjoIfBnFy3zau6Rl7Ahy
lgpc/NDxgykn2UZ6UZ/xR8WMTm74tMMH8nhgfJrX27x+TBM/DwuK/6oe0+twHi9Q
TEDB+/A0mhGZBgJqM91M+3gJtPD2t84n9rSB4eugK1zj39DdgiKJRx8dnv5OnK/0
bbY76THnbus4lE7vYZOwICnVZZnru/lCXHAOlldV3l1gmFISe2TGlFXpSGMfaBDd
2s30LT4zNJlw+u+u5woyEIrNjPYLb/0AvZuRKqRDr3JmtFdlE7QQZ+9sf986Z6mu
iESVpWUkes4qYC649m6CWue6Te2uR129xWlELIXGPWOLIGifs3YXw59bmIN4PWM=
=oWoZ
-----END PGP SIGNATURE-----

--5NmCl6OEQDB0SMwx--

--===============1119146289703328114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1119146289703328114==--
