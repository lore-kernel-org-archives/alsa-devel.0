From: Mark Brown <broonie@kernel.org>
Subject: Re: 3.13 regression on panda board
Date: Wed, 4 Dec 2013 15:55:31 +0000
Message-ID: <20131204155531.GY29268@sirena.org.uk>
References: <s5hfvq84qxd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7769955829385953429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AEEF2617A5
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 16:55:36 +0100 (CET)
In-Reply-To: <s5hfvq84qxd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7769955829385953429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0btr6/5+bhBdui6J"
Content-Disposition: inline


--0btr6/5+bhBdui6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:43:58PM +0100, Takashi Iwai wrote:
> Hi Peter (or anyone who is responsible):

> could you update the bugzilla report below?
>    https://bugzilla.kernel.org/show_bug.cgi?id=66451

That's probably not even directly audio related but rather from core DMA
changes (though perhaps the driver is buggy).  When akpm forwards stuff
to the lists he tend to include the entire report and CC bugzilla -
that's generally more helpful in getting responses since people don't
need to click on a link or anything.

--0btr6/5+bhBdui6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSn1BwAAoJELSic+t+oim9aycP/2D+5TlmniGeqJxrIeMHH3mK
9gdBEfAnDWzNQDsC8uZlmLvpNAF8NquJSeQPnmlM4qcvW4yURp/qQjEOGkmdebkn
vO0vsdnzK2g19dZIolliHMMcnUxqhh2p1rduu8YcUtNJ1QojU3hB8+AseU+gd+WI
hLnFm7md2SRP0fX5vFlqe5rv7/Td12GoXO0zCgJ709o+XlncknivqByMd0Ea6GBe
X39+r9sAPv9GPCXkpJdxYfiBBSFr6SOjxhgd+bE0ZcanmapLzpG7FXjYAN/OrERQ
yWahCwKZ2nkdWBrwKDw57uSECnUORQq/K9DvFZJ4pwvDRBw0J/cTTBL3Z2dy9Lzv
uzKr6XhpMfZH4OL2HJ1zowmDKUAN3ysesbf/2s6RSUW4FEqHGv/q08fysfAuZ6Pi
SsAAt1F71fZCZk0rTmY5ATB/TWhe7+lssfFdcaXgQi1Hrl/vk8UYCiqldrtnbeKW
MgPPR+hunFYo3Q15kCeRVEp7LD6uDXGZ0EEGadHp9jOzXYHBQJyegmpczRcVC9Yd
lC3iy7TssM6qxwPMui1aCL1HlVNfEcbShGkBdiQ22rP/TvXJ/jmfQwBweQqOx5D7
TqrRalUlVyTh0XpGdG0a3zVtoB/cdLp2DwRlHPS7yj4kDEdfLCBnTMdcQT/fpJlQ
indTHaL+bUrpSNg8AIqZ
=wDt+
-----END PGP SIGNATURE-----

--0btr6/5+bhBdui6J--

--===============7769955829385953429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7769955829385953429==--
