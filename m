From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate
 based on slot number
Date: Sun, 26 Nov 2017 21:22:15 +0100
Message-ID: <20171126212215.1f984a9c@jawa>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
 <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
 <20170913230147.GA21287@Asurada-Nvidia>
 <20171125232921.01994d72@jawa> <20171126003622.GA7276@Asurada>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0386370571728085787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1622670C1
 for <alsa-devel@alsa-project.org>; Sun, 26 Nov 2017 21:22:30 +0100 (CET)
In-Reply-To: <20171126003622.GA7276@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, max.krummenacher@toradex.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, caleb@crome.org, tiwai@suse.com, mpa@pengutronix.de, broonie@kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

--===============0386370571728085787==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/crbDPMbWs4Bbum9pNHcdk6i"; protocol="application/pgp-signature"

--Sig_/crbDPMbWs4Bbum9pNHcdk6i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nicolin,

> On Sat, Nov 25, 2017 at 11:29:48PM +0100, Lukasz Majewski wrote:
>=20
> > Nicolin, do you know what happened with this patch? I couldn't find
> > it in current linux/master.
> >=20
> > Has it been applied to any asoc tree for being upstreamed? =20
>=20
> A similar patch with an updated subject got applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?h=3Dnext-20171124&id=3Db0a7043d5c2ccdd306959f295bf1a62be025cbf5

Thanks for update - I was not aware of it.

Tested-by: Lukasz Majewski <lukma@denx.de>

HW: iMX6Q.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/crbDPMbWs4Bbum9pNHcdk6i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlobIngACgkQAR8vZIA0
zr3a6Af/Tnsxno4ByiusDxsJjRrTblzhiSpcXrLvPziM9WxNDQECI6JUTFAByXJF
ZWoPHG2R6clJUmnWfuqxnSa8L+p322Jas4ypmNU7cZPHPGvX79j7NqbWkCskn4lS
YYSkRgDxjuwDD4JmGbG6NcmdwUMgGCrqMsAvz2XdHPolKKMZq+/Vk5ue2MykZzMb
QIm0SoRKvWUkUw4jU/K2wBqwNGq7D5iIB4iKyOs6eoCeM8E7I0RRVZ8zhd7RBnEA
hGMHWur+EpVg19RWL9/c2Aj7v2CJYqB8SCKoWARpojC7g722wT+yWrzJIK26XFbM
wIc7GWjsVlHhlS1jcbtQVxZq3oaO0w==
=omi6
-----END PGP SIGNATURE-----

--Sig_/crbDPMbWs4Bbum9pNHcdk6i--

--===============0386370571728085787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0386370571728085787==--
