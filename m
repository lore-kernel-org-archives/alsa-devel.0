From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8960: correct gain value for
 input PGA and add microphone PGA
Date: Wed, 9 Sep 2015 13:02:06 +0100
Message-ID: <20150909120206.GB30013@edi-sw-dsktp001.ad.cirrus.com>
References: <22ae1784eb84bf45b23bb7095b7dea8a116c0c2c.1441798038.git.zidan.wang@freescale.com>
 <4aff33dcdc441f7c7a2612fef80c099aafec1e1d.1441798038.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 793E8260709
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 14:02:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4aff33dcdc441f7c7a2612fef80c099aafec1e1d.1441798038.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2015 at 07:29:11PM +0800, Zidan Wang wrote:
> The input PGAs have a gain range from -17.25dB to +30dB in 0.75dB steps.
> 
> The boost stage can provide additional gain. For line inputs, -12dB to
> +6dB gain is available on the boost mixer. For micphone inputs, it can
> provide up to +29dB additional gain from the microphone PGA.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/codecs/wm8960.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 6163474..6975390 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -212,27 +212,37 @@ static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
>  }
>  
>  static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
> +static const DECLARE_TLV_DB_SCALE(inpga_tlv, -1725, 75, 0);
>  static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
>  static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
>  static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
> -static const DECLARE_TLV_DB_SCALE(boost_tlv, -1500, 300, 1);
> +static const DECLARE_TLV_DB_SCALE(lineinboost_tlv, -1500, 300, 1);
> +static const unsigned int micboost_tlv[] = {
> +	TLV_DB_RANGE_HEAD(2),
> +	0, 1, TLV_DB_SCALE_ITEM(0, 1300, 0),
> +	2, 3, TLV_DB_SCALE_ITEM(2000, 900, 0),
> +};
>  
>  static const struct snd_kcontrol_new wm8960_snd_controls[] = {
>  SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
> -		 0, 63, 0, adc_tlv),
> +		 0, 63, 0, inpga_tlv),

This would make adc_tlv unused so you should probably remove it.

Although looking at this, it does looks a bit to me like the
registers are just specified wrong here and this was intended to
be the ADC volumes rather than the PGA volumes. In which case the
current TLV would be correct, the registers should be correct and
a new control should be added if you need to use the PGA volume.

Thanks,
Charles

>  SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
>  	6, 1, 0),
>  SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
>  	7, 1, 0),
>  
>  SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
> -	       WM8960_INBMIX1, 4, 7, 0, boost_tlv),
> +	       WM8960_INBMIX1, 4, 7, 0, lineinboost_tlv),
>  SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
> -	       WM8960_INBMIX1, 1, 7, 0, boost_tlv),
> +	       WM8960_INBMIX1, 1, 7, 0, lineinboost_tlv),
>  SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
> -	       WM8960_INBMIX2, 4, 7, 0, boost_tlv),
> +	       WM8960_INBMIX2, 4, 7, 0, lineinboost_tlv),
>  SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
> -	       WM8960_INBMIX2, 1, 7, 0, boost_tlv),
> +	       WM8960_INBMIX2, 1, 7, 0, lineinboost_tlv),
> +SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT1 Volume",
> +		WM8960_RINPATH, 4, 4, 0, micboost_tlv),
> +SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT1 Volume",
> +		WM8960_LINPATH, 4, 4, 0, micboost_tlv),
>  
>  SOC_DOUBLE_R_TLV("Playback Volume", WM8960_LDAC, WM8960_RDAC,
>  		 0, 255, 0, dac_tlv),
> -- 
> 1.9.1
