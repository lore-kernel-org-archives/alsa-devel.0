From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: bfin: add i2s driver for blackfin
	bf60x processor
Date: Fri, 8 Jun 2012 08:59:42 +0800
Message-ID: <20120608005941.GA10455@opensource.wolfsonmicro.com>
References: <1338840199-19714-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120604150732.GM7538@opensource.wolfsonmicro.com>
	<CAHG8p1CGUAFCQbqN=dsMwQG9W+Ads2vVyo40c7Ay=X+wYaDVRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4644871037106170118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5642D10B9E3
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:59:54 +0200 (CEST)
In-Reply-To: <CAHG8p1CGUAFCQbqN=dsMwQG9W+Ads2vVyo40c7Ay=X+wYaDVRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4644871037106170118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2012 at 11:41:56AM +0800, Scott Jiang wrote:

> These two sports are totally different, bf5xx is full duplex, while
> bf6xx is half duplex.
> So we combine two sports on bf6xx to one logic sport.
> I carefully reviewed these drivers, only dma driver can be merged to
> one. Do I need to do this?

Well, it'd be nice.  But it sounds like there's far too many differences
so it seems reasonable to not bother, it'd probably just make the code
too complex.

> >> =A0config SND_BF5XX_SOC_SSM2602
> >> =A0 =A0 =A0 tristate "SoC SSM2602 Audio support for BF52x ezkit"

> > This bit also needs updating...

> Do you mean config name or prompt?

Both, ideally.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0U5UAAoJEBus8iNuMP3d6S8P/3TpTm/0P1IxXY2clWrqnTLz
pr9dPWRZHe4DnxxfrKH9nqVoAXu/394zJU9IXpp8hjjbpjD9Se5hNUOpHCCNywfP
0GdkRjjz2kNF2I77EtIQThUodc4xXDJGYj1003hZSkDKzmW0Lh0bHnTXQyvMh61t
BlTXf2fS+So8tGxYD1VjI/D3++m8sQYxFbXIDD6Aj5NHgfr9ZtxwJs6d34bBOhNI
fXITSokSr7MoaInBCE+dDE85qhAjqHuwnyMxyR2zNLOuYlH175KDCoNNFM3T4+JK
K1IHldtR1PzrV8LGZA3H2ZLYaucgvnpjAABWtCZ5C3fZGyQcn5s0/syshCM7wAnc
a0zk51IC3Bv3FP0Dho0/3+XazpuJkYF28L9Vaq3DLLfmPpZRenQbDuK6VwDqC2Ci
K9kUPCrjSND8dHbQWhKySq0X/Pzv9txw4IvxKxwI6YsfKUA0JjG5tpfrQE4uT7XP
7nUEfq68mGL4RvlnuiX348PfEnWsVVXJnPTApBVsinyTyKPmdfkPq3tH399sOx2w
o8fO6YGcyzYrwMKnrLHsFvxEwpMYFWYxKoRJVMl/O3FKHVbSXeClZnuNMMgXMWQN
RO0L3ue1fsmDJb1eunjAOJ+L4tBtSC//DGf1kBdVRFCJHAH+rXkpoyWg9DGNYnQ2
QTV+l3MPBNQXc2jL9Jw8
=03kt
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============4644871037106170118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4644871037106170118==--
