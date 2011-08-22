From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Provide more detail on WM8962
 thermal shutdown status
Date: Mon, 22 Aug 2011 11:55:20 +0100
Message-ID: <4E523598.80509@ti.com>
References: <1313946485-30519-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 583CE24544
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:55:33 +0200 (CEST)
In-Reply-To: <1313946485-30519-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

+ alsa-devel

On 21/08/11 18:08, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>

>  sound/soc/codecs/wm8962.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index d2db512..ae7a263 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -839,7 +839,7 @@ static const struct wm8962_reg_access {
>  	[40] = { 0x00FF, 0x01FF, 0x0000 }, /* R40    - SPKOUTL volume */
>  	[41] = { 0x00FF, 0x01FF, 0x0000 }, /* R41    - SPKOUTR volume */
>  
> -	[47] = { 0x000F, 0x0000, 0x0000 }, /* R47    - Thermal Shutdown Status */
> +	[47] = { 0x000F, 0x0000, 0xFFFF }, /* R47    - Thermal Shutdown Status */
>  	[48] = { 0x7EC7, 0x7E07, 0xFFFF }, /* R48    - Additional Control (4) */
>  	[49] = { 0x00D3, 0x00D7, 0xFFFF }, /* R49    - Class D Control 1 */
>  	[51] = { 0x0047, 0x0047, 0x0000 }, /* R51    - Class D Control 2 */
> @@ -3575,6 +3575,7 @@ static irqreturn_t wm8962_irq(int irq, void *data)
>  	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
>  	int mask;
>  	int active;
> +	int reg;
>  
>  	mask = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2_MASK);
>  
> @@ -3595,9 +3596,21 @@ static irqreturn_t wm8962_irq(int irq, void *data)
>  	if (active & WM8962_FIFOS_ERR_EINT)
>  		dev_err(codec->dev, "FIFO error\n");
>  
> -	if (active & WM8962_TEMP_SHUT_EINT)
> +	if (active & WM8962_TEMP_SHUT_EINT) {
>  		dev_crit(codec->dev, "Thermal shutdown\n");
>  
> +		reg = snd_soc_read(codec, WM8962_THERMAL_SHUTDOWN_STATUS);
> +
> +		if (reg & WM8962_TEMP_ERR_HP)
> +			dev_crit(codec->dev, "Headphone thermal error\n");
> +		if (reg & WM8962_TEMP_WARN_HP)
> +			dev_crit(codec->dev, "Headphone thermal warning\n");
> +		if (reg & WM8962_TEMP_ERR_SPK)
> +			dev_crit(codec->dev, "Speaker thermal error\n");
> +		if (reg & WM8962_TEMP_WARN_SPK)
> +			dev_crit(codec->dev, "Speaker thermal warning\n");
> +	}
> +
>  	if (active & (WM8962_MICSCD_EINT | WM8962_MICD_EINT)) {
>  		dev_dbg(codec->dev, "Microphone event detected\n");
>  
