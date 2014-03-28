From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/2] ASoC: sirf: Add hdmi support
Date: Fri, 28 Mar 2014 12:38:14 +0000
Message-ID: <20140328123814.GH30768@sirena.org.uk>
References: <1395898025-5437-1-git-send-email-rongjun.ying@csr.com>
 <1395898025-5437-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7536619519714493650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1DB02654C1
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:38:35 +0100 (CET)
In-Reply-To: <1395898025-5437-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============7536619519714493650==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SIpeN1L2gmCc/JOo"
Content-Disposition: inline


--SIpeN1L2gmCc/JOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 01:27:05PM +0800, RongJun Ying wrote:

> +config SND_SOC_SIRF_HDMI
> +	tristate "SoC Audio support for SiRF HDMI"
> +	depends on SND_SOC_SIRF
> +	select SND_SIMPLE_CARD
> +	select SND_SOC_SIRF_I2S
> +	select SND_SOC_HDMI_CODEC
> +

Don't do this, just make all the individual drivers selectable directly
in Kconfig.

--SIpeN1L2gmCc/JOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNW0zAAoJELSic+t+oim9S1IQAJVtpfEA6207njlGm7y4VOz5
0tFRTy5vFqK8Ety63ZVT3MLXuDdiUO71qth8nXHzHhodo6nw9ertICUL/nVsEj3Q
nxabPz+vZk730Wm6XTI04lUiioM/s+QJs9uvP7QUx5cyl6enBq5SEVOQaIHE18fQ
9PWTBu1beVAtmFfHGb4eGEjyOnEkVp+D7Ts5L2JzKEfsisSff1FAo7npS6b0bBum
BFOO2Jj+criP5cwYXb7umMa0fE8lBRRyNT8mdggmWZ23bzj5JiAZsRLcHkvpSQh4
7lWJ+9LVoPmcXZZOVLz4MsAN4Qg0hZtSU8rm0pmMpZ41rVI0Pm5mSGQK0ke35k1g
RP+aw2yy1GBVpiCo64RNqQywK8HI+iGTBbhx5i4J+y8zgIqHUtXk0s0Y2u2SiHNa
Fj8pKcOVc66T37uMB0Eq2qmG/Fq6WuHE9PTkbSC+C/xzc9mPuQqrSxfThbhX/BcT
1uV6UPqOphdNvdiaB4ja91pm4xwoTDzWQgzM3PHiixfdouTdHTjzPwaSX1UpGda0
6uhthdukkyLLjA+4gT/HXB7iNg/2MZgOh1Eet8WN1gFr7DjyZjlvQwsgo+1PevS2
qOZ8JHurASEDBQ6UdY9jfUvNGhDZskdDS5vLiOa24QiEK5PZxLjsxuDGzti9AGIg
MDoK8It+1tYHwC9NroNL
=0c2G
-----END PGP SIGNATURE-----

--SIpeN1L2gmCc/JOo--

--===============7536619519714493650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7536619519714493650==--
