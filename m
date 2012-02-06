From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: DAPM - Export
 mixer|mux_update_power() to public API.
Date: Mon, 6 Feb 2012 16:18:00 +0000
Message-ID: <20120206161800.GL3070@opensource.wolfsonmicro.com>
References: <1328544314-10552-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3104260259563348276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E229B103B4D
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 17:18:02 +0100 (CET)
In-Reply-To: <1328544314-10552-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3104260259563348276==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Swj79WlilW4BQYVz"
Content-Disposition: inline


--Swj79WlilW4BQYVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 04:05:14PM +0000, Liam Girdwood wrote:

> Changes since V1:-
>  o Remove the unused "change" flag parameter from snd_soc_dapm_mux_update_power().

Applied, but I had to hand edit the changelog to remove this - it's
supposed to come after the --- so this happens automatically.

--Swj79WlilW4BQYVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL/0xAAoJEBus8iNuMP3dx5sP/iUK23Qm3e3jZ5HpkEzAsMEn
R/LbXc4/Qjq0OQlAV+J4QCTjCBTcLvpK0dVy5LZ0QoZO8lNXY3i9/olIZwb2IpRR
69O5EsMoV0vy85MIroMsVPvzGqnFfFActiKxjLCj5LPRAhSemjx8fNpvPqGBNWWQ
gPAMfzYmrLoweXRgylYUQT/9LmH+sY8kbzmHolYzaQKMAuNqhH8y+GczEE81awWk
owEuX0QeXwdNNvALpw7bMjZoI1oO5yLs464/d6vxbVRq96vRM5qOrvVA7QiuROF3
WMDPjREnGr+zPVXOf5tjBLPWNyIHnH+lvyXgPqy1T4rW4qrLJBfGGVrz+k1OuxX2
kklQGWzWAYI9Bs5gkYR+EibiokOpV07o3Bb4zbnLTOS4+IA19jZ3tfBkXd9OdogP
JIy4SlpLQSsbbsoernALHmAm8jJ5ho2AVUTK/KpflPwUdWxerLL4KK9H/iR0aDIv
7AiJh7yU2mewO3eF2rzXLOvhttEcp3iMTCkdLrk068l0JGiRLXtS+BF86nA4J0J8
Tm6A7e9VwSuqVlaUuWUNhNDvEWL+r/zO7yAHS3myOV692oxe7FTu6EPSzhqULlwV
tQEW9JY03sodd6HQigSPAnlDA8AzWHz6RZx6migirqbePjIQDgSH9P7rrXxdwGqa
ELSjhBcTw7/BlryVpJHE
=3H2H
-----END PGP SIGNATURE-----

--Swj79WlilW4BQYVz--

--===============3104260259563348276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3104260259563348276==--
