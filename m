From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: WM8996 record paths need AIFCLK
Date: Mon, 22 Aug 2011 11:19:08 +0100
Message-ID: <4E522D1C.1070301@ti.com>
References: <1313835445-21910-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 967B324508
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:19:12 +0200 (CEST)
In-Reply-To: <1313835445-21910-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 20/08/11 11:17, Mark Brown wrote:
> Make AIFCLK supply the record paths otherwise record will not work unless
> there is a simultaneous playback.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index a44a0e5..0371736 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -1213,6 +1213,16 @@ static const struct snd_soc_dapm_route wm8996_dapm_routes[] = {
>  	{ "AIF2RX0", NULL, "AIFCLK" },
>  	{ "AIF2RX1", NULL, "AIFCLK" },
>  
> +	{ "AIF1TX0", NULL, "AIFCLK" },
> +	{ "AIF1TX1", NULL, "AIFCLK" },
> +	{ "AIF1TX2", NULL, "AIFCLK" },
> +	{ "AIF1TX3", NULL, "AIFCLK" },
> +	{ "AIF1TX4", NULL, "AIFCLK" },
> +	{ "AIF1TX5", NULL, "AIFCLK" },
> +
> +	{ "AIF2TX0", NULL, "AIFCLK" },
> +	{ "AIF2TX1", NULL, "AIFCLK" },
> +
>  	{ "DSP1RXL", NULL, "SYSDSPCLK" },
>  	{ "DSP1RXR", NULL, "SYSDSPCLK" },
>  	{ "DSP2RXL", NULL, "SYSDSPCLK" },

Acked-by: Liam Girdwood <lrg@ti.com>
