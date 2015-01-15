From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] unload Audio drivers while playback stream is
 active case kernel crash
Date: Thu, 15 Jan 2015 10:52:36 +0000
Message-ID: <20150115105236.GP3043@sirena.org.uk>
References: <20150113215412.GS4160@sirena.org.uk>
 <s5hr3ux24em.wl-tiwai@suse.de>
 <54B625A8.8090406@metafoo.de>
 <s5hoaq121gh.wl-tiwai@suse.de>
 <54B63E4F.2010506@metafoo.de>
 <s5hwq4phbzr.wl-tiwai@suse.de>
 <20150114120228.GT4160@sirena.org.uk>
 <54B6679F.1030706@metafoo.de>
 <CAOMZO5AQEyb9in0hRn+7zcpE5r8zwVUFjCqAqNOmLMCGYka3Pg@mail.gmail.com>
 <54B744D1.3040809@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B744D1.3040809@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>
Cc: Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2015 at 01:40:49PM +0900, jiwang wrote:

> Can we have a more generic fix to this issue?
> Or shall we set owner field for all machine drivers?

Ideally we should do both.

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt5v0AAoJECTWi3JdVIfQpMkH/jTi8BFqSKGZcylvRb19hQnz
pEUPAQkbNQPL7EeJ9JE9KaZ1ffDzWf31Cbbr6A8F/HfhFcQxh0N74z2PIM0V9qlQ
yAyAgRrpe8uS3GjgjOqQs9qbzhxm+FnxVJofaBuky/dyY6CSLfjGgT7WZhamIg6O
Yw73UP22TrpnGG5h/JPRFZu6vXsZX4gWJzQrD3f/lW3+sW9dxQqQtzA0PL0y3ghx
ZT3/69RRsM1FLmY/AfHHXfwrK8NzYeeJNDOiiO/1eVx5Tyw9EZvQOfAf5iRSJVyr
SFVqDFZqxhKz4mn2WUqCcsj/6gr6IPoL+2zZDQjSO0jNWrbdQIA81odvwTZCkZk=
=bWFR
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
