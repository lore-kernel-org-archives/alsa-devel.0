From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: atmel_ssc_dai: add dai trigger
	ops
Date: Wed, 4 Dec 2013 11:43:57 +0000
Message-ID: <20131204114357.GG29268@sirena.org.uk>
References: <1386124624-22414-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4130170834762844863=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D76D9265366
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:44:10 +0100 (CET)
In-Reply-To: <1386124624-22414-2-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: zql@glomationinc.com, richard.genoud@gmail.com, nicolas.ferre@atmel.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4130170834762844863==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 10:37:03AM +0800, Bo Shen wrote:
> According to the SSC specifiation, it should be enabled after DMA is
> enabled. So, add trigger operation to make sure the right sequence.

Applied, thanks.

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnxV6AAoJELSic+t+oim9zkIP+QFeLMaZ2u4H3C7Dt98U3ogl
NDfHx3/gqoPR7ACed3m1kgZajqyn+TAxau6ECKpjkkeJOew+aMtcfUFrcmYq7jWS
+K5W7wiEv6oWtQmCCb7nVO8DKZPzb7PzLO/iTpdAB6RJ3AjeyZXLWhz8vJWKrdzM
wuaHVYaTXiV6mA6SCw7WzviO8QmXVNg4ehDJynWJ7CDF0kK41LfS/WG7FYVk3yVQ
GKy5xgTx6OYNELuvg/gar6dhQyB3n0521k2sUZbptAgYjZzU+bye007dBNM5FS2P
yDUroeYzmOAFnoy4+MrILSIIVei94lio5JTrGH7JMj1Jw+Bis2RRdfsG8ikGXDPZ
wq+aL5ltEoexeFLkmfu9GaMk8SX2f7QWE314XdXrDG5ip281JydgNN46vcxLm7Pp
HKGk60wu/qAKlF4uAyX73iIx36vs1FCrnNceBik8NVkjqBQfLUucTJCGbTNLTr7f
Pz3tLtLmo9gPKAuaXrEUGt+Yk+uJaGGVUq3LmTthFWpyzW84pQNtAOJKO1Su+7Za
Ac8+ZvAEXR5iYVZEAlKOxtQKVv/0KPNq9UWTxzOqIGwVPfuo0hYJaALQc6NI4W3o
GX7CB1TUGOH70JTwNfzSnitFoq7U8tqsUzqzGrFOCNtekpdplwmlU44VUxAj1CgC
sxR5OdCD1Vq0ogamH/ki
=SrSx
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--

--===============4130170834762844863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4130170834762844863==--
