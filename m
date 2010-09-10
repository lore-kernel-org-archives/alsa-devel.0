From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] ASoC: Samsung: Debug PCM platform
 device name
Date: Fri, 10 Sep 2010 12:19:11 +0100
Message-ID: <1284117551.3088.228.camel@odin>
References: <1284104477-18493-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 647BE103981
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:19:20 +0200 (CEST)
Received: by eye27 with SMTP id 27so541731eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:19:20 -0700 (PDT)
In-Reply-To: <1284104477-18493-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 16:41 +0900, Jassi Brar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The PCM controller platform devices are registered by the
> name 'samsung-pcm', so use the same in the CPU driver.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  sound/soc/s3c24xx/s3c-pcm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
> index d404f80..6e9139f 100644
> --- a/sound/soc/s3c24xx/s3c-pcm.c
> +++ b/sound/soc/s3c24xx/s3c-pcm.c
> @@ -525,7 +525,7 @@ static struct platform_driver s3c_pcm_driver = {
>  	.probe  = s3c_pcm_dev_probe,
>  	.remove = s3c_pcm_dev_remove,
>  	.driver = {
> -		.name = "samsung-pcm-audio",
> +		.name = "samsung-pcm",
>  		.owner = THIS_MODULE,
>  	},
>  };
> @@ -546,4 +546,4 @@ module_exit(s3c_pcm_exit);
>  MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
>  MODULE_DESCRIPTION("S3C PCM Controller Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:samsung-pcm-audio");
> +MODULE_ALIAS("platform:samsung-pcm");

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
