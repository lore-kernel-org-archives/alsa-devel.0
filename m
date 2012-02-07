From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19] ASoC: fsi: fixup fsi_pointer()
	calculation method
Date: Tue, 7 Feb 2012 11:29:59 +0000
Message-ID: <20120207112959.GF3332@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
	<20120203115522.GG3151@opensource.wolfsonmicro.com>
	<87k440x0ft.wl%kuninori.morimoto.gx@renesas.com>
	<20120206164644.GU3070@opensource.wolfsonmicro.com>
	<87k43zv6uc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5255913843400307551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19B4924430
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 12:30:01 +0100 (CET)
In-Reply-To: <87k43zv6uc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============5255913843400307551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 04:13:20PM -0800, Kuninori Morimoto wrote:

> > I'm sorry but I'm having a hard time understanding what this means in
> > the context of your patch.  What is a "sleeping bug"?

> Sorry for my Engilish.
> It mean "(Maybe) old fsi_pointer() has bug, but this bug doesn't run a mischief"

Ah, I see - so it probably was an existing bug but nobody reported it?
I suspect it's worth fixing in 3.3 then, there's often issues where
userspace applications don't work that don't get reported well or at
all, often these are due to issues in the pointer implementations.
People end up coming up with configurations that work around them and
never think that there might be a driver issue.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMQstAAoJEBus8iNuMP3dqucP/1ELiGCYFjUcw+H2duio+S4A
tdvtlu835cQu29MOMHhkTaVhF2cRxoRb7OIzDgRwcc+4UoNMVJIbRiuL4DH0kExD
uRjB9vtCJOEdKGdTrNRg5nP18Mh5WPyx2ebTwOETh5sgn8pIXE1pR558fJYOqhh+
d3rLcUVPW10bit3wm2dA3gtgoGUPUqRzJkAgTQwjTqS3rQhhNNKDv26DuAxfwlse
Nbs7bA19whMU79Lq2EKe2CDirdyQ7bPBwHYrCQfNy3xul+yURlbSTvj1r8yszdqA
/dK5IhR0h9hHROt9cu9eSSDvX2zKD7vcnEpL0sg27Fuu0D1XhTz1hQQhxOYMHk9a
nj/s+oPYdt/4ez5hBglfVv57QymLJX5nz+NSQIsmdZVGOCvBGQ++Gf4qamEeJlIc
u274G6TUq4ruhk3au2Tp4cRie4OgbRc3Z12pS5lcctbgqaYZBYjqvPzGGaJ6VZ2K
1GAX8uE6nxjI3zlUyCxxgKhorviimfV+BjDjA0oOpYQBQa/UKskAGdRIXnDc8gR7
P3YjQChol+iB810DLdf104mT7ooz5adDtvHmFDfyJF/L5o81nK+PtRKbDowWuvLL
r9a/10Uah4CSLG/aWHJaobDbJ1ZbLq2AxCK1MR7hXJQrzXiak8nCA7BxCMJOGnya
HLGzxIu8VKQrlNHIIwIG
=H/XD
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

--===============5255913843400307551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5255913843400307551==--
