From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 015/102] ASoC: wm8985: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:58:12 +0900
Message-ID: <20140220015812.GD2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-13-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0390285473444394721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A4826565A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:58:42 +0100 (CET)
In-Reply-To: <1392723148-12597-13-git-send-email-tiwai@suse.de>
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


--===============0390285473444394721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/MY3p9q5RkoZ3ws+"
Content-Disposition: inline


--/MY3p9q5RkoZ3ws+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:27PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--/MY3p9q5RkoZ3ws+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWExAAoJELSic+t+oim94QIP/1mE1XIfsri+J8GCwTd4qtCG
El+3GZZ18WKuSGlp//udIAeHUR4VVpjUyhktCfb0ArxtvKllI97j1X81FsBxT4vs
ZncUNZziGVtxga6RrRbGSkjxpd0mWQFTmebkaOo1WsSQSJqmM4PjHCMgBoBzeSnS
HAa7WXX1rpZL/qewOU9/UsSwcieEJd1dgBV/RtwNFFNGAcgNlF0+AJZU2C+wU2pF
RftwBrykB4fFTo/NOxjSDNRB7KGL0ieL7WDPoK8FAo3ldEkHDdLrvnmXO2oHMZc0
sHaiveDr/sfuHGX+batNWB5hJEsgTirR4aMCCow3KqzNDx+prpbMh992/XPNsYvk
uFRhv9pzllIwIx65e8LnQXW2qFUiBEM17sWiCP/Dw4XAyeilEZbKzRpgj4ADioUa
28nzRcZpJtfCwEk1JfrLlLSsiZIIsfwnzYhJThZW332+6HhskwyaCJH7BICXrzrv
tfJEyETK6Fet8DSb4R//i+Mc7b8asplit7S+X04Fo5Fp6QCVV80nrC/OJnihxMXB
e1ZkOFbruArUDziJb5RZmgxrbmUBWbQYzbz2yacg5wUmP76wov6qmdvX3dwq8ExR
EC+0HN0zu0M5M9byfwKONtT3VGzyJAEQMt59z9COB7gdEsG08MctTxmV4NCB1S0A
+F0jgS2GRKjLEWTgFr44
=gnqy
-----END PGP SIGNATURE-----

--/MY3p9q5RkoZ3ws+--

--===============0390285473444394721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0390285473444394721==--
