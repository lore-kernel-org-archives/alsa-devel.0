From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm2200: Provide platform data for
 MICBIAS configuration
Date: Mon, 4 Feb 2013 18:25:01 +0000
Message-ID: <20130204182501.GP4720@opensource.wolfsonmicro.com>
References: <1360001403-2183-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7817268432960477160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15C7F261635
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 19:25:03 +0100 (CET)
In-Reply-To: <1360001403-2183-1-git-send-email-crattray@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7817268432960477160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Content-Disposition: inline


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2013 at 06:10:03PM +0000, Chris Rattray wrote:

> +enum wm2200_mbias_lvl {
> +	WM2200_MBIAS_LVL_1V5 = 0,
> +	WM2200_MBIAS_LVL_1V8 = 1,
> +	WM2200_MBIAS_LVL_1V9 = 2,
> +	WM2200_MBIAS_LVL_2V0 = 3,
> +	WM2200_MBIAS_LVL_2V2 = 4,
> +	WM2200_MBIAS_LVL_2V4 = 5,
> +	WM2200_MBIAS_LVL_2V5 = 6,
> +	WM2200_MBIAS_LVL_2V6 = 7,
> +};

It would be better to specify this in terms of milivolts; this means
that if the user does not specify anything then we'll use the chip
default which should be sane and is generally the expected behaviour.

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRD/zaAAoJELSic+t+oim9AwUP/jgv+EOizLJ2R7q48wuyKA8W
rU0PeQpwD7pbRga5EQnOlYCItsYQa2N5bi0qdUa6SyYMta4kQmiGiGkUEWSvuG9q
3+X7exa7IXUTnS3cgnSQpPamtqSBjvm/hWNxrTGJJoWDfXNrW/Om34N8KwPbtOdx
scnwzFwVEdINyMd38IrhDrfWCog/rYtg3Jc7KyZFaB7vSzjFEMnlKrbPBZP9hPSd
ctqKeKhuA6IU8t+Okmq/FBc25SbWL08z+AOZQtQU67xWcdMVdGzaoQOSc7lF5sJt
6AbjDGpdXWh4zLe4ppZAH5hZ1n9uzRYPiYHOLHHYPrjy8P0TichmjE07xB+iQYTW
dYmObE42tndTRzEetABwdtLNsbjCQ9h+BFnG4vjWfaDlaB7E+UHHcskKCujWe8nd
NRxAz/YwPS65vsGYMU/2Q8zBd7oJlXrq7A7G+NN0tqgYsBfnqbLPYN9dscCCo6Cp
EowakVJIl0M4D1EbcrgHeEqvjdT5FXEUjjRxtdDMwEGzLf4Z373yGhHJT1GqUPgk
rRDIYhhbPXUprRBHIUSXrIjlmc8dp+2MqjcvNsa3JjV4K1VuA+1vlbUlSZTMizSY
aqGI8cOMvNVkiwlFKJqTu6ri7oJhgUTiaucw/PP8Pp/ZVgJJ2UyXWqbh437W12UR
yhrA++QycJrAIn3Q5sIg
=Hqb8
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--

--===============7817268432960477160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7817268432960477160==--
