From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: fix oops in snd_pcm_info() caused by
	ASoC DPCM
Date: Thu, 31 Oct 2013 08:36:17 -0700
Message-ID: <20131031153617.GD2493@sirena.org.uk>
References: <20131031150137.GA16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7934372177490438800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD492619F9
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 16:36:44 +0100 (CET)
In-Reply-To: <20131031150137.GA16735@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7934372177490438800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Content-Disposition: inline


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 03:01:37PM +0000, Russell King - ARM Linux wrote:
> Liam, Mark,
>=20
> As discussed privately, here's the fix for the ASoC oops I've been seeing
> with DPCM in ALSA.  This avoids unnecessarily exposing the ASoC internal
> PCM devices to userspace, which is complimentary to your patch fixing the
> deref of the PCM ops.

Acked-by: Mark Brown <broonie@linaro.org>

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScnjuAAoJELSic+t+oim9ycMP/0G6Mne1gwxCoFj7u/JRMqyy
woYiUzHbz48Pduxw+xhXNb8JdJa702lSc+6IK6GuatPwjyrkHF1Pq8FISvWcSZJf
/borUEC0kO9jBtFgFFQO7WH0RwO8Ef7ujOwa6T5bpoScCn0MgKz9msBipnW2/VbU
5Cjd8/uLUzpFLvUrY/TaM1scE35Gh2csDX+Lzd39iRpeIGg543c0P0JUm4ToiAZo
KNb57egAwwiqX+Bd0n8xr56NmYrEWIR2npGF0DW0HF+Duu3pqSUyAFFH4QvBVDDm
PXeOWH4CHNJplObLWuWr3zkRCsYtt5Ji/obw8mRos8v6spsDtsOdsOuBRWCq1/dr
nfxKVuWvJVgYrCenb4A7MfILS9hb2EYT9bV7d/TSJu5GfpFwyFdvR/fCY4HrhvK+
PiAhcx3zqSBTZMUxxbNXt/TcAkCLvrb1Pu1qbo1jjmsZHDpu1A44nSDXUEjsePM1
N19fQRziAYcXcsXNZJrOIGPwn796oDU/8FF5IJN4mR1lnFBPCuc0GhvvGSaRvwFP
/owAkeUoh664zJiQOGDcWl7Jg7yjSCatyGKba4AQxkLd+CT3P/rFepLYsxRSGd+F
svRR8d9frAr3l5g1oMSl1fcTUALzJTF08cyPTt9+6C0u8UtCAepy7OkVs0rWWmTe
wSIt760SKbSV9C1amLv/
=UTEK
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--

--===============7934372177490438800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7934372177490438800==--
