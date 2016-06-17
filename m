From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] snd: soc: cx20442 codec: set tty->receiver_room in
 v253_open
Date: Fri, 17 Jun 2016 12:40:09 +0100
Message-ID: <20160617114009.GJ26099@sirena.org.uk>
References: <1466107475-9747-1-git-send-email-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466107475-9747-1-git-send-email-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2016 at 10:04:35PM +0200, Janusz Krzysztofik wrote:
> Commit 79901317ce80 ("n_tty: Don't flush buffer when closing ldisc"),
> introduced in v3.10, revealed a bug in the cx20442 codec driver
> which has never been setting tty->receive_room on line discipline
> open as it should from the beginning. Fix it.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+GZAAoJECTWi3JdVIfQFO0H/3GBzAzgPFbsOTu9hfJ/Mgoq
PT8iTAFjA8uqivFA30TeLYS9eTg6btLrx2XvajRp/ZNCG0qqX8QWW1nJ02n9312z
xAdzVzTBDAbXeGxQYEAGH+XycULG4MwIbYVycGUQU3R/PIF1uAYN5OF36/wu+TVG
YPcc84EYl8NO4hfqCOrOLkQPY5fo8wNZUwY2rPJ6tlxfbGxfv+tWkf1bqFX9O7tv
ebiXRtKKUjDbLzwIJHzF4LUh4UE1k3o9kedTJdjV0Bxwz6KTv/Yx7oKFyEMb29G+
9e+/TpSclYWMV051RnCcDKpbVlu/bthlfyAfHLPTb68cbx6Bp8gkxRM2164SeiY=
=T1a7
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
