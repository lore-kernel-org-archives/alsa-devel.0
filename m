From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6 v2 resend] ASoC: add Renesas R-Car core
	feature
Date: Sun, 28 Jul 2013 19:36:54 +0100
Message-ID: <20130728183654.GF9858@sirena.org.uk>
References: <87txjnrz2z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0853241265583930020=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A28CD2617BB
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 20:36:56 +0200 (CEST)
In-Reply-To: <87txjnrz2z.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0853241265583930020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QCxTbf+V5JaCsx1"
Content-Disposition: inline


--+QCxTbf+V5JaCsx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 21, 2013 at 09:35:52PM -0700, Kuninori Morimoto wrote:
> Renesas R-Car series sound circuit consists of SSI and its peripheral.
> But this peripheral circuits are different between
> R-Car Generation1 (E1/M1/H1) and Generation2 (E2/M2/H2).
> (Actually, there are many difference in Generation1 chips)

I've applied all this series, thanks.  There are some empty functions
like rsnd_scu_stop() left at the end of the series which should be
removed (they can always be re-added with the code to fill them) and it
does feel like there should be more framework use going on here but
everything is well enough localised within the driver so it seems more
helpful to apply and then enhance incrementally.

--+QCxTbf+V5JaCsx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9WTDAAoJELSic+t+oim9zCQP/1pWl7iQdKaIaIHdz4ieCpQU
RyzJbrmB/8TUy3lyS6Dc1X8S93Rga4VoSs/LDJkL666TfHcV87ZuBGDwRuwfVpa5
RDlsztuuw5UXhOGgd2UAn9tQHoY122NHRAq/lEKOetYJlrZJW2/S3/MKSNu/H/Gj
nwA3iqbrbZ9f6CsR8+gu3QhmzGW1HCwhbsQrQD9IV0KQ9AmMytVvx8CC+PqiMsrt
XkuP1n5+Xgn3yubtejIrmzk1T3bCy0JJEaP4tgbhzaTwzqRffT1D55nTbZdAhEwL
BG6ytgwzfrMKss0Suu4jMl8xrVKbDERWvHywCeYLJoD/s7JihQ+puItAqwSFYua0
fMnzkeILcBaxmPDPKVWyu0Fn7gsGbZOReLly34AzcJteTwKruo07kQbChgkoRzOo
3FRGbnBZnYlYDa6Txj+UULEtHKVZSccFybA3pNfLLRhsVyCPD9STCTuvT8uq3XTq
sUbTkiJfZ/tWS2olXDEDMU1XJ4D5QY4TYxGSPcJmW7FsJeF2xXQ/Nyv5uptG2XpV
iDQFUjAa+b8MZd0dyV+dKvLG75jTE1xP0HBKt7Zh3YGgTz6bMND8hU5777jW/bD+
8uJ10w9zSObIPENHRhaCkwhapsDhKLOn4LoCGfPtKok+VvMD+tWD2cSqzs+wPqA6
EyS+e4ZFROZFL8A4P+Z+
=d7Dj
-----END PGP SIGNATURE-----

--+QCxTbf+V5JaCsx1--

--===============0853241265583930020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0853241265583930020==--
