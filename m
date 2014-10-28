From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: kirkwood: get rid of
	armada-370-db driver
Date: Tue, 28 Oct 2014 22:35:21 +0000
Message-ID: <20141028223521.GL18557@sirena.org.uk>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5633823591944793077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A1B26051C
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:35:42 +0100 (CET)
In-Reply-To: <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5633823591944793077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hiFLGGPPrqiESHj5"
Content-Disposition: inline


--hiFLGGPPrqiESHj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 05:08:41PM +0100, Thomas Petazzoni wrote:
> Now that the Armada 370 DB audio complex is fully described in the
> Device Tree using the simple-card DT binding, the armada-370-db audio
> machine driver can be removed.

This is just removing support for the old binding which is
incompatible...

--hiFLGGPPrqiESHj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUBooAAoJECTWi3JdVIfQ9KIH/1Z2yM/W3GoFn7LuVupLbr67
i1/J/mlBOwMOEtRlYJsi8I62lyMkEhA3SUGqXRcO+iFKEAlbENFyeRwG2/aZDjy0
TKfDN+GnLs+jq/44Jtd/hFz58lqzGK3hsdrVTXgVy1xUZIF85MO9h3uaYNfoIYND
9sqGzuhgK0bqiKIEe4OQ1xidVxbbkjw1DVg99VEkWoP+OaBDPJDW1nTDHsnVnAL+
dInZJ6hgzEiXSTxw0wAqTkOtsmYzo0zoVkGlg98IBXrvN3hP6uwwqko9DxUKIw8m
/YuZDroNPBYDgDE0TKKIkTutRRkrhqDmSrIZLlZt+X9WvcT4i1W46DdDKUPnDQo=
=TP4F
-----END PGP SIGNATURE-----

--hiFLGGPPrqiESHj5--

--===============5633823591944793077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5633823591944793077==--
