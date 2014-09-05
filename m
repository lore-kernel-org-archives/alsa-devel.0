From: Mark Brown <broonie@kernel.org>
Subject: Re: simle-card DT style for DPCM
Date: Fri, 5 Sep 2014 16:55:13 +0100
Message-ID: <20140905155513.GE29327@sirena.org.uk>
References: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>
 <20140901143047.GX29327@sirena.org.uk>
 <87mwaikdzx.wl%kuninori.morimoto.gx@gmail.com>
 <20140902113407.GV29327@sirena.org.uk>
 <87fvg97ecd.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3756039223549718602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCDAE265731
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 17:55:32 +0200 (CEST)
In-Reply-To: <87fvg97ecd.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3756039223549718602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1TlZXgau9qP5MFoa"
Content-Disposition: inline


--1TlZXgau9qP5MFoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 05:11:22PM -0700, Kuninori Morimoto wrote:

> > the driver for the SoC can know this.

> I wonder how to know it in driver ?
> (How to switch normal <-> FE/BE ?, and how to know FE or BE ?)
> Can you show me objectivization example / idea ?

Surely we can just put a data table or two in there with all the routing
inside the IP in the same way that we handle routing within CODECs?  It
doesn't seem like a fundamentally different problem.

--1TlZXgau9qP5MFoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCdzdAAoJELSic+t+oim99dQP/23XxDPmbZ+T0MB6rtkotKa/
WEz4RC/uUA1CIGG8/XOdfVy/hfuDtx06BmoxWSzs1dGyOrtJyC5DKL2JpmkV2bHi
s2PldeKVyDUlit/fLJtbTJutRGvdnTfY7vyVoOCoA82+MDptG5SRaoZU7pCmDuDb
1V8nQOnE6NYOoeWl7a2a2EDQeFEgG+bBerHd7r7TMg3NGKesI3kYKspYoAblKoC/
rIBGYQVi+vOElRPRn6NGTP9SfpHlRvGmaQSn/xVkeUYQH0hoQYb9eJzDo1G/sTAz
7DIYnpEFCr4V3HBBWz1Whq3PQiZhuQby42pU6Gbytj2rOuZpYHGWx/ewrSplsBvR
Vak7C86UvFbc+ejWXLS1CHcd4qolPWpIMytVHHD99XJYQEh0nCqmXM9fg0whKU+T
fUrkYJo9vMY7LCZfwmcO7Giesedh/wOfjgguPC1f8yVy+KaVxukrBSxMGtuYHSSm
AohP0fezLBmrsEmiWnbqeip9P43S5+5HXmryd+Pv4MsHTko6fNf1HEzbXvNzvfqt
/ovN6RNa0L0KKe+jIS3KFV1TMrSF14pWFGknjd4dWBeQb1fqRtPFX8k6+0xDkd4V
w5d3slxeqj+uvCm7L1FltZWSXdVGZROosZxouKNl74r+KEaR5kG3aAxd6xwa/JCX
yvNOMBTdNrIlPSmrXH/u
=RfQp
-----END PGP SIGNATURE-----

--1TlZXgau9qP5MFoa--

--===============3756039223549718602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3756039223549718602==--
