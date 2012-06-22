From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 3/9] sound:asoc: Add support for
 synopsys i2s controller as per ASoC framework.
Date: Fri, 22 Jun 2012 10:25:23 +0100
Message-ID: <20120622092522.GI4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<d7aae7f0d84a69e58b2ed22b45b8d93eff05c25e.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4097093579704479178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B5CF24397
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 11:25:24 +0200 (CEST)
In-Reply-To: <d7aae7f0d84a69e58b2ed22b45b8d93eff05c25e.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============4097093579704479178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6ZTfQE1Row3TVml"
Content-Disposition: inline


--i6ZTfQE1Row3TVml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 03:54:51PM +0530, Rajeev Kumar wrote:
> This patch add support for synopsys I2S controller as per the ASoC
> framework.

I've applied this but I had to rewrite the subject line.

> +static int dw_i2s_suspend(struct snd_soc_dai *dai)
> +{
> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +
> +	clk_disable(dev->clk);
> +	return 0;
> +}

It seems a bit sad that we can't disable the clock when the device is
idle.  If you need the clock for register I/O then something like the
Tegra approach of using regmap to provide a cached copy of the register
map when the device is idle should work well.

--i6ZTfQE1Row3TVml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5Dn8AAoJEBus8iNuMP3dgzUP/3gpv+hWVJNI6yOBCdT2cGIz
qDhV+ZjOzCp+iK+pBEf2FN4A+7oSmIFPYzHiitAOh0DtZMnSrZ+OGtd0LtWOBQdq
+Pss9Pnbr99CUPEXBXa6p4HNN0e/6q/qtcLqiqAPn0UnV5yOv1tkY93z2isIvfAR
L2gi/DP8/R7ae2cv1s69OPkBUBWrLeNXf2irz1H1wc9bPpNwOORMvsKeItemPXwQ
ZmT0da6xg/p0rFCyEW6+q5xpG7fNPS5T1M6e8jmrhJWQG8stlbJpw9nnnLYgMBOV
+HSrMly9DbhMQWiE+Ft/frlHeTGsFg9JvkuGrsgFbmk8A14BRdxdtnGSuns/3g+v
8+WQo76gU1php7d/2KiSZxEgv/F0sF0MVUbRm85sRtQbeAptFphRx6IHSsf67KEq
sD+nyAtl+2Dg93fYelq6rave7jkwmZgZNUlPRFdP5Kh3inz7XE0druSn+tbY5/zX
DG9AfB5ENtsDPESCW0m6QosaoEhEgM/TAso1KGH8M6J2KRQWJG5op0lRCYkrXTH8
guhp/wzuRLeMmK/Ga+TDC30h0L2U38U/VFpl9H7uvoZJ3a8CC+G0B/SbwRhVivPg
U+tpX03h2dEdez4B5w3/kkdAMsFS1ylvaAxsjCLFh5P5E2NYGKjMEwhPzW0gJ6TZ
hxw9pAFNOSKHZrilRqET
=9x7O
-----END PGP SIGNATURE-----

--i6ZTfQE1Row3TVml--

--===============4097093579704479178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4097093579704479178==--
