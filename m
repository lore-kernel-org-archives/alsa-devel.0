From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai
	driver name
Date: Tue, 22 Aug 2017 17:17:56 +0100
Message-ID: <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7907559699741015710=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FA63266F0E
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 18:18:02 +0200 (CEST)
In-Reply-To: <20170822144512.12976-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, dolinux.peng@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7907559699741015710==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tzdmh6vkukewjzca"
Content-Disposition: inline


--tzdmh6vkukewjzca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 10:45:12PM +0800, Jeffy Chen wrote:

> -			return dai;
> +			if (!dlc->dai_name)
> +				return dai;
> +			if (!strcmp(dai->name, dlc->dai_name))
> +				return dai;

You want (dlc->dai_name && !strcmp(dai->name, dlc->dai_name)) for this
to be equivalent don't you?

> +			if (dai->driver->name &&
> +			    !strcmp(dai->driver->name, dlc->dai_name))


--tzdmh6vkukewjzca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcWTMACgkQJNaLcl1U
h9BEUAf9E7LyhL9s6XeoAYCt/PQXwxD1CAjo5QWQJVkyHqM1xiEMXkxgTBjjMkhM
JiJVjkG1vWvrkCQL7qu/CN5PtEIl9S6o264q3exAZ3+4jVSKUDU4ag+ePmlBju9x
aFHXfVNnxZeBZHGQ5yU9VJh33olWobjZG+jE7+vbXDmmArEMHgoj1VAO7sYvQfhH
H/Egy5nHndpsbIDiUBlInVeUcP+3M2upb8/2bPbNtCKLE/daOcET/n2NtzJuXUi4
vnagY2LmOyjfuaYKM6TpI1IkiGmRDE/yhnVOkouCwn2IAJMRZ/0+pUSBotSifsD8
6Rr1LbkFxbVldtLasOOMgwvWmFE59Q==
=AEDp
-----END PGP SIGNATURE-----

--tzdmh6vkukewjzca--

--===============7907559699741015710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7907559699741015710==--
