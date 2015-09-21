From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RFC 6/7] ASoC: tlv320aic26: Add support for DSP_B data
 format
Date: Mon, 21 Sep 2015 09:19:23 +0300
Message-ID: <55FFA16B.8060105@ti.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1442607076-26681-7-git-send-email-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442607076-26681-7-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cormier, Jonathan" <jcormier@criticallink.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Gluszek <greg.gluszek@criticallink.com>
List-Id: alsa-devel@alsa-project.org

On 09/18/2015 11:11 PM, Cormier, Jonathan wrote:
> Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
> ---
>  sound/soc/codecs/tlv320aic26.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320=
aic26.c
> index c3b0a698ea66..5c5641cd28de 100644
> --- a/sound/soc/codecs/tlv320aic26.c
> +++ b/sound/soc/codecs/tlv320aic26.c
> @@ -211,6 +211,7 @@ static int aic26_set_fmt(struct snd_soc_dai *code=
c_dai, unsigned int fmt)
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:     aic26->datfm =3D AIC26_DATFM_I2S; brea=
k;
>  	case SND_SOC_DAIFMT_DSP_A:   aic26->datfm =3D AIC26_DATFM_DSP; brea=
k;
> +	case SND_SOC_DAIFMT_DSP_B:   aic26->datfm =3D AIC26_DATFM_DSP; brea=
k;

Are you sure about this? According to the datasheet:
www.ti.com/litv/slas412 page 18 there is no bit to change the data dela=
y and
the format the codec supports is DSP_A.

>  	case SND_SOC_DAIFMT_RIGHT_J: aic26->datfm =3D AIC26_DATFM_RIGHTJ; b=
reak;
>  	case SND_SOC_DAIFMT_LEFT_J:  aic26->datfm =3D AIC26_DATFM_LEFTJ; br=
eak;
>  	default:
>=20


--=20
P=E9ter
