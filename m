From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential
	mono	mode support
Date: Mon, 4 May 2015 09:02:58 +0100
Message-ID: <20150504080258.GV3480@opensource.wolfsonmicro.com>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F704260462
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 10:02:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, May 01, 2015 at 08:13:57PM +0200, Sergej Sawazki wrote:
> The WM8741 DAC supports several differential output modes (stereo,
> stereo reversed, mono left, mono right). Add platform data and DT
> bindings to configure it.
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---
>  Documentation/devicetree/bindings/sound/wm8741.txt |  11 ++
>  sound/soc/codecs/wm8741.c                          | 129 ++++++++++++++++++---
>  sound/soc/codecs/wm8741.h                          |  10 ++
>  3 files changed, 137 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8741.txt b/Documentation/devicetree/bindings/sound/wm8741.txt
> index 74bda58..a133154 100644
> --- a/Documentation/devicetree/bindings/sound/wm8741.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8741.txt
> @@ -10,9 +10,20 @@ Required properties:
>    - reg : the I2C address of the device for I2C, the chip select
>            number for SPI.
>  
> +Optional properties:
> +
> +  - diff-mode: Differential output mode configuration. Default value for field
> +    DIFF in register R8 (MODE_CONTROL_2). If absent, the default is 0, shall be:
> +    0 = stereo
> +    1 = mono left
> +    2 = stereo reversed
> +    3 = mono right
> +
>  Example:
>  
>  codec: wm8741@1a {
>  	compatible = "wlf,wm8741";
>  	reg = <0x1a>;
> +
> +	diff-mode = <3>;
>  };
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index 9e71c76..9b777a6 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -41,6 +41,7 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
>  
>  /* codec private data */
>  struct wm8741_priv {
> +	struct wm8741_platform_data pdata;
>  	struct regmap *regmap;
>  	struct regulator_bulk_data supplies[WM8741_NUM_SUPPLIES];
>  	unsigned int sysclk;
> @@ -87,13 +88,27 @@ static int wm8741_reset(struct snd_soc_codec *codec)
>  static const DECLARE_TLV_DB_SCALE(dac_tlv_fine, -12700, 13, 0);
>  static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 400, 0);
>  
> -static const struct snd_kcontrol_new wm8741_snd_controls[] = {
> +static const struct snd_kcontrol_new wm8741_snd_controls_stereo[] = {
>  SOC_DOUBLE_R_TLV("Fine Playback Volume", WM8741_DACLLSB_ATTENUATION,
>  		 WM8741_DACRLSB_ATTENUATION, 1, 255, 1, dac_tlv_fine),
>  SOC_DOUBLE_R_TLV("Playback Volume", WM8741_DACLMSB_ATTENUATION,
>  		 WM8741_DACRMSB_ATTENUATION, 0, 511, 1, dac_tlv),
>  };
>  
> +static const struct snd_kcontrol_new wm8741_snd_controls_mono_left[] = {
> +SOC_SINGLE_TLV("Fine Playback Volume Left", WM8741_DACLLSB_ATTENUATION,
> +		 1, 255, 1, dac_tlv_fine),
> +SOC_SINGLE_TLV("Playback Volume Left", WM8741_DACLMSB_ATTENUATION,
> +		 0, 511, 1, dac_tlv),
> +};
> +
> +static const struct snd_kcontrol_new wm8741_snd_controls_mono_right[] = {
> +	SOC_SINGLE_TLV("Fine Playback Volume Right", WM8741_DACRLSB_ATTENUATION,
> +		1, 255, 1, dac_tlv_fine),
> +	SOC_SINGLE_TLV("Playback Volume Right", WM8741_DACRMSB_ATTENUATION,
> +		0, 511, 1, dac_tlv),
> +};
> +

Tabbing here could use being fixed, but functionally the change
looks fine to me.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
