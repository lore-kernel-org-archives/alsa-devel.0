From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: ab8500-codec: Drop bank prefix
 from AB8500_GPIO_DIR4_REG register define
Date: Sun, 17 Aug 2014 09:36:14 -0500
Message-ID: <20140817143614.GO14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8037816245222430047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A61265130
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:36:31 +0200 (CEST)
In-Reply-To: <1408285102-24538-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8037816245222430047==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:22PM +0200, Lars-Peter Clausen wrote:
> The AB8500_GPIO_DIR4_REG register define has the bank for the register in the
> upper 8 bits and the register itself in the lower 8 bits. When passing it to
> abx500_{set,get}_register_interruptible() the upper bits get truncated which

Applied, thanks.

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8L3bAAoJELSic+t+oim9SIsP/3CA61H11n32lW9+N0FsCbD0
dMcqf7WodBHJ4ZL4RO8nOMUoRKiNVcwWfPJaNuGddYXr6OZNZ2umWC9DJr198GKT
U/SCNJ1seP/l/WpBrlem4ULnlRcxcpse5dqEW0S1TzE6Xb2VLpb6b3AT6Nk0vzs+
CGk/3rztcYvYH7hN4KeIuVb9nE17Rd+7q1YAwD9WjFAPXECgKS3wM8CXfSxR64Qr
e3ha8ITYB2kH2Uw4kMJjWh5MSMs/sqwv/L2tgI9FJlF8/T3ltiEDSBZbhtcm9Pdx
cvsbP8EIcpE9DD1j1UrF1+AXIkMnDP1StuuiortEaKMH52DJ705DdFCbzuw67zj2
MScGlnZxguFYsBie5gHqJbPa+NRULZP/IHFzjrCZHpgTeecSU8z5/9e6aVD0XYce
BPEj+CIgsbo8+tYef/y7LhLHgdYwHhmbaHPQwV5DEf0Bz9kvvgGx2kWrRP7AmElP
DIXQZSWaJlDqsDwkxhCODemnh7CynAu8ht8rukZMu+T5uAW6YnOV6KnR0lpzktFu
Q0YnShwx6QK8rRCwGsvkcXLj2O+sUbm98mbpc9ukuk46IUj8TZF3fu0hCzzauH/+
Q+ySzVKOjElupgIOcOnshhxxgXgR1VC6+BRCesubZS5nVzq7Ed8am/2Ta0mfcfmk
C7YxsCevVDRDYA28qRUe
=1S2M
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--

--===============8037816245222430047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8037816245222430047==--
