From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm8994: Manage wm8994's MCLK
	in	codec driver
Date: Mon, 16 Mar 2015 15:08:14 +0000
Message-ID: <20150316150814.GK17136@opensource.wolfsonmicro.com>
References: <1426157181-6403-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D19D32612AF
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 16:08:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1426157181-6403-1-git-send-email-ideal.song@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Inha Song <ideal.song@samsung.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, sachin.kamat@samsung.com, tiwai@suse.de, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, nikesh@opensource.wolfsonmicro.com, lgirdwood@gmail.com, cw00.choi@samsung.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2015 at 07:46:21PM +0900, Inha Song wrote:
> Previously, When we use wm8994 codec, we should control its MCLK in machine driver.
> But, It should be managed by wm8994 codec driver, not machine driver.
> 
> This patch add MCLK clock DT parsing logic and control own MCLK.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  sound/soc/codecs/wm8994.c | 22 +++++++++++++++++++++-
>  sound/soc/codecs/wm8994.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 4fbc768..acb6b44 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -16,6 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/pm.h>
> +#include <linux/clk.h>
>  #include <linux/gcd.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_device.h>
> @@ -2471,6 +2472,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
>  {
>  	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
>  	struct wm8994 *control = wm8994->wm8994;
> +	int i;
>  
>  	wm_hubs_set_bias_level(codec, level);
>  
> @@ -2492,8 +2494,15 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
>  			break;
>  		}
>  
> -		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
> +			for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++)
> +				clk_prepare_enable(wm8994->clk_mclk[i]);

This still looks like you need some response to Mark's comments.

> +
>  			active_reference(codec);
> +		} else if (codec->dapm.bias_level == SND_SOC_BIAS_ON) {
> +			for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++)
> +				clk_disable_unprepare(wm8994->clk_mclk[i]);
> +		}
>  		break;
>  
>  	case SND_SOC_BIAS_STANDBY:
> @@ -4449,6 +4458,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
>  static int wm8994_probe(struct platform_device *pdev)
>  {
>  	struct wm8994_priv *wm8994;
> +	int i;
>  
>  	wm8994 = devm_kzalloc(&pdev->dev, sizeof(struct wm8994_priv),
>  			      GFP_KERNEL);
> @@ -4460,6 +4470,16 @@ static int wm8994_probe(struct platform_device *pdev)
>  
>  	wm8994->wm8994 = dev_get_drvdata(pdev->dev.parent);
>  
> +	for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++) {
> +		char mclk_name[] = "MCLKx";
> +
> +		snprintf(mclk_name, sizeof(mclk_name), "MCLK%d", i + 1);
> +
> +		wm8994->clk_mclk[i] = devm_clk_get(pdev->dev.parent, mclk_name);
> +		if (IS_ERR(wm8994->clk_mclk[i]))
> +			wm8994->clk_mclk[i] = NULL;

This still looks wrong, devm_clk_get will return an -ENOENT if it
can't find a clock, but any other error is surely an actual error
that we should fail on?

Thanks,
Charles
