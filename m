From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Sun, 5 May 2013 11:15:15 +0100
Message-ID: <20130505101515.GT4945@sirena.org.uk>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2704569826442262808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B5472261A55
 for <alsa-devel@alsa-project.org>; Sun,  5 May 2013 12:15:34 +0200 (CEST)
In-Reply-To: <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, zengzm.kernel@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2704569826442262808==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Content-Disposition: inline


--vru7fAags9pVPvn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 04, 2013 at 05:25:45PM -0300, Fabio Estevam wrote:

> I see this commit from Freescale kernel that workarounds exactly the same issue:

> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/sound/soc/codecs/sgtl5000.c?h=imx_3.0.35_1.1.0&id=2f7d47e760725d33f6b2eb01024b800d64ff8944

> It seems that caching is broking with this codec.

This is nonsensical.  Clearly there's something about the use of the
cache that is interacting poorly with the device but we've no idea what
it is.  Simply having a copy of the register map in the host memory is
not going to do anything to the device, there must be some other issue
at work.

> If this is true, should we go with the proposal of this RFC patch?

We should understand what the issue is.  Looking at the commit above
it's not removing the cache at all, it's both attempting to work around
an issue with the cache not handling the register step size properly
(this looks like it's just a bug in the current driver) and reordering
some of the startup around the regulator (the comment says it's open
coding cache_bypass but it's also moving blocks of code around).

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRhjEqAAoJELSic+t+oim92CgP/3lfIzxJLzWM7vBVtOH2YGv6
k9szePKV+0D0ZpEzqd1mZVJo204s8tYX7UykIuZJ8iTzwMuXUCO9nYohu84Xd2F+
daHtS9p+Ip7JtG9oX47IcDGGUN5ZPAWrayvCRwxr/xW99zw6Odae2izfTZkNqTx6
lKyVA1eT9XR9dzh5xsV8F8LYUMZMlbHDXDs2sEWcwYLTosZYdso5gpPpcjcgJSxq
8dOnyeOEJQcWJvS8PRFrxw4hBqTOwk4/F32nN46qIDWuDfGe60a1wITp3xMxDqwK
nlUvFaFZQGh1sVD/ikEDgWu5v2IuoPs1pz6vOfUvOEbD2Atj/BsiuEKggQeESyJc
JWLWH3sqEKwmHoPD5ORF3sSr+Kk8xCo5UBMaEOL8Yf6u7PHCDrdO3uZZg9et7R2f
aCa36L4KH1nFsIQzWuMFVElKaTu9I9w4xHUCPfOPWhks/FTfknyiGEdz71qdI2lH
Z7ggJB8Ex8NVP5S6R1HGrkxFDFeNbCn1xMkeEi3xB1yEDstxdb9t934qOJpa/V0S
2QUQzMj5HnJtKm2uU3qQpUYtLentePVm+noZVfUmijogkPUubTVvzrxA0XYOMBym
FZ2Ra+0nO8OXc/CYC6yvabwSjk+HIvbKAwQNv7gM5/9HV8D2rDkpxb9yZ2x9K+79
/GL1HFNCqhjqqeQmco8K
=eIvL
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--

--===============2704569826442262808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2704569826442262808==--
