From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bells: Specify REFCLK for FLLs
Date: Sun, 22 Sep 2013 14:40:49 +0100
Message-ID: <20130922134049.GW21013@sirena.org.uk>
References: <1379758218-28580-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130921132833.GU21013@sirena.org.uk>
 <20130921200836.GI3635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3212082230725808083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DE55C265091
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 15:41:00 +0200 (CEST)
In-Reply-To: <20130921200836.GI3635@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


--===============3212082230725808083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXVeTwB1tCcD1nEH"
Content-Disposition: inline


--AXVeTwB1tCcD1nEH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 21, 2013 at 09:08:36PM +0100, Charles Keepax wrote:

> Ah... yeah sorry forgot that, have always had a crystal in my
> board. Best just ignore this patch I guess we will just have to
> not set a good example.

Don't top post...  one option that occurred to me on the way home is to
put a #define in there so people can set it if they want it.  Once
Tomasz's s3c64xx clk API conversion is done you should be able to start
using the FLL on the wm831x to change MCLK2 dynamically.

--AXVeTwB1tCcD1nEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPvNbAAoJELSic+t+oim9fH4P/ja7fSQnQaL1G/p0LXM7/vRL
aG+hG8i3T1RwecQg178xfdGqQG3/EnHj39Dqy1O7u+/8YDmWDKkPpFfxHuyuNqj2
O/12xpfouqW3q69316C9TGaaU7LvxCTK47eE8YE7D++hKcroYtRtlkyJ4gLKjLjB
NxMsXNT6HpUSuRMrKMzrWoN1plaDMj4EOFTL3MeFDiZ1E13udViM0+tP7tPCepv5
rCQbo9hjHSY2YicJy7ir2+ERWlsA3yFqoTClmkE4U0rTgEaku2cCS4lOpsrzO1cN
nkwq6j2Cgh6n+8uZQ6oR4HeQb1j/K1J0klQY5zTKtCFFMf9UC/0ZEqs3c3vrksCM
Tr9HEjVZzN1PjQjZobmmKOvWcDSNwQZ+KwusgTg12uPmbBX9cJQCNpiObxPJxMHl
V6qlc3F8Xb3oQdHrsX/Pksv41N4k0AHW+UcOiHThnK7XIf9p0yMw4sHkiXkC0FnE
K8EbU2dB6gEPCGBtq8ZHPut0L3a02YH1KPtuZyeCVbk9xZ+mDArJafxdg/sRRzD/
KQoU7TATIi9tx4loi7inwosK3zPiRMzV58fKi1ey07NZL4Y6NN0g96tidXj2udvk
SeiECEkikJioHT3adER6B/LQftxxkjRT+pkBA3gbVMBmjTi5crcl1gH4qF2wKc4B
NlM8FaBxHNS/aTbOOXa2
=gKki
-----END PGP SIGNATURE-----

--AXVeTwB1tCcD1nEH--

--===============3212082230725808083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3212082230725808083==--
