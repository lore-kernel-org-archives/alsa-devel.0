From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Volume levels with Geode LX/CS5536
Date: Mon, 29 Mar 2010 22:00:01 +0200
Message-ID: <1269892801.5924.7.camel@mattotaupa>
References: <20100327050046.GA28058@lucien.apo2k4.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244627414872748524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 601BF243DE
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 22:00:04 +0200 (CEST)
Received: from f053040123.adsl.alicedsl.de ([78.53.40.123]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NwL7y-0004VS-Qj
	for alsa-devel@alsa-project.org; Mon, 29 Mar 2010 20:00:03 +0000
In-Reply-To: <20100327050046.GA28058@lucien.apo2k4.ath.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1244627414872748524==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Mo4ZysLFu2c3OO9J5v6M"


--=-Mo4ZysLFu2c3OO9J5v6M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Valentin,


Am Samstag, den 27.03.2010, 06:00 +0100 schrieb Valentin:
> the maximum volume level (100%) on my soundcard for the PCM mixer is
> 12.0dB instead of 0.0dB.

what are the effects you are seeing. Too quiet output?

> Is there a way for me to fix this,

If it is too quiet, did you try PulseAudio?

> or help
> fixing it? crimsun on freenode/#alsa told me to ask you guys :)

Take a look at [1].

> My alsa-info.sh output is at http://0au.de/~apo/p/ai.txt

Sorry, I cannot help further besides saying to try a recent releases.


Thanks and good luck,

Paul


[1] http://pulseaudio.org/wiki/BadDecibel

--=-Mo4ZysLFu2c3OO9J5v6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuxBsEACgkQPX1aK2wOHVijhACghnSCQNSjp/1/olgzKLM4iQYF
nD4AnRfrROggOvniLEiJgX/39+w+Cc90
=62iE
-----END PGP SIGNATURE-----

--=-Mo4ZysLFu2c3OO9J5v6M--


--===============1244627414872748524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1244627414872748524==--
