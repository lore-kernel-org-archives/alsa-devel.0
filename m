From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Fix error path
Date: Thu, 18 Jul 2013 21:51:39 +0100
Message-ID: <20130718205139.GV22506@sirena.org.uk>
References: <1374170868-22845-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0785463544725134250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2953C2655EE
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 22:51:43 +0200 (CEST)
In-Reply-To: <1374170868-22845-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0785463544725134250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xzyfs59K7sVdWrbC"
Content-Disposition: inline


--xzyfs59K7sVdWrbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 03:07:48PM -0300, Fabio Estevam wrote:
> If the 'failed to find codec platform device' error path is executed, it =
should
> jump to 'fail' label instead of returning an error immediately.
>=20
> 'fail' label will then free the ssi_np and codec_np previously acquired n=
odes.

Applied, thanks.

--xzyfs59K7sVdWrbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6FVYAAoJELSic+t+oim9KkgQAJ0guLrhuvSEaCyCV/xCBUN3
k8NJkAXcj9tumv8baTBpaCKAVWO62NKX77Dx9Soko1AqvfzlbyzrR6O+EV0waZuE
zAB8AfeaccgV9yAcf6soW3rvyYPK4V6Du6380zsHQp9M5hcdO078fwm7D2L8iDym
oUFmZroBila5F07nphFFy8MZJzVmLu3vtp/J67O5wPW8Z0++12woPKQ+iLbFE1C2
eQqBfXBUHkE21HiepkNACbbB/kCefZYyeJ4WJVbXN5g8jIFf8KSt++op/HAqEhkk
0+tVFVx4ooBxtoEEc05EdnjsUU/uWH9aA77n9NF7OMNpe2cpndOT14hrfYOJftgO
YrXQWGPRc74KzrhpFfi0BmXVyp0t8EPhahQssbavds8YcQR8Gv67jiUy4zVERRE0
lxK1LFKOUB9JK+hqVu9RuJk7ObThhnVIrpdAaph0SuYJe3icxEqj6j+LreW6R4o1
+tFhFiqHZw/iZ1S6sHYxD+jhEdCpQIIElsqp+OiS8NXEpjXIDUNTikfSTSm5Zy7K
bBoDIyeqXchOZvb2tJ+OuAS/OmRllrVnK8uV2BLb1zZE+dBhIqBR4uRCdcCycMHp
ncrw0Bwqu9yQXS9a5DsFsm4ampEuoMcdj32l+7/ONvOYrYOfG0iJx8g9xQF4DY2R
99fP3jceSCxXyWb6QvyT
=OYDr
-----END PGP SIGNATURE-----

--xzyfs59K7sVdWrbC--

--===============0785463544725134250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0785463544725134250==--
