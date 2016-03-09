From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: extend FLL function
Date: Wed, 9 Mar 2016 09:40:34 +0700
Message-ID: <20160309024034.GC3898@sirena.org.uk>
References: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032316.GG18327@sirena.org.uk> <56DEBE7D.70100@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1143654895099229818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E97DE261537
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 03:40:38 +0100 (CET)
In-Reply-To: <56DEBE7D.70100@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1143654895099229818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2016 at 07:58:53PM +0800, John Hsu wrote:

> In the patch, we add FLL clock source selection. The source can be from
> MCLK, BCLK or FS.
> Besides, driver extend higher frequency for better performance in FLL
> calculation,
> and has different register apply if fraction or not. Just separate it.
> Right?

I think that's what I was asking for, yes.

> >That comment sounds *very* suspicous, if we are using MCLK we should
> >manage it via the clock API.  If the platform doesn't have good clock
> >support we should fix the platform.

> In initiation, we get mclk object from platform as the following code.
> If the mclk is not found, we don't need to prepare it in the driver.

>    nau8825->mclk = devm_clk_get(dev, "mclk");
>    ...
>    } else if (PTR_ERR(nau8825->mclk) == -ENOENT) {
>        /* The MCLK is managed externally or not used at all */
>        nau8825->mclk = NULL;
>        dev_info(dev, "No 'mclk' clock found, assume MCLK is managed
> externally");

This really isn't a good way to be handling things, you should be
ensuring that platforms that have an MCLK provide one via the clock API.
If the clock is missing that should indicate that it's the second case
where it's not used at all.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW340gAAoJECTWi3JdVIfQpYYH/2Cl/myC1OWOY7wbFQ3fYj7w
YaOKONP3NKRvJU3KXpmW8aYBz1laj3AaFVQu6vYRiwJdEMAwwzSuLow5vAgN2B1g
/LrwotC2teFR2bvu5s7ZSAjimNamlAbApRdUsJwLlTpSBvlDi8Y1lveFY6IRnT+S
0ZXAlWZeuv7zvvzkHrNz7z/po5tndut6Zc+Hn7TzFb1XBIsvHeyonoDjHDiyGZ7J
pQ2Hr/hzZ0YBIetyIYQgzO8IzVWZhloDREI2/PCHeHJb57/9FF+1mQ4uT7iclT5q
B8R3W3uwuoGtHm1JADGy/Ufwt2sFbvUWsSG55OaoJSmSk3lzKe5bkpV1NBRym8M=
=NvD/
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

--===============1143654895099229818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1143654895099229818==--
