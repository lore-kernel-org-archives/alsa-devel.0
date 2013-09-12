From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2][RFC] ASoC: add .of_xlate_dai_name and
	DT support
Date: Thu, 12 Sep 2013 11:39:00 +0100
Message-ID: <20130912103900.GG29403@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
 <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3097058653835897995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED912615AE
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 12:39:09 +0200 (CEST)
In-Reply-To: <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3097058653835897995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O/h6J1ag3HNdqgMf"
Content-Disposition: inline


--O/h6J1ag3HNdqgMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2013 at 05:38:33PM -0700, Kuninori Morimoto wrote:

> This is very flying RFC patches since previous
> "ASoC: snd_soc_codec includes snd_soc_component"
> has no response at this point.
> But I want any opinion about .of_xlate_dai_name implementation
> and DT support method

This all looks basically OK to me, though we will need to go and update
binding documents to say which DAI is which on the CODECs that use the
bindings.

--O/h6J1ag3HNdqgMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMZnBAAoJELSic+t+oim9RTAP/A5iHfiwig6f1vVzDXuhCtkU
2AbIWslLm1Ezss2+gdb/j8mN2lM6Mxhhoma7i1exndYDV/rithcvVMod6qaZrJfr
8oQq6L9cBVUvi3MRIneGmc+ygG7gS8tWkshmy/d4AwPdeAZdCrNHfPUQOz259Hl7
IoPjk5E3Q/r7j4rvd5YuqyrcfHJdMia/9fbLIie7E5ow0j5FcV5/LAvLvr/BEvD3
EP08E90VVgnRhlHCmgS9dDTXh5mcoCm/MRdzZ8FtnN/Y+BNNBL3Iszy7lZHtbssu
zC8DbDOsyJuwLtAscNWyEnprt9K4EwpSQw1BONdvvF9ePK+mz7GXeVFTFYL56do6
JtCyPqLsmZtDCafQ5nd/kGrQvIbxwYK/UaCbKYgVF/Pze/RmrxvjYU52z5G596Lc
vaH2R2nQoWkqxUbjL/es5PMC6VZ7ynF1qlIODal4vRIe2tV9wudbNHcwV1OrcnqM
ZcJZiD+gcbb+CwqWP1SEE94+lHTkf2/7xXvnVMfIElU2PNWLG0kCnAtinfNyKr2U
QO1eIQpYoUdNZh3z+IIa0+Vezp0KGIKDHsRRd1rq9TOr0DIEdfLyGoglTqQFwCYu
nk6giv1QK/caUI/aperc183wmJQGdWm4awusSzGkmg2Ewkl2xNNc5zBLBp9bqb1v
Eisaz3aHR8R+AVEqRYPZ
=PQPG
-----END PGP SIGNATURE-----

--O/h6J1ag3HNdqgMf--

--===============3097058653835897995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3097058653835897995==--
