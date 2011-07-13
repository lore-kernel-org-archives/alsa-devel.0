From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 13:57:11 +0200
Message-ID: <20110713115711.GG1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0010201741410906960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 70D5E243E2
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 13:57:13 +0200 (CEST)
In-Reply-To: <1310483085-31442-4-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0010201741410906960==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2011 at 11:04:38PM +0800, Dong Aisheng wrote:
> The driver only supports playback firstly.
> For recording, as we have to use two saif instances to implement full
> duplex (playback & recording) due to hardware limitation, we need to
> figure out a good design to fit in ASoC.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Which version of the codec do you have? I have:

[    0.370000] sgtl5000 0-000a: sgtl5000 revision 17
[    0.370000] sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-000a=
: -22
[    0.380000] asoc: failed to instantiate card mxs_sgtl5000: -22

The failure is because CONFIG_REGULATOR is not set and it thus fails in the
codec-driver:

#else /* CONFIG_REGULATOR */
static int ldo_regulator_register(struct snd_soc_codec *codec,
				struct regulator_init_data *init_data,
				int voltage)
{
	return -EINVAL;
}

(I can patch it to load properly, but well...)

Proper regulator support for mxs is not in mainline yet. Is that
planned? How do you do it?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4diBcACgkQD27XaX1/VRtELQCffaC7AlwOabmm0LBbVjbWuM9/
GtkAn0t3GaQm1uncuV426iK99jvrOjXc
=DWAS
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

--===============0010201741410906960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0010201741410906960==--
