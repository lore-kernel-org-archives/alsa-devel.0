From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v1 3/5] ASOC: mmp: add sspa support
Date: Fri, 8 Jun 2012 06:10:24 +0800
Message-ID: <20120607221019.GA14525__24448.7084135928$1339116960$gmane$org@opensource.wolfsonmicro.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5202044424473309874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Chao Xie <cxie4@marvell.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5202044424473309874==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 02:37:29PM +0800, Zhangfei Gao wrote:
> The SSPA is a configurable multi-channel audio serial (TDM) interface.
> It's configurable at runtime to support up to 128 channels and the
> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
> support stereo format: I2S, left-justified or right-justified.

This looks mostly good (though you want to check your indentation a bit)
but...

> +static int __init mmp_sspa_modinit(void)
> +{
> +	audio_clk = clk_get(NULL, "mmp-audio");
> +	if (IS_ERR(audio_clk))
> +		return PTR_ERR(audio_clk);
> +
> +	sysclk = clk_get(NULL, "mmp-sysclk");
> +	if (IS_ERR(sysclk))
> +		return PTR_ERR(sysclk);
> +	clk_enable(audio_clk);

You should be doing this stuff from the driver, not from the module init
(and ideally you'd be managing the audio clock dynamically).  Even if
it's the same clock every time in current silicon it's still a good idea
to do this from a quality of implementation point of view.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0SbEAAoJEBus8iNuMP3dfFIQAJw6YAM6fqL9rA4aGtT6/6M9
eExr4SoHugtlZyRundEZtp+lxM1lKJqubXRrV9XYAhXskRU6Wa4PcZh7C2TcBqRo
rOXDTZ+o0DDs3YtldWlMm3WWCUT+iC2tdOpLAAevdBWADjSQzaIGjLusJvg41Lr9
tofO/R4hrcibrPz13TFRlZugeHNwme8qEV1DT8+pXB2J9xyMWqgiuuwgQOlwEFCY
lUBEUpPTaHkl1NUz4i+5IArsrPCBo9WNslxDMpS6dvs96p1WqvuoL4ZI9a93YBMJ
js4xUarWXxXRnLKcQZnaL55jVnhMu5ip6z6/+RUxogVsBx1QKb9ZMQIoCTYcQFCU
B4wphqhEHG1pbBPPc36RpRweJ0H2VF2wHKi064JtA1Q3cArm4GAqzkEcbxpE//6K
vOdkOiMlhCFNpWpbjo6IROtO39/JXlO9L/ziHSDwz9R2Q2p7DIBOV27obSHfrXwa
4Xs3uEyFHoCEfdldoOKh05rQ7B9H6GjhPUMsCeDsccipV7Z/iKPIMwtqaECNa+ND
cH+t+a3wj/5vBBOcINUrKqlse4DRMImgrDbUrg+5HqwRhDYkQZITPOfjcRutrjrW
B22xiMKIaZHvWiZEGaV2Ag2+AynD5zftvLm8nijRVVYQaABtxPy0cOIQOodyhcoV
xMe9lI4kd3Lv/mjzeT3z
=M7eN
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============5202044424473309874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5202044424473309874==--
