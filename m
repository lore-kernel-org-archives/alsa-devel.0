From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: rt5631: Fix return value
Date: Mon, 19 Nov 2012 15:22:37 +0900
Message-ID: <20121119062216.GA4406@opensource.wolfsonmicro.com>
References: <1353304094-9115-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9092596487292581938=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F4042650E0
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 07:22:52 +0100 (CET)
In-Reply-To: <1353304094-9115-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============9092596487292581938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 11:18:14AM +0530, Sachin Kamat wrote:
> Return the value obtained from get_coeff() instead of EINVAL.
> Silences a smatch warning.

Applied, thanks.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqdAPAAoJELSic+t+oim9teEQAIMnfCWg2iXVNQS0hXaIbYOe
jEx4eI8pQw6pkMNREdpLGcU+xU4xk0SwMKTSx0JgLFFhRJjXWPNvf+hGyTAgeybR
bf/3Db2KobPV6WaEkuUDiauRcb6IVUcbDdSWnn4dJDG11hILUD8Xh0mzsmz3lrrm
BJHNXS/7TbNvMUWB1ZZ+k7hsBlBe+5p0zqC4TZyzRdhyNViNyUmlwdh5cJUR3mig
oyvMHoJVM4o/YBAb7zOehWHdAL5JteUn8HjK9RRy8QrOe0QMTFWw/3xqEmIt8b1w
azKktRMUgGVxgO7GlrrILTlLLQsn7cizjTmQrqgun4Jw6lxRMc0M0x7mLc0Xwb4i
rrt9aamGupun8tKuYFfgvkoVY4nDvofEQUAfuC5amt5F4hJDKXY0oOLEamlK8J6C
YHjkCH4Ecto86d+gUtYc3SHpwvqQhMTgHrcZmrYVwO+8vwafHDlJorndm32+6kx0
R17SPOJnaIT6TDXgRagSxKwcwczIyDJEzK6chfzIBn2of45p0mPk9u3g9ljtVC8l
M2V6tPCsb9kvHJJe9CNaC+3sYK043Js9QHRHoTdQnx7FkmjX3/7VcMzEmC14Beks
FeTzYuBTFRCPbyjsTdm8EXALRqLQz0PtgxgiznepKxDS2q0Msy/nzqloUJVB7XVd
bLjbIaZWKrA+MwJwKvxH
=0Y94
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============9092596487292581938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9092596487292581938==--
