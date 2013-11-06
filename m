From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: wm8350: Replace BUG() with WARN()
Date: Wed, 6 Nov 2013 10:45:46 +0000
Message-ID: <20131106104546.GD11602@sirena.org.uk>
References: <1383732439-31441-1-git-send-email-tiwai@suse.de>
 <1383732439-31441-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0036929341492506833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 05649261675
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 12:08:03 +0100 (CET)
In-Reply-To: <1383732439-31441-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0036929341492506833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+b2GFy/wpzNn/yIF"
Content-Disposition: inline


--+b2GFy/wpzNn/yIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 11:07:12AM +0100, Takashi Iwai wrote:
> BUG() used in the driver is just to spit the stack trace on buggy
> points, not really needed to stop the whole operation.  For that
> purpose, it'd be more convenient to use WARN() instead with more
> error information.

Applied all, thanks.

--+b2GFy/wpzNn/yIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeh3WAAoJELSic+t+oim9+rwP/RuYyHldTJadZTgIlhl7yyol
RqlshPv8Uxp0WqHtFL+l5fMXzQ8XXMzu/ffTQ8rxcA/pUNniHl4ns/doFncgUDdK
9k7/L6epcIx2ExVxfCcb6O+6+vvl2s30HR6tan/hbn9cuL0f12CsLc4Q6e8N4Iqq
n7LQGihMhGBnqXMzJ5ODWYwwwQyCtsvXrDFvHjUl9U4gGiQEME9CeTB1yOoEBX9m
hLREh/e7vELPpf4zx8ijxlWECqyINkvLU3oY0yBFNzGL8B+Zbjs6Dh7bXiifKt6G
AxbX/ljisbfo7SaKJiL1jkvH276m3lfkLdVxCcea5htuVHZooPHkePQePjMWm7Wa
qz4aP6WQdUhhJayMYoNbUUMOu+Cjs+YBupUyhprIhYpTkPYR1rXLT+HKQ5GmaAQI
3OkpoCBhDjiupsxln6ftrAKJAdBQFG5ioztN9zbwdCRQnX/gbS57wGoqXJ9MzZCe
kQUiSWsI/4JYZ8zk2WU4bgKTKa1On5YA9X58cwVCoy5MOqBGz948TVzBU8NWEz4o
9tHiVQNJlZiRvDpdOwCTRFSPoMr/NX4Z1c9tjOm32JTPQHa/2+kutz60zGBvOKWH
AfRwLGQ6YCoeh68/z7m3hO82JRgN3EZHMMPR/jbwPirKuRYVuHcMYhLXq/VowGia
slmA5+kk5U0JzUYJqnUP
=SNGB
-----END PGP SIGNATURE-----

--+b2GFy/wpzNn/yIF--

--===============0036929341492506833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0036929341492506833==--
