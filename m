From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 resend] ASoC: omap-abe-twl6040: Add
	device tree support
Date: Tue, 5 Jun 2012 14:35:28 +0100
Message-ID: <20120605133527.GX23408@opensource.wolfsonmicro.com>
References: <1338902291-8244-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0670691876793036582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6245810432F
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 15:35:30 +0200 (CEST)
In-Reply-To: <1338902291-8244-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0670691876793036582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqu5fpgjE+BQlEdo"
Content-Disposition: inline


--nqu5fpgjE+BQlEdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 04:18:11PM +0300, Peter Ujfalusi wrote:

> +
> +		ret = snd_soc_of_parse_audio_routing(card,
> +						"ti,audio-routing");
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Error while parsing DAPM routing\n");
> +			return -EINVAL;

Should pass back the error code you got.  Otherwise this looks good -
with that fixed up

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--nqu5fpgjE+BQlEdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzgsWAAoJEBus8iNuMP3dLqkP/RYn8T/fSzEcEh4fac+3OmDq
mJVMCyAYXWOogE4dLI8eJrlEQwH+iUl5dCqUenhO9I1yZXYUhvNddLy0PQAJSM6U
mFY+s1HVpgilafnZ0BgbjGZsIPVJeAzCPftBqEpKWNzMp4j/7m6F1LJCuLHPvD3e
koOSHnTatSA6g9gOg/l5p3uwg5Bk3iuI15Sef6LLzqkH6WGEjVRF6Di3yCDGoXWV
g//UZ00UdcUP3T5oWvABYsYRMk65IOquOFkTIq6Ua4WmUy/WzxHFl9VlelpePJVu
R9yAYy47cO/NCOI0DcP/uoXlzgy33TCNliuw8q1QnhKAYNsCHt/sA81x18FDfQAF
A7TItFNj86pcnKKW+kQXv09Mo+nTORuVk3sxSlCoe/Kb0D/+J02SAHZp6cUQxZJR
IvDpJaoJ8pNXTP6k8RdvVzZtf+wz/oowD+x9viY7rGgCLP8L2F0e9RLqcEOjaf1n
bDtuj6cepYq36uOyaX78lFjxsOKgQhRYgd7tCXALxsW4Klj+/OcS6AeSHMYXWrUo
LbUqpsyfvq23DKrOh17GsmBm4G3dm5edtg+ETq8l06q0YwYlmJJHq88VlZA80HXh
zo2kmTL2vqhm+UElPIQUdtzhAyW1RNl9SuBt302+bhZuU5QGbaNHbhcBisb1+cNW
xdDHnOVa0VtPm4jRvPzY
=QGWN
-----END PGP SIGNATURE-----

--nqu5fpgjE+BQlEdo--

--===============0670691876793036582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0670691876793036582==--
