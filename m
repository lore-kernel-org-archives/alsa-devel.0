From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/32] ASoC: wm8400: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:17:41 +0000
Message-ID: <20141124181741.GV7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2796088377414882767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E022260534
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:19:45 +0100 (CET)
In-Reply-To: <1416746269-4935-2-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2796088377414882767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mdGUb96ZZNqpHCXz"
Content-Disposition: inline


--mdGUb96ZZNqpHCXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:18PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--mdGUb96ZZNqpHCXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3ZFAAoJECTWi3JdVIfQyJUH/jvFRmTp1NsO7EsnzcTbqoKV
I71uVCttoIqQz+dV3lJFDOYnvwLg9AuF5tQaH3Qt2Xw5MY0H8CuaZeIQUFrmHC4S
O6rjYTKYCWNBHDgHhAzFOznsqj8yv4rgsp3gOl1zhaJ6fRELYj72E+flKvhzXXWb
YpTT3f56h/fb1Sdj4ENerHro1jkWc6+WWL6xb3gClFlg2hkNHZbdyM/Rv3jHxKVJ
Pyg9HHBcoJIDpLKWvssidd5FcSbZWjT7uZeCNiqdkiVM4Gtqy4Mk5cfJpmqbK0dv
hYbe4y7m16HHv0wveT43JKgE3hy/4166DOLSV0kPUtcsRzV+TxI/3HtX1ihEemQ=
=q0Qm
-----END PGP SIGNATURE-----

--mdGUb96ZZNqpHCXz--

--===============2796088377414882767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2796088377414882767==--
