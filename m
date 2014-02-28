From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: simple-card: cpu_dai_name creates
 confusion when DT case
Date: Fri, 28 Feb 2014 14:25:34 +0900
Message-ID: <20140228052534.GO9383@sirena.org.uk>
References: <87eh2r9169.wl%kuninori.morimoto.gx@gmail.com>
 <20140227050726.GR9383@sirena.org.uk>
 <87ios0etzw.wl%kuninori.morimoto.gx@gmail.com>
 <87ppm87z3i.wl%kuninori.morimoto.gx@gmail.com>
 <20140228035357.GL9383@sirena.org.uk>
 <87ob1r97td.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1055661139054756167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8709D261A27
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 06:25:38 +0100 (CET)
In-Reply-To: <87ob1r97td.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1055661139054756167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCcB5JEkX2RALVsX"
Content-Disposition: inline


--QCcB5JEkX2RALVsX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 08:31:45PM -0800, Kuninori Morimoto wrote:

> Do you mean why I did it end of asoc_simple_card_parse_of() ?
> Because this cpu_dai_name itself is used for
> dai_link->name, dai_link->stream_name;
> This patch set NULL after that.

OK, makes sense.  Applied, thanks.

--QCcB5JEkX2RALVsX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEB3KAAoJELSic+t+oim9xycP/2xpeYvLYUVvq+lRol2KMj0d
IucnlYONjEO6X7/bD0Po3yYDb3XTeyJ2wnYQOZ0nUZ/T1PxRO39JFsqo2f1s4/vj
ZIemlswEKBoWludFrpblKZRKqs+w9IXSeqFJ1aZC+orEn84ZtcTpbsoJZsFflifB
jJjk+vzTx5k2g2RzsD1Es8YlVp0BMGCE5Joy/Sl7ccKVDIY+qbRp9BWqkouzPmY0
tdKynkhPnltx21p5lei0F1lnXZGUUhx5nnC5oRhrd1NAAlwY3wGTa2RP3Oa1xMog
2+nxpv8MG5sRQRL3dVXEhKqQud9kqOojdVnRY/xh3z6RUom3VBFpC0NbNiEDQevF
yYssbN1I74UIggNlMGN/FhsjRiMBESsS/wrkqtH5+8EI1otvyxePRJP5pGqJ/YGn
atpCewQKhXA6LhVySxulfAmK2TDXwj384rXum9IkaI6qjlP0H7z1nwhASKui89ne
WMXuINoZcpgoHekce/tQlgr3AhT57R9AArNKyxIHGqxhhIW27eM7ydyJPcWAU8Uv
FwYwkauC51Cz5P0qN8fl1c8TRMT20nG+pQm5W6zUU7lkYwWVg1A6hWdhleSNba3Z
3z6spNNjEv6tLM+F3pQp12YFOX/unB9Rae0v3lfaqVijr0Ihm4Wy+7B64YcsdI0T
MdoHGpVDxFJJbjSC1BdN
=c+pw
-----END PGP SIGNATURE-----

--QCcB5JEkX2RALVsX--

--===============1055661139054756167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1055661139054756167==--
