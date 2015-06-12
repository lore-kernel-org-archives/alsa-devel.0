From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH 3/4] ASoC: wm8960: add kcontrol to select
	ADC data output
Date: Fri, 12 Jun 2015 13:29:18 +0100
Message-ID: <20150612122918.GG32730@opensource.wolfsonmicro.com>
References: <cover.1434020423.git.zidan.wang@freescale.com> <e7e1d4817ea6d4a1140a31ed21c5860cbaaaad3c.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7e1d4817ea6d4a1140a31ed21c5860cbaaaad3c.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2015 at 07:14:35PM +0800, Zidan Wang wrote:
> add kcontrol to select ADC data output.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/codecs/wm8960.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index c1be15c..62246f1 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -141,6 +141,12 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
>  static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
>  static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
>  static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
> +static const char *wm8960_adc_data_sel[] = {
> +	"ldata = left ADC; rdata = right ADC",
> +	"ldata = left ADC; rdata = left ADC",
> +	"ldata = right ADC; rdata = right ADC",
> +	"ldata = right ADC; rdata = left ADC",
> +};

I see the datasheet lists this as one field but it would probably
look nicer as two controls, one to select the left channel source
and one for the right channel source.

Thanks,
Charles
