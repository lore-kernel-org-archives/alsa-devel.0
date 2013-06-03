From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: mxs-saif: Fix the
 playback/record capabilities
Date: Mon, 3 Jun 2013 16:41:45 +0100
Message-ID: <20130603154145.GO31367@sirena.org.uk>
References: <1370191092-1773-1-git-send-email-festevam@gmail.com>
 <51ABA36D.8020802@metafoo.de>
 <20130603092028.GD31367@sirena.org.uk>
 <51ACB14D.2050205@metafoo.de>
 <CAOMZO5BVwMM2Q3CAoepmc0dQgHDARKoUuUrab--Y=6WNm-GA1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852870212519972265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 70615261ADA
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:41:51 +0200 (CEST)
In-Reply-To: <CAOMZO5BVwMM2Q3CAoepmc0dQgHDARKoUuUrab--Y=6WNm-GA1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============1852870212519972265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2013 at 12:18:16PM -0300, Fabio Estevam wrote:
> On Mon, Jun 3, 2013 at 12:07 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> > I think the sgtl5000 has a single bidirectional DAI, but I'd assume that it

> Yes, correct.

So this comes from the board wiring then.

> > is not the only CODEC to be ever used with the mxs-saif. In my opinion a
> > better solution is to add support for being able to specify if a
> > snd_soc_dai_link is used playback, capture or both.

> Yes, I think that adding a device tree property specifying the SAIF
> direction could do the trick.

No, this should be done at the board level as Lars-Peter suggests - it's
nothing to do with the SAIF driver.  Probably doesn't even need to go
into device tree, just do it in the machine driver.

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrLk1AAoJELSic+t+oim9dX8P/iSx14wxqw8NNA5AxppqRbom
4DMNpubPAHpEq7A/TQ2nKKeUqBk9npCM51kVJk+t9NjF3N8EdD95crWJNLwPTdo8
EDJ6BUcsNUmf6Bgi7NgliNPtN3ENEWHdH+dCirA6SOwpDs1mLlfbuEJFSNxCh2LE
ULAFSiZ5dH6uelZNmzU/3dqVDELhYw6G8F/0rQwQUvGkdOglLyE2n0U/YNdapWOC
rW5ugtfFQ39cRl8sHD5IEJLbXEwB4VaLF+Jj0fAx+Ln3D8Oz4ANNtZ25H02YU93n
AgNxd+C77DsVMH4d0U+TkSvpDgWjP6PiZFTCX7uYAJ1uI6dIFa5gdX8HhF6LRbvU
GzM0sPFkEmLoIVvSd/gp2oZ7Je4ImCoDiIioYau7UwhdVexlZPyoJUfhmdkeTu/k
y0Wc4lxEDpnhit3dgcDwS9ZmY605I2yD+To0P/Iow4TOIgNJoboTV+Qx2s7KbVnh
1Eu+uJ2PhanFtQrcanRFpBstN1U3QIXvhuJx1p77HR498k/QLMnbvrVdV/TbeQ0B
Gy2ypU74mJ0PXGFknmhXghO3Z13GfSI6GTlrgjPw7+jRcN6riBSEYJL848PDB4c/
pHJ8VRY4YmK9HvSnf4+o0e/OZHPCtmQO0SPEHOwmUk+hV7ntIn/oVVkwQWslwqII
tHW1pZPkvCdixJUBfwjF
=lzYV
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--

--===============1852870212519972265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1852870212519972265==--
