From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Remove -codec from WM8523 driver
	name
Date: Tue, 2 Aug 2011 09:53:33 +0100
Message-ID: <4E37BB0D.8000100@ti.com>
References: <1312260898-7517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BDF724475
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 10:53:41 +0200 (CEST)
In-Reply-To: <1312260898-7517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 02/08/11 05:54, Mark Brown wrote:
> It's redundant to specify it.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8523.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
> index 4fd4d8d..1312009 100644
> --- a/sound/soc/codecs/wm8523.c
> +++ b/sound/soc/codecs/wm8523.c
> @@ -551,7 +551,7 @@ MODULE_DEVICE_TABLE(i2c, wm8523_i2c_id);
>  
>  static struct i2c_driver wm8523_i2c_driver = {
>  	.driver = {
> -		.name = "wm8523-codec",
> +		.name = "wm8523",
>  		.owner = THIS_MODULE,
>  	},
>  	.probe =    wm8523_i2c_probe,

Acked-by: Liam Girdwood <lrg@ti.com>
