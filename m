From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai
	driver name
Date: Thu, 24 Aug 2017 11:18:26 +0100
Message-ID: <20170824101826.htrevrhhgez2pgoe@sirena.org.uk>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com>
 <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk>
 <599CC17F.90806@rock-chips.com>
 <20170823110628.xergjdexrmxyqrza@sirena.org.uk>
 <599E4826.1060607@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1228767031074779133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B46762669F3
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 12:18:34 +0200 (CEST)
In-Reply-To: <599E4826.1060607@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, dolinux.peng@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1228767031074779133==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7ujv7jw52cjgojj"
Content-Disposition: inline


--i7ujv7jw52cjgojj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 24, 2017 at 11:29:42AM +0800, jeffy wrote:

> and i was trying to do something like:
> if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
>     && (!dai->driver->name || strcmp(dai->driver->name, dlc->dai_name)))
>    continue;

> which is add an accept case for: dai driver name is valid and matches the
> dai name we are looking for...

Writing it as one if statement would at least be clearer.  I can't
remember the patch you proposed at this point but the above looks
plausible.

--i7ujv7jw52cjgojj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmep/EACgkQJNaLcl1U
h9DOqAgAgHK6aqo4bc+E8dHCbgBPsySuK58Fci7g8O8zTwY4+hk9uCdWq74iM3kT
xHRWOJ6tEsAgY1H1O69KLrDuiPI3CF8zqfgQWPRb/RlzImegQnjS8zdZs+3Z1wo4
aKOUVMa7+hy5n31cqzGJr5+u/zj5XSQYsi7jo8TUHMq+d6/BhtIuahAEemQzwr5F
VK95vDrD+65ifFeBI7RMtOd05JlvwmtG1bo7RgG3hNcg1xAxiRr5N9kSdfuTsl/U
RT7xmasetM2yTvCRPq3AsHPFFszCHkXZHJmZsoeeX4KO0TFvduR2bqx770M16u8b
imvi0hfDXtAggvwZmUgfA1yU1b12iw==
=uOp7
-----END PGP SIGNATURE-----

--i7ujv7jw52cjgojj--

--===============1228767031074779133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1228767031074779133==--
