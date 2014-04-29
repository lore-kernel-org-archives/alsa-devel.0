From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA
 where needed
Date: Tue, 29 Apr 2014 09:56:30 -0700
Message-ID: <20140429165630.GD16981@sirena.org.uk>
References: <6606961.lAGLvkNsEj@wuerfel> <4270904.84oGcCXL4B@wuerfel>
 <535F8594.40609@metafoo.de> <4275868.O962kiiyJa@wuerfel>
 <535FB793.5050200@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7652616475469561630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B10260320
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 18:57:30 +0200 (CEST)
In-Reply-To: <535FB793.5050200@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============7652616475469561630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2014 at 04:30:43PM +0200, Lars-Peter Clausen wrote:

> Yes. The patch should also add a select for SND_SOC_IMX_PCM_FIQ as that is
> used in the same way in the fsl_ssi driver. If anybody is afraid that
> selecting both SND_SOC_IMX_PCM_FIQ and SND_SOC_IMX_PCM_DMA by default adds
> too much overhead you could add boolean sub-options that allow to
> enable/disable support individually.

Yes, the overhead should be negligable since the FIQ code is tiny.
Arnd, please CC maintainers on patches - you've sent this to my
Linaro address again and not added Liam.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX9m7AAoJELSic+t+oim9eTsQAJWxK+D1wbN+rxCfu/Pj5ceh
ql+jL80gGgGdNlXZPa0FrTp+lak9s/ZRe266acyyIT/cLZhi5WB+IYOcdDguk5CU
w3cptUIPDFMgRrKc6wiui1k1MLG+6zic5FM60+Kf8dGz0RDLScMQdLXzb5YMBWn+
aFIr3AY46+EqIlnzejoOdb0z2grL+4zTTdqwplIO7yezXhFhAnvGeR35CwbKeGdB
Pb6LD+4oLPuYWrzOgG9e5kYq3SUjFNyLYvifnNPFZA3VYT5PbtoP405OrVA0SMW6
/F+6APlkdgr56qpCdxdYO8ArP07JKa/TPjXpIcXtxtGXKa6rXaObP6Yt3y6+4o13
Y54j8+syabDTBVO7/eIQ1FT+/v5I8n4uuiXDsWVPtCAIal5Ea/EFk13JWf2/gIG4
W8OASrL29ifh2ApgnSFWbm/zdFexMmATZNKPUXNRsVuVRPP3qIoIxQ+PSJKYl1ua
s7dlslS2EY3E7cWvku4Vc6K7yDE+3V5Dx3iAG2PPb+JceaVt88M9CymycQn3UXXo
tBGxn5S1k7KvEgg6CQfWNiRrk0lehjHKBfU3iup+cxb6wRu7vmaw+c3vvSkYJcXS
UGJCpvklnqbmDr7Libm6J9Ok+0FN9cPg3BOvzoY0KQ5r7l1V5Qz75yktkI3CuvBg
ZkA1IuJdVg6rnaWSiADv
=+Nzy
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

--===============7652616475469561630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7652616475469561630==--
