From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Mon, 6 Jan 2014 13:16:51 +0000
Message-ID: <20140106131650.GS31886@sirena.org.uk>
References: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5589367605303153873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13DBE2608D8
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:17:01 +0100 (CET)
In-Reply-To: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5589367605303153873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D7bibO5f9Mpud+NW"
Content-Disposition: inline


--D7bibO5f9Mpud+NW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 10:35:26AM +0400, Alexander Shiyan wrote:

> +config SND_SOC_IMX_DT
> +	tristate "SoC Audio support for i.MX DT boards"
> +	depends on OF
> +	select SND_SOC_FSL_SSI
> +	select SND_SOC_IMX_AUDMUX
> +	select SND_SOC_IMX_PCM_DMA
> +	help
> +	  Say Y if you want to add support for SoC audio on an i.MX boards
> +	  described in devicetree.
> +

Rather than adding a separate Kconfig option it seems better to just
move these to being selected by SND_IMX_SOC and delete all the extra
selects from the individual machine drivers - I don't think it's worth
worrying about building the extra driver for S/PDIF only systems and
it's easier for users to work out what they need to set.

--D7bibO5f9Mpud+NW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyqy/AAoJELSic+t+oim9NkUP/0h8GwVxp3CjJSwfZm9Rwvn/
Im6ZAVOSMQQ5pXvqwwhpA0Aedqyzb4RSQhg26vkbA3bBAHsMruO7QwpYYVEcNsgn
LkWvVo24LLutUXZjpe6f+z2arBLY47+3bx0dSzA5U4BG8Gktw4pRizNGperTkVGg
V95eD6wdkFcfBL8SToL5lQ6V+nELlvBebalHRn+i27l96z063vhqd8StXJ4fTiDd
nyYj921LRSNiNuXphem7fZuByJPdP7syTeWx54fDkxcOZAYbLrqkgR27OOyfzrwX
PvS56BhoNozka9ucji2T65duiCS3myX+7PacsTuGePDcEV7OcZ1kKcd35UA5apgY
7X8LODSrU7Y76xUWcy2/5kNZ4Ic6xILH8AlRxO9+3T1DcRde4bhz/IZbe23+PThe
dQ+oHBzWS5T/eEfusTWPztvGrw8VaRxwBMWWpH1XsQNbnKsCrQPCnGdnnYfDpxmf
nxHu2QtWqfOGU3m5LW6TCOfUa3svJlAv9eYjctHnNPD2mJMGgsCePDDm6qxV96Ls
4RJn/LoYZSiE5BG2SVi+yD/0eEESbj30p+BYiIskGNqXufrn2Lj3JUs/x6MCs0Fz
JHIhJN83uWS9bEnvzMWlhip9uVLruBvtX2bJRh6O8gl1CC08PwfPGdQ8tlHTv/Zs
ZO4FOT/OSUOkXHagmC8M
=0vdv
-----END PGP SIGNATURE-----

--D7bibO5f9Mpud+NW--

--===============5589367605303153873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5589367605303153873==--
