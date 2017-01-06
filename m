From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] Revert "ASoC: core: replace aux_comp_list
 to component_dev_list"
Date: Fri, 6 Jan 2017 18:18:23 +0000
Message-ID: <20170106181823.qztj4b3rhxrgljq2@sirena.org.uk>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
 <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gop7jv7xwfk452dh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--gop7jv7xwfk452dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 29, 2016 at 05:18:21PM +0100, Sylwester Nawrocki wrote:

> I run into same issue and posted a patch:

> "ASoC: Fix binding and probing of auxiliary components".

Which I applied so I guess things are fine now without the revert?  I'm
still working through backlog from the holidays so didn't check
properly yet.

--gop7jv7xwfk452dh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhv328ACgkQJNaLcl1U
h9A7+Af+L7JxW2cvAzNAhpd0Efy0AVIET8DYbewvAU9O2y9d6nwl8HGZQCdMz+pv
oXwQAp3vzdoEH/aFd+cVkOVreNhY2OmBnH+pCMkKjqyueErmTb5ByhQoClgBQgvU
/E0UQI61jmFmitEaRJ3oaYoxwTi3Vf8C/2vYkwlqjUvagYkTRY3FFBDRXs2Vs2kj
A0cNa2ymTCV+Ks5Hmz1XzT0LY3pwVEMbEP97JykiyJC6hQ8Pk/776zVTgIUY83C3
TkDimMpA8TP8GOPCKYxv7y8zi3858YYRbBOM+CaEn262Kc5JOzjBL3siu+hLgHiX
u9VpvjKQaFS99+aVCAOjlS+kQhJalQ==
=w+iv
-----END PGP SIGNATURE-----

--gop7jv7xwfk452dh--
