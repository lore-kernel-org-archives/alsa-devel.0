From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 06/13] ASoC: kirkwood: combine
 kirkwood-i2s and kirkwood-dma drivers
Date: Mon, 5 Aug 2013 18:04:28 +0100
Message-ID: <20130805170428.GW9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7223525910689576536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FA5926510F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:04:31 +0200 (CEST)
In-Reply-To: <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7223525910689576536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LUJznmvzDK14ZXyF"
Content-Disposition: inline


--LUJznmvzDK14ZXyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:27:03PM +0100, Russell King wrote:
> These really should be a single driver because they're fully integrated
> in hardware.  Make them so.

Applied, thanks.

--LUJznmvzDK14ZXyF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9sYAAoJELSic+t+oim9jygQAIKz8owdLw+MaKRxSJ511Sm/
LJYK1OHv9q9Ly+kFSGRhIj67y6VWIDNYkKkzGVKcRP5QUcAtJvJ44uPS7hEoNZXz
Eah+lsYyXjx9+3iYd6OwnuhqmlvFonpqaD1yfZdtHGAxcxaO1Uka2jF2JVMysoJq
azL9HGD30BL8QJ/i6ih/A1UwH4CY27HbUpuX72yRqGsfwKZK2R4vZluC3o/VbJ22
jTyZ7eirK68MzfvH+BqfZDt4Uui/uAbufmgdPnq9LtJ4+9Q6L1usXdiMJs3IoXo3
/mspwX7DbRUub7J7zRvMB0BYm13JEy0MlU0Mv4lOylNWcnb/HjSvYkzL0MjPhWDq
jZFVfMsQydsDpc0eF1CQxys1gypVXqvqBF1+x1uannWoygfL4pQMf1poO25dFExJ
dXvmugJ0Ai1um3W09gVIA0Dg+7n+Us4M2Tvkddf3rE3kndhn7PgoYZv3//RqaLTs
PcUivkn1S48hDZJ/lpv2NV31Sjmxkq9bspewY9OedJlrKDekixd7KWu0D1QxEHA/
Qe7ITaBKssujJgN/sID0hCkptONQPbD1LVS1Ju2B3zoOlPRwc7YRVyxA0oSYtjhX
yn41EtewyLs7E6Iy84jK4yyUfxBIs9Vlp8/JF4x/yqlCppzmYgul5bNsQGmRBcBj
s+N2NL50NWUUJeZg41bk
=LkEX
-----END PGP SIGNATURE-----

--LUJznmvzDK14ZXyF--

--===============7223525910689576536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7223525910689576536==--
