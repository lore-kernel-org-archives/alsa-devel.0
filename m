From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: 88pm860: Fix IO setup
Date: Mon, 10 Mar 2014 11:29:38 +0000
Message-ID: <20140310112938.GC28112@sirena.org.uk>
References: <1393922364-31624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9200909599141380221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 232CC2656EF
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:29:45 +0100 (CET)
In-Reply-To: <1393922364-31624-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9200909599141380221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aCdJlaQyeKyXI/LY"
Content-Disposition: inline


--aCdJlaQyeKyXI/LY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 09:39:24AM +0100, Lars-Peter Clausen wrote:
> The 88pm860 is a MFD device and the CODEC driver is using the regmap struct of
> the parent device, hence automatic IO setup will not work and we need to
> manually call snd_soc_codec_set_cache_io(). The issue was introduced in commit
> f9ded3b2e7 ("ASoC: 88pm860x: Use regmap for I/O").

Applied, thanks.  Please do use Fixes:

--aCdJlaQyeKyXI/LY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHaIfAAoJELSic+t+oim9I3oP/iwFnRSzoUT5EgpVdAS61r2q
acRa8prDApbZ0MGZgrNCka0x/TjTixi4ef2K6EtYXBhaazOGNcSzZTrEflzU5xs+
tYMto6SZngpaSTDd2Is3PjtTQGbm/J7LkoV5Dscp31f/Fg9GwIUtFujUSGWMnvBj
YSU0ymwkCAnC2Ume4FRtsFlCf47JGg4Rw0rwIDwXSIKRmK1TZ6LI4c3E79w7icWN
ZOH002DfAwdnx8K7yB137AbSH/wtUOC6SnibDeDbRJpOw0UrwQnP9ASzLMYrv+5H
dE3P9Q5vSe1laVJ6PfLONHeXQL+KzwOh5o/b57pDzFDBvwGCVrXmMY4SuHA5TbWJ
AEFhNSOyCgEM8urMHo1sIBB8A97Bnpb38URBVNtxXcdePjWxNe/67yjwX0rpvNcQ
qK9hloGfURIsYRCP/u1POCzcZEG2nO9r7xd2qyLR7F+DSf9SGZ2Sygsd+D/RNU4J
RBglKmnYlPZd+8BhWSPC87lyMTeR8L9g6D/XZCEu60OPfOzfTTB+YwXvavNEsF35
g2joa7EwlxFotVt8oHaEOqlLvTU7crVL7CdoScJyHK8xpCqDLkZt+JrKs7f0QOMQ
grj758kgaLpYKuRMZs/3i3se3SKEzzKRzGKJbcbNUl3egsg2VbPgxxiWiHc+Q3cN
/azs5bqSZici/PpN7dSZ
=+LMr
-----END PGP SIGNATURE-----

--aCdJlaQyeKyXI/LY--

--===============9200909599141380221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9200909599141380221==--
