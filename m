From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Interpret ADSP memory
 region lengths as 32 bit words
Date: Mon, 4 Nov 2013 08:58:42 -0800
Message-ID: <20131104165842.GL2493@sirena.org.uk>
References: <1383566624-9242-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <1383566624-9242-2-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8804124370131331241=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (unknown [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB6DF262629
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:59:15 +0100 (CET)
In-Reply-To: <1383566624-9242-2-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8804124370131331241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RVLHdg3qhy1T2deX"
Content-Disposition: inline


--RVLHdg3qhy1T2deX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2013 at 12:03:44PM +0000, Dimitris Papastamos wrote:
> From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
>=20
> Pad the ADSP word (3 bytes) to 4 bytes in the kernel and calculate
> lengths based on padded ADSP words instead of treating them as bytes

Applied, thanks.

--RVLHdg3qhy1T2deX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSd9I6AAoJELSic+t+oim96coQAIUhVjx5/BVUAZ9XVRtn4nJW
RNTh7zPXC1cLpT4WjskOvxfmUeXHT9KClDCLLKyWclysbILv61XdjKFZd+q2rlat
Di6IqREPGKInCrrJCoCgfBP05P1COa9LJ+8dxuObvxLiMOwyj3WuO+YQ2ESUb5t7
DKKDeMTlE/jCS4vJcyw5ewmoqGNrE1nAgD0tXLOQls9sYSSYk7dT1hePm2aCEbnx
W1SpGGod+e/ZDhDIoYoQ1jlUhN8QTBNx18x4FBDsqo/X6s8ix2wJ8Ppe6ZFcOs8c
sfTwR+EdorWu34ddLB+N3RPuyByVYNYA2D7i3cx12AEQOIQ9BYfW+mN5q5ezrAss
LAJ3jmJ2aBdyjxt0L0iccAdcsSVaSffexo94Cq1gC8W+0MKDq8GMmDOp/WqxMUY2
Jm0Lu6r6zsTyM0sexW1A2HNcpIgVtjN7LJkGmp4twHYcbqe7hqspKlofU4CYyT6+
7KSI9FKtmdMr1Ce5BZdJhit/HMu0MWbICNDvnK5/LgD6HdLExR2XyZ0caBeqHu5p
QiJcPOT7fK+Mfui8BetCuxqRM+bNdGNH0+wQ4lswiRX+t+VRIwSvwgAnIrfZ2GdR
MmEqhrROtwJ3QnBoYOCCs/2waLdd1c7QzKWfePHUZUhETpt9FlCusAndH3uC6TvA
MGF+VuKnRFQStdCm+075
=n7dF
-----END PGP SIGNATURE-----

--RVLHdg3qhy1T2deX--

--===============8804124370131331241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8804124370131331241==--
