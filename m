From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: add bf6xx audio dma driver
Date: Wed, 24 Sep 2014 12:42:32 +0100
Message-ID: <20140924114232.GI16977@sirena.org.uk>
References: <1411552520-26090-1-git-send-email-scott.jiang.linux@gmail.com>
 <20140924082622.GW4015@sirena.org.uk>
 <CAHG8p1BxYz1ZunaGRo0ruJPSU17uF5XRttqn--QeWEExMWWNtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8477047402643606935=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10EED261685
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 13:42:37 +0200 (CEST)
In-Reply-To: <CAHG8p1BxYz1ZunaGRo0ruJPSU17uF5XRttqn--QeWEExMWWNtw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adi-buildroot-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============8477047402643606935==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 06:02:40PM +0800, Scott Jiang wrote:
> 2014-09-24 16:26 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > Can you go into a bit more detail on the differences - clearly there's
> > some similarlities since the drivers got merged, can we really not share
> > any code?

> First, sport2 only supports i2s and left justified mode, while sport3
> adds i2s packed
> and right justified mode. Second, in tdm mode for sport2, tx and rx
> are dependent and have
> a window granularity of 8 channel. While sport3 doesn't have these
> limits. What's more,
> sport3 is not only used on blackfin. That means many patches can only
> apply to this driver.

These sound more like extended functionality and tweaks rather than
massive updates which need a completely separate driver - new modes and
so on.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIq4nAAoJECTWi3JdVIfQkTwH+gNCyFeJ7lO+5/zfu2nFKnO+
vgYQ6eibWLM8WNHrht+JRZUX4or3baaBqQB9GO/VORKOLIAxUD8gHwLSN8jBvZop
UjZCicKKQyEEcie017oq+ruPxmq0EIPL3106dgwVIqcbxaUqrkXnR/wtRSmyHh36
AcvKJEr+rv45NiknqCj9VUaLcS+YWsWpRme0/dWte5rvSbGp+uvSVJat2d1MGzY3
wJc5tYS1CO+9y6kfHz7yXZZrRbSjOHKMTuewyrnp2YmGgzJVTShfM+Tny0SkTvhi
Jpsq7ozOSPhYplr9DD8QgLo1HWrkJ4gZBARzRZVHcULTZoLYxdjo5KrlGhzzuo0=
=qq9q
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============8477047402643606935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8477047402643606935==--
