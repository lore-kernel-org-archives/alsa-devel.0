From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add basic WM8962 capture low/high
	pass filter control
Date: Mon, 22 Aug 2011 11:23:00 +0100
Message-ID: <4E522E04.3020408@ti.com>
References: <1313920577-13590-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 935ED24508
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:23:04 +0200 (CEST)
In-Reply-To: <1313920577-13590-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 21/08/11 10:56, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 32315ec..eaab0d3 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2173,6 +2173,14 @@ static const char *cap_hpf_mode_text[] = {
>  static const struct soc_enum cap_hpf_mode =
>  	SOC_ENUM_SINGLE(WM8962_ADC_DAC_CONTROL_2, 10, 2, cap_hpf_mode_text);
>  
> +
> +static const char *cap_lhpf_mode_text[] = {
> +	"LPF", "HPF"
> +};
> +
> +static const struct soc_enum cap_lhpf_mode =
> +	SOC_ENUM_SINGLE(WM8962_LHPF1, 1, 2, cap_lhpf_mode_text);
> +
>  static const struct snd_kcontrol_new wm8962_snd_controls[] = {
>  SOC_DOUBLE("Input Mixer Switch", WM8962_INPUT_MIXER_CONTROL_1, 3, 2, 1, 1),
>  
> @@ -2201,6 +2209,8 @@ SOC_DOUBLE_R("Capture ZC Switch", WM8962_LEFT_INPUT_VOLUME,
>  SOC_SINGLE("Capture HPF Switch", WM8962_ADC_DAC_CONTROL_1, 0, 1, 1),
>  SOC_ENUM("Capture HPF Mode", cap_hpf_mode),
>  SOC_SINGLE("Capture HPF Cutoff", WM8962_ADC_DAC_CONTROL_2, 7, 7, 0),
> +SOC_SINGLE("Capture LHPF Switch", WM8962_LHPF1, 0, 1, 0),
> +SOC_ENUM("Capture LHPF Mode", cap_lhpf_mode),
>  
>  SOC_DOUBLE_R_TLV("Sidetone Volume", WM8962_DAC_DSP_MIXING_1,
>  		 WM8962_DAC_DSP_MIXING_2, 4, 12, 0, st_tlv),

Acked-by: Liam Girdwood <lrg@ti.com>
