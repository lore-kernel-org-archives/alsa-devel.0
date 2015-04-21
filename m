From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
Date: Tue, 21 Apr 2015 11:05:15 +0100
Message-ID: <20150421100515.GB22845@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
 <1429510944.30743.36.camel@mtksdaap41>
 <20150420205511.GL14892@sirena.org.uk>
 <1429583233.14794.40.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429583233.14794.40.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, galak@codeaurora.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 10:27:13AM +0800, Koro Chen wrote:

> The SRAM size to be used is defined by params_buffer_bytes(params), not
> fixed (of course limited by the actual available SRAM size on HW), so
> the latency should be the same compared to a DRAM having the same size.=
=20

Right, some systems have the SRAM as essentially a big FIFO but this
doesn't have that problem.

> The SRAM can be used by any memif, and that's why the plan was let DT
> make the decision.

OK, if it's for any interface rather than just DL1 like Sascha said then
it does need to be selectable, but DT doesn't seem the platce to do it.

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNiDaAAoJECTWi3JdVIfQc1IIAINHf74XjKnuzrQshE/XdZpE
0oAxLCh8+dgYhoJuW5CBCE5Mipv2uQUHGUSkCoeNh2wvWOgcVBKme+XemSbMRwnJ
STifueuVEf+yDNpDL6RPdeefZVRA5aPzA3tmtnDh5iz8Belii0ZpxgKyG/Zt/wEs
0DpmZl0a50jXx59wLVLfAtrXJ1Zf37n0DlSTSjCeVo8Afx+hyIv1EN0L15+Q1nWH
R6GXbu2W60kjGmftbWM/OpsTlH2naXHEcg4VjZwMT/WOi/CCaFAVRuiSvPJHp1V+
dOircdCgDq7E7QZvXTI8L5DW6Wq34yAKoq63Rw8qF01tCwkMaHq7pmIcroaNUKA=
=sQO0
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
