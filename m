From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MICBIAS routing information for
	WM8904
Date: Fri, 16 Mar 2012 19:04:53 +0000
Message-ID: <20120316190450.GE3158@opensource.wolfsonmicro.com>
References: <1331888098-28717-1-git-send-email-hong.xu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6905613046981446891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2AA624336
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:04:56 +0100 (CET)
In-Reply-To: <1331888098-28717-1-git-send-email-hong.xu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hong Xu <hong.xu@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6905613046981446891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 04:54:58PM +0800, Hong Xu wrote:

>  static const struct snd_soc_dapm_route adc_intercon[] = {
> +	{ "MICBIAS", NULL, "IN1L" },
> +	{ "MICBIAS", NULL, "IN1R" },
> +
> +	{ "Left Capture Mux", NULL, "MICBIAS" },
> +	{ "Right Capture Mux", NULL, "MICBIAS" },
> +	{ "Left Capture Inverting Mux", NULL, "MICBIAS" },
> +	{ "Right Capture Inverting Mux", NULL, "MICBIAS" },
> +

No, this is not something that the CODEC driver should do - the machine
driver should add connections for MICBIAS as this is something that's
determined by the board design.  The board could for example use some or
all of the inputs as simple line inputs (no bias needed), or it could
use an external MICBIAS for some reason.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY47EAAoJEBus8iNuMP3dsG0P/2weRqyB7nsXKsxK1EnO5TwG
UU7Kkr1QKdPmFdHQTwhIqbh3z0R6nnVJKQxZFMc4XefhVz3NMfDr81uJEf9hP1l9
NNL4IaQygQOKo2Y5lK3AlMz0Q1L6P8VarR0zNXPSvdjfRVPl4TMILMPp53vdY1O6
bf+NF01rdRNPa9ms+V6bgt/J3jdvpIGOEqNWqEKoDpaE73DwDtoT8vO4bPJJpBL3
I6VDGVI2riMbQd14cYVaqIQ0+JyA0LAOANxPyL1unQ+q5INb4MLIyKbkeaFTdBSB
AJh5nLCcYptPImjXIIR5Acbe01YEKZbM+F7fAj+sLgTeKncHYDtYBbs3+tl8mGvl
A1NCIAD4dPOR8XK5xvwWViZnauI4bZlUd1VQjNWCkl9G2PIjeCf9MCwYEgzKRAHC
QEf6bDY5Ul88LxmGKQ4meHtdbJ9ymBO7/JlpRLkXkWnECt6KbC2vrsr962rMZYoV
g9iijU3UrubDdHFF2OfJSCWgY3kR4sY32xtVL0es/YXrv5nJT9yCaWKudGEkhgOS
Nbw8fG5LKnpO5llNeF5OeNKrnFq3PLxlx8c7veancb2BzlxDpUno15iwzQVwsN4s
VXChyWN0CrXLFGuxweWiDX8dP+Gu2rTupozTUnslX74F/Or6PbENWb7C3c8SuYok
tgPYSn3qumTyY1bmjfVs
=wdzz
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

--===============6905613046981446891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6905613046981446891==--
