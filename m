From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rockchip: Fix an error handling in
 'rockchip_i2s_probe'" to the asoc tree
Date: Fri, 16 Jun 2017 10:18:56 +0100
Message-ID: <20170616091856.jz5d4trm5jz2ugan@sirena.org.uk>
References: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
 <E1dLYRz-0001l4-SZ@debutante>
 <e92fef8d-5ce1-0b7d-d130-0246d2cb7f91@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x65wduh7amfg3u5o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e92fef8d-5ce1-0b7d-d130-0246d2cb7f91@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--x65wduh7amfg3u5o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 06:57:30AM +0200, Christophe JAILLET wrote:
> Le 15/06/2017 =E0 19:20, Mark Brown a =E9crit :

> >   	if (!of_property_read_u32(node, "rockchip,playback-channels", &val))=
 {
> >   		if (val >=3D 2 && val <=3D 8)
> >   			soc_dai->playback.channels_max =3D val;

> ... and 'err' should be 'ret'...

> I'm really confused for such a ugly proposal !

In a situation like this it's generally best to send a patch, I'll fix
though.

--x65wduh7amfg3u5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllDonsACgkQJNaLcl1U
h9BKXAf9HLRJwNPvMTRln/0h4G5l6rxHDsSvEjI07dJwsmDHOI623PUUg27XdVNa
EmTT4pVe0aP2hcmIZOr6+RniDUGyR5Yi0J37FvchkLl2LmlpcuHXvDMIToBjvAvE
M6k9kXGLrhDqg72+esyG+EpEu17ZzekACrI7eBEA98O04YXIooz8HsO+4YfMQdhn
yrzJ8A7paNyvtQtQrs7BFizRR7SUCOax4UjFjMlJjRKLe50KTEetjIULYRDP9X4X
IrkUCV4Kcg40YY6CghPpv8Cs/X/Mu/etCqmEqnMp1QwVPfT8BrNpBr1Sakeewbag
YwA4oKr0TDQy5Yrhv2lblhAacqIo5Q==
=2+34
-----END PGP SIGNATURE-----

--x65wduh7amfg3u5o--
