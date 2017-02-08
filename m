From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoc: hdmi-codec: remove HDMI device
	unregister
Date: Wed, 8 Feb 2017 18:33:05 +0000
Message-ID: <20170208183304.jq2t37iozd4boc5e@sirena.org.uk>
References: <1486547221-32593-1-git-send-email-vincent.abriou@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5193023935592932143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9119B266AB2
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 19:33:17 +0100 (CET)
In-Reply-To: <1486547221-32593-1-git-send-email-vincent.abriou@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vincent Abriou <vincent.abriou@st.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============5193023935592932143==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iqxpgpvbysbvnqlj"
Content-Disposition: inline


--iqxpgpvbysbvnqlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2017 at 10:47:01AM +0100, Vincent Abriou wrote:
> While unregistering the hdmi-codec, the hdmi device list must be
> cleaned up. It avoid kernel page fault when registering again the
> hdmi-codec.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--iqxpgpvbysbvnqlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlibZGAACgkQJNaLcl1U
h9DAcgf+LXZC0tVw9us7uWcq0DRbJ7GY6Te9ODEODt+a4VmdrLNUhaI12CH3/PBB
NOeidB3ycUCiPnG7aGtWyMM8PqJpY4WYxPnVwN7u41lerFjKv87l5Be5S6UcPTYh
zrHbJGvEwymG+B30KqVoovrUoc8sFj3Fztm5aOj/0A8+gmJ+PXa4AbxaH5pRxJyv
20otBj8hZsP/92ef6OINa4bmN+CljOyO+2ZQTsn4q1dwRuxzg4Mlx65wY9rGLy5T
za2nBZgAWNiACVZBdEAnqF0nmIBwos6IvClvhvbtQ23xJfI7egxHiIPdcmoeGqG+
+lvdqDgulVTL4g3f15z6M0IuiAMang==
=Mb1w
-----END PGP SIGNATURE-----

--iqxpgpvbysbvnqlj--

--===============5193023935592932143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5193023935592932143==--
