From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: add mmp brownstone support
Date: Mon, 28 May 2012 16:13:06 +0100
Message-ID: <20120528151305.GL4032@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4459280635096031219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337929863-31885-5-git-send-email-zhangfei.gao@marvell.com>
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


--===============4459280635096031219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 03:11:03PM +0800, Zhangfei Gao wrote:

> +config SND_MMP_SOC_BROWNSTONE
> +	tristate "SoC Audio support for Marvell Brownstone"
> +	depends on SND_MMP_SOC && MACH_BROWNSTONE
> +	select SND_MMP_SOC_SSPA
> +	select SND_SOC_WM8994

Should depend on MFD_WM8994.

> +static void brownstone_ext_control(struct snd_soc_dapm_context *dapm)
> +{

This stuff is really unexpected in a modern machine driver, it was used
on things like spitz due to the odd wiring but for modern stuff I'd not
expect to see it.

> +	if (brownstone_spk_func == BROWNSTONE_SPK_ON) {
> +		snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
> +		snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
> +	} else {
> +		snd_soc_dapm_disable_pin(dapm, "Ext Left Spk");
> +		snd_soc_dapm_disable_pin(dapm, "Ext Right Spk");
> +	}

Just define a single widget for the speakers and use a
SND_SOC_DAPM_PIN_SWITCH().

> +	/* set up jack connection */
> +	switch (brownstone_jack_func) {
> +	case BROWNSTONE_HP:
> +		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
> +		snd_soc_dapm_enable_pin(dapm, "Main Mic");
> +		snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
> +		break;

This should all be autodetectable, users having to manually select it is
*very* unusual.  Is there really no accessory detection hardware on the
board?

> +	snd_soc_dapm_enable_pin(dapm, "Ext Left Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Ext Right Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Main Mic");

Everything is enable dby default.

> +	/* turn on micbias 1/2 always */
> +	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
> +			    WM8994_MICB1_ENA_MASK |
> +			    WM8994_MICB2_ENA_MASK,
> +			    WM8994_MICB1_ENA |
> +			    WM8994_MICB2_ENA);

If you need to do this force enable them with DAPM, this won't work
anyway as the widgets will be powered off as soon as DAPM notices
they're on.

> +	snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
> +
> +	snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);

Set this in the dai_link.

> +static struct platform_driver mmp_driver = {
> +	.driver		= {
> +		.name	= "mmp-audio",

Should probably be something like "brownstone-audio".

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw5X6AAoJEBus8iNuMP3dleEQAJazfCnhFTylmHDOpy//JM3Q
D8RAUPkL0156Rr1H24sk+JJzn8Gb2zIt7N87bWFF3j8vAxTCAuAMQjZpn5J/kPAC
Ez+hC45hfi2zmm72o7MPqWpOagAv93oAlg02im1p7Seu5eViiu0YdmY3m1tJHIu8
YGc1Z4/JkxM8MLEIN+pzJaoK97JftH5oSO4E375Rr/QjF2nvhpLvecBRiX9v4+cc
xah1bXaNsg4sQbAmx/GYGyjJPwWqZU9taG8vo9e4B50eV65WaH3xdAPTLIrDkrw1
u9EfJVvXLRGxCuszlYRo3M9sSkx2w6Od/Y6qCkqB1YUKRiP0kzu/Ait+MrYLSV9w
ZuNZBo1cbdsIvzXXAus9kt7X6QOzX5p9ulAdsDif/SFhrILHXMWDOwb34kt7tWl3
T785kxXov9QGj+mZmgxih4LmMsKRmafuuGmdpCKScVW6XaL5c9YuZHj4UlTlKP/w
gknUx3x7DgQpQa3F+KAxVRnVX6BkNeTEoIcOdf2o4C3LvnUBBJsqr6lqCSERH/3f
oNNpCa2YDxTdeNkM3QVVjC/YLrhgUZNTNTg8z2V5vc1D6mWT8btbUWUoQFiqkhVP
YU9vJooO/mVl9BfgWv/TwtRT7QwzULfdZ/d2AxZR03/sRDjxd1705sKlSZnvykN/
2t4UN2W6bDsfQkVPWC9i
=QTqc
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4459280635096031219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4459280635096031219==--
