From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: clean up wm8974 and wm8978 clock
	divider handling
Date: Fri, 29 Jan 2010 14:15:19 +0000
Message-ID: <20100129141519.GA5824@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1001281628560.4356@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 330B91038E4
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 15:15:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001281628560.4356@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2010 at 04:30:54PM +0100, Guennadi Liakhovetski wrote:
> wm8974 and wm8978 codec drivers control DAC and ADC oversampling rates in their
> .set_clkdiv() methods, which is wrong, because these are simple boolean
> switches and not clock dividers. Move these bits to sound controls. Also remove
> manual configuration of the MCLK divider in wm8978, since it is configured
> automatically.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  sound/soc/codecs/wm8974.c |   12 ++++--------
>  sound/soc/codecs/wm8974.h |   12 +-----------
>  sound/soc/codecs/wm8978.c |   19 ++++---------------
>  sound/soc/codecs/wm8978.h |    3 ---
>  sound/soc/sh/migor.c      |    4 ----
>  5 files changed, 9 insertions(+), 41 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
> index 8812751..051d58d 100644
> --- a/sound/soc/codecs/wm8974.c
> +++ b/sound/soc/codecs/wm8974.c
> @@ -170,6 +170,10 @@ SOC_ENUM("Aux Mode", wm8974_auxmode),
>  
>  SOC_SINGLE("Capture Boost(+20dB)", WM8974_ADCBOOST,  8, 1, 0),
>  SOC_SINGLE("Mono Playback Switch", WM8974_MONOMIX, 6, 1, 1),
> +
> +/* DAC / ADC oversampling */
> +SOC_SINGLE("DAC 128x Oversampling", WM8974_DAC, 8, 1, 0),
> +SOC_SINGLE("ADC 128x Oversampling", WM8974_ADC, 8, 1, 0),

Should be "... Switch" for the benefit of applications.
