From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Set SNDRV_PCM_INFO_JOINT_DUPLEX for
 PCMs with symmetry constraints
Date: Mon, 2 Dec 2013 11:17:35 +0000
Message-ID: <20131202111735.GM27568@sirena.org.uk>
References: <1385829538-26355-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6662580782430682207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C72E261A15
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:17:39 +0100 (CET)
In-Reply-To: <1385829538-26355-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Florian Meier <florian.meier@koalo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6662580782430682207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NXNllSbYJgZfvk8p"
Content-Disposition: inline


--NXNllSbYJgZfvk8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 30, 2013 at 05:38:58PM +0100, Lars-Peter Clausen wrote:
> If there are symmetry constraints between the playback and the capture channel
> set the SNDRV_PCM_INFO_JOINT_DUPLEX flag to let userspace know about this.

Applied, thanks.

--NXNllSbYJgZfvk8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnGxMAAoJELSic+t+oim9O6YP/2Qx8q42EtcP75CPnGO9HU7I
++osPCw3PgwTYu+cBbgL5ERjzkP2c88lrVkRKedxAojqG90Td0u0hwZQBsZiISDI
9w7yc6VQ0hxnr4DUwIdXsFFYHd06zoMMEufE4T663VpTxgQkIAWMXEB3wvYiJ4I5
hTkQFAXpB5RHmwzujZvU4+8BCefR5byICADAExbyJrPmojXz9Q1eXnadx1ORVVAN
2yFRpKDfLRJ2bQsk59Q3UQPF8yoOxmR/ICYGa+bNcFop8uwCBIlEuGvLo801tjjO
l8X600KRsX1zEzdzysbN40/yzHNzZq06swEC7KU2svPkEx8lH0i0Bmp7zSdrMoKY
f6V0T6qIzd+ozhXTvKVWq+AdHPkULkmcQptaPnthVVRmoCCAbOo3CL0NgMFIaNWo
kt0vQ1SUeMdO/1GlON+MgdrdcA7Xif6zHtnCDt5FdtCrlLlhIHPC4fKGL6OfG/SQ
yo5nF2xZAIvIyoADBsFwdLugUSilzEZmbk9jKhd5/vNTDXmPZhlxyrvR/zdolRcM
JsqbPjz04ySd9DJk8e8N8DbTe99Gnl81AKdJ/Qi6ap29hxmUDojNK1slWBPNeZEm
XkAI0keij9QZhr9Vdz6LD4QuNlS4JYGp3mUcTR73Jvn8MmXS+eeTzQc5IXxlOS82
bH20qNu4je2UVnxoVuwv
=//bt
-----END PGP SIGNATURE-----

--NXNllSbYJgZfvk8p--

--===============6662580782430682207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6662580782430682207==--
