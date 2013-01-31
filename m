From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Convert mic bias to
 a supply widget
Date: Thu, 31 Jan 2013 09:02:22 +0100
Message-ID: <510A250E.4000706@ti.com>
References: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9531A260310
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 09:02:29 +0100 (CET)
In-Reply-To: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, lgirdwood@gmail.com, alsa-user@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/30/2013 02:22 PM, Hebbar Gururaja wrote:
> @@ -1493,6 +1544,28 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
>  			aic3x->setup =3D ai3x_setup;
>  		}
>  =

> +		if (!of_property_read_u32(np, "ai3x-micbias-vg", &value)) {
> +			switch (value) {
> +			case 1 :
> +				aic3x->micbias_vg =3D AIC3X_MICBIAS_2_0V;
> +				break;
> +			case 2 :
> +				aic3x->micbias_vg =3D AIC3X_MICBIAS_2_5V;
> +				break;
> +			case 3 :
> +				aic3x->micbias_vg =3D AIC3X_MICBIAS_AVDDV;
> +				break;
> +			default :
> +				aic3x->micbias_vg =3D AIC3X_MICBIAS_OFF;
> +				dev_err(&i2c->dev, "Unsuitable MicBias voltage "
> +							"found in DT\n");
> +			}
> +		} else {
> +			dev_warn(&i2c->dev, "No MicBias voltage found in DT - "
> +							"using default\n");

Since "ai3x-micbias-vg" property is optional I don't think it is appropriate
to print anything here. If you really want a note about this it should be
dev_info().

> +			aic3x->micbias_vg =3D AIC3X_MICBIAS_OFF;
> +		}
> +
>  	} else {
>  		aic3x->gpio_reset =3D -1;
>  	}
> diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3=
x.h
> index 6db3c41..e521ac3 100644
> --- a/sound/soc/codecs/tlv320aic3x.h
> +++ b/sound/soc/codecs/tlv320aic3x.h
> @@ -238,6 +238,10 @@
>  /* Default input volume */
>  #define DEFAULT_GAIN    0x20
>  =

> +/* MICBIAS Control Register */
> +#define MICBIAS_LEVEL_SHIFT	(6)
> +#define MICBIAS_LEVEL_MASK	(3 << 6)
> +
>  /* headset detection / button API */
>  =

>  /* The AIC3x supports detection of stereo headsets (GND + left + right s=
ignal)
> =



-- =

P=E9ter
