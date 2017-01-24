From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: add simple-graph-card document
Date: Tue, 24 Jan 2017 16:41:26 +0000
Message-ID: <20170124164126.jquggggl7ct5znuc@sirena.org.uk>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com>
 <871svymrnt.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqLOwQn_hz3B5gFL-zr-Pm_8PX+b-sAQhLwkioD7E-ODAw@mail.gmail.com>
 <87wpdm1cyq.wl%kuninori.morimoto.gx@renesas.com>
 <CGME20170123091136epcas2p15643b17d26e629545b3848b22e1afa68@epcas2p1.samsung.com>
 <87tw8q1bct.wl%kuninori.morimoto.gx@renesas.com>
 <6e3976e8-d26c-e39e-e886-4ab00ce79d01@samsung.com>
 <87sho9fgju.wl%kuninori.morimoto.gx@renesas.com>
 <c4541388-904f-9886-7e8a-a609ed9feaa7@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fgjj3jgtvchpraqc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c4541388-904f-9886-7e8a-a609ed9feaa7-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--fgjj3jgtvchpraqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 03:10:48PM +0100, Sylwester Nawrocki wrote:

> Is the main difference between "normal" and DPCM card that in case of the
> former the data flow routes are static and the latter allows dynamic
> reconfiguration of sound data routes? AFAIU DPCM stands here for Dynamic
> PCM [1], rather than Differential Pulse Code Modulation.

DPCM is a Linux internal abstraction that doesn't represent what's going
on in a very generic fashion which makes it problematic when it appears
directly in DT bindings.  It's very SoC centric.

> It seems the graph based binding could cover above both cases.  Apologies
> if this has been explained before, but what are main reasons for introducing
> the graph based binding?

The simple card is creaking at the seams as it was only really designed
to represent very simple use cases but has been extended rather beyond
that.  It's also not set up to cope with things like CODEC<->CODEC links
that don't involve the CPU as it really only has the idea of point to
point links between a CPU DAI and a CODEC DAI.

> Is the SCU part in "ASoC simple SCU Sound Card" derived from "(S)ample Rate
> (C)onverter (U)nit" ?

Yes.

--fgjj3jgtvchpraqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliHg7YACgkQJNaLcl1U
h9Czcwf+NTTYpkuoNawM/4DuKJ3c+BXwVFTTe32U9MyjMxyhvcHklUB+J1wNSSzC
txr5em9Fm0+ZnLP5LJB5I/atpRMrzTMZU/et689e48LpgDZkG6xFafdcJiAVNVRq
bhC7/qYdMRLUHd//ztVWmbQKu+eo3U/7bfsN7IkuQsYzCHD8pIEOJzf614XEOQTg
UHe18tS9OZ8UZCVZgxPdbm5AbGtp41Z/ZBT/cLH4r8Cg0Mm77aeKAGjvgs9urj1P
Iamn5LeFjIZi1iWjd6RJzL3vsj0i98Ic8tvFk7JuGi7SCQWgcvTtzSPXTC7boRct
aCqZ6VBioSewv6O5YNtluui7Z1ybIg==
=F1yu
-----END PGP SIGNATURE-----

--fgjj3jgtvchpraqc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
