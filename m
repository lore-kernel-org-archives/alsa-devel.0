From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fix a possible NULL dereference
Date: Mon, 30 Nov 2015 16:38:56 +0000
Message-ID: <20151130163856.GC1929@sirena.org.uk>
References: <1448455796-27315-1-git-send-email-clabbe.montjoie@gmail.com>
 <8737vtejg6.wl%kuninori.morimoto.gx@renesas.com>
 <20151126071715.GB28184@Red>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8341834723060793349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5890426156A
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 17:39:02 +0100 (CET)
In-Reply-To: <20151126071715.GB28184@Red>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============8341834723060793349==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aNVYTE9V2LY2iLDz"
Content-Disposition: inline


--aNVYTE9V2LY2iLDz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2015 at 08:17:15AM +0100, LABBE Corentin wrote:
> On Wed, Nov 25, 2015 at 11:46:45PM +0000, Kuninori Morimoto wrote:

> > > +	of_data =3D of_device_get_match_data(dev);
> > > +	if (!of_data)
> > > +		return 1;

> > return 1 ?
> > You want to use -EINVAL ?

> I do that Uwe Kleine-K=F6nig said to me to do in others thread:
> https://lkml.org/lkml/2015/11/12/70 and https://lkml.org/lkml/2015/11/16/=
211

What error code to return is going to depend on the context - you need
to look at what the caller is expecting and how it will handle the value
returned.

--aNVYTE9V2LY2iLDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHufAAoJECTWi3JdVIfQ1PAH/2atEF0EmrSZKXVNjCbj5yo2
mrcD5+cBcAAzLgRNA4AFV2SKjHc0lXRdcOC2CIq8i6r22irl0GyeA6RV45DzbW7N
TGi+lHbYJAfcryHP7XSQpzopMQD+QxYn+U2pVm1wBLec+r5ZzBDyfvrTBk8eGKwt
Zcze/Uupik3v/QRn586HeWLHwofZPW6rFcKt9X/9j6zYbq0GFC9i0WWKh0uXXehQ
+UAcj6Pz9vCKcWFy6OuA2wl77SpCsAruePHbvD/jXKjD1nIs3+uiUCul77W7o8JP
1EZHXbHp7YcobOtnBKk+yCLfT8KY3b8PbCo0nxCd4aFeU66aXofG68R3OMUGCPY=
=moQz
-----END PGP SIGNATURE-----

--aNVYTE9V2LY2iLDz--

--===============8341834723060793349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8341834723060793349==--
