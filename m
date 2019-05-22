From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Mediatek: MT8183: enable dev runtime
 suspend and resume
Date: Wed, 22 May 2019 16:31:28 +0100
Message-ID: <20190522153128.GF8582@sirena.org.uk>
References: <1558536724-18293-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1979129659672657977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99EBCF8079B
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 17:31:31 +0200 (CEST)
In-Reply-To: <1558536724-18293-1-git-send-email-jiaxin.yu@mediatek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, tzungbi@google.com, linux-mediatek@list.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============1979129659672657977==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 10:52:04PM +0800, Jiaxin Yu wrote:
> System suspend will power off audio, so we need regcache sync when
> system resume.
>=20
> Remove pm_runtime_get_sync in dev probe and pm_runtime_put_sync in
> dev remove.So that audio dev can triggle runitme suspend and resume.

While allowing runtime PM to run is good it'd be better to have a
standard system power management resume function as well that ensures
everything is restored after suspend to avoid unfortunate interactions
with user configuration of runtime PM.

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzla08ACgkQJNaLcl1U
h9CTmAf/aR+hpSMlz7odh/3zH6QgA5d+Q1r6lg/BubEjiLp6YWSBxnzUsz+fOcYh
zJ66EYLu6KsH/PT/vkYXdxAvt9n/agC6ZRHcpZJOuMiDhItY94ZYTFjZvbt8krx2
DxW2O9b6OrFu8jaPle0D5NvWWA+F1az9oaGxBicgJ4Qh7Cput5ArKP6v7mbaveuU
Prc01/wsk81KuqObX0PchyxHabyR7ntaGf/SjrGUdcpQBLfPBKspfh5AZHo3wtRj
vwEj5YGoXInhcVFvUEJCqmVVI3v8y9peD2BmPrz3fvE6J2UiRMAHLiPq8WzUydzR
tK1wpu+piOp3gK0fJEydVpnjYMTHnQ==
=mS3Q
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--

--===============1979129659672657977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1979129659672657977==--
