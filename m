From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: img-parallel-out: Add
 pm_runtime_get/put to set_fmt callback
Date: Wed, 4 Oct 2017 11:39:20 +0100
Message-ID: <20171004103920.62t77jqscqdb7a4r@sirena.co.uk>
References: <1506938433-681-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6007208910668081124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CD56B266B20
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 12:39:21 +0200 (CEST)
In-Reply-To: <1506938433-681-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6007208910668081124==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5imfslwweakwrc76"
Content-Disposition: inline


--5imfslwweakwrc76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2017 at 11:00:33AM +0100, Ed Blake wrote:

> +	pm_runtime_get_sync(prl->dev);

I'll apply this since the driver already has runtime PM and it makes
things better but please in a followup patch add error handling.

--5imfslwweakwrc76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnUulcACgkQJNaLcl1U
h9CO3gf+MebhyLe0N75ockLeFMml7Y+2CmcIZKzLhlU6L5ePnZkVeQx0u7X5J9Sf
PfDMT/90289NE+ciJuJZ/qMLYGCmcUuVFTKzk+dKTnjkUG4pdfqqwMewAltJ6bvN
h1njhkT7AHFzw6I7PEwVf2uyUumWQ4Wt9yuKoVVxSQAbdTvjfClhepK842b2paa5
cGeCcgHzKpSnushws1ek16OfSKZ0ijlno/F1AgaliBxcehq9V6ts68Kjz/ikvCq6
qEKHS1WPVYVJqIfW99LMdbQ8rWzbawh050daGd8vBYLXyW9czm9a2b9InAZ0isRN
QHgJtsnBHmBA3dJLIbp9Pn1PUZqCPg==
=qVJC
-----END PGP SIGNATURE-----

--5imfslwweakwrc76--

--===============6007208910668081124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6007208910668081124==--
