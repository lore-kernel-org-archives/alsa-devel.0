From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: Remove superfluous locking
Date: Sun, 23 Feb 2014 10:51:20 +0900
Message-ID: <20140223015120.GB25940@sirena.org.uk>
References: <1393091057-13510-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5002968990320685080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E66F264F03
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:32:07 +0100 (CET)
In-Reply-To: <1393091057-13510-1-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5002968990320685080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zKD0QXBepZ0ysD7Q"
Content-Disposition: inline


--zKD0QXBepZ0ysD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:44:17PM +0100, Lars-Peter Clausen wrote:
> The locking here was added in commit 71a295602e ("ASoC: Lock the CODEC in PXA
> external jack controls") to protect the DAPM changes that are made inside of
> ${board}_ext_control() against concurrent updates. The ASoC core was updated in

Applied, thanks.

--zKD0QXBepZ0ysD7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVQVAAoJELSic+t+oim9iI0P/1hS6GyCgHMgKLD4gxHhU/li
W43ESIzuiMNT2/GYTM9DOHUBqYXS9KQgOpUPrGHSw5zIE3Lu6LaHnzy0nwEI1xvP
CSjiRMbZ029eaDCMiAl/EEAw+GbDZn2KGgjJJxOYPVy3JOeFcqC80NnzU0PMbKbk
sgVxb5KZ4w7yCihnPe64AoXCaWwRbVqMHe9PPxxIantfvL/YscQdmKcdxnf5gmww
JLPGgPS5pEmGlQfZJv+t7hyU/G9iXCYYqXzGrglFWnU62L22xSFJh/JgEASgvadr
3FDaSDYAJYtlpARvhlzctyZqOpCLHFkzF2taiSsfqaPm4hgFrL7Pv8/FqLnrCdNw
3sNyJ+LS8WSovaiegm1IX46EylY5XJwtp8o/8SgzABZKZr2M62A0mnTfi+8LUeWz
DfnBOJzH+T5TYcyzTgBlSkMLIZc4qfG9ytN51d89Xc/nj1mB/6fct/nhEDA0mnfX
Q21ecxNpScU2HUVGf6SKr004Zpu9TLK9VUSLNCCp04BTE5WH/oupQLv1TKr61JZA
cbMPT8S/xuDmOUUM7xyXpBLE2ulVYm/mINSawvSaDGGgM2Ej7GIZMo3Xq6c5ggPr
hn9MjO+mhC8Ttkgx/rP4mNPjdJlUFYyvAvlxu79ghdT7q9X01z3TFFYkDh94l07n
VBWNFMj0Rs83obtimd/u
=nf5i
-----END PGP SIGNATURE-----

--zKD0QXBepZ0ysD7Q--

--===============5002968990320685080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5002968990320685080==--
