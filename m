From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: jack: Remove unnecessary call to
 snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:37:48 +0100
Message-ID: <20130827143748.GQ10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7399856799843066158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2516C2651D8
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:38:26 +0200 (CEST)
In-Reply-To: <1377611461-3638-5-git-send-email-lars@metafoo.de>
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


--===============7399856799843066158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
Content-Disposition: inline


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:58PM +0200, Lars-Peter Clausen wrote:
> snd_soc_jack_add_pins() does not create any new DAPM widgets, so there is no
> need to call snd_soc_dapm_new_widgets().

Applied, thanks.

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLm5AAoJELSic+t+oim9idgP/jbCKEvj2v5Uq5WwNXjFL5DD
mqAQZJGoMLWVwLYtsPIt/aoCOvNNxVrQ6kD0KZCTltWzFz4oT6T49W++bu4k/xe3
XASvoFKGHeveXTkXWH0dSNe15uX62r8X2INsZLRiABEInhE+8FIVzEMuQ5TDrBaM
/mk0mVUb96FXOQtibOpqIkcYtxFMNkGabO4r+acGQjV+8O5ox0zjPEX5wS4jqiJh
TWNGsbqsJM7NIx/2WJReKt2nzFQMcYurbhlOaTY0UKq0v7GdEUe7AMV/avzv0fKX
44pGxYeCkRtQjzpBUf1VaSoSTmcrGHXt2Ii/Vi7Fz2y6RPeYHRDypmVLzCelvoGa
VISiP7+0lQ4GTL1EUmtRuDkzWEGvpnLKmNsGOu9H/SFkBcp9rVoYOJzeKy/F+ddE
PxVDI3zAJeBqC4xd/jAxXqqA3HY/wjSjCGD0DTdchY33ylaTUnZYtNPv37o8hAL/
mm+d8ceSm+1Xmw8Cq0oVmc0L/K11/vhSe3Ze+8gPE/Q8CsyHOA2QVrYT9RNo3+tQ
JtX3T5myxteVgtgT7fBlBS0ULPgvY0P4toNfm5Lmosmkb0CwFy92J8+FiTJBgU9/
SezWvjV1b+ZJKBwegHWplw6XbOoGqd6Jb4cYhw69my+Lmuu5fD2+Y8vFqU8zwXfg
+z5wIj52RqKSXI4NYncu
=cAes
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--

--===============7399856799843066158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7399856799843066158==--
