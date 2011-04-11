From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sn95031: decorate function with
 __devexit_p()
Date: Mon, 11 Apr 2011 20:55:24 +0100
Message-ID: <1302551724.3449.60.camel@odin>
References: <20110409150358.3278.78790.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 582F810384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:55:29 +0200 (CEST)
Received: by wwf26 with SMTP id 26so5661384wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:55:29 -0700 (PDT)
In-Reply-To: <20110409150358.3278.78790.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Koul Vinod <vinod.koul@intel.com>, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-04-09 at 23:03 +0800, Lu Guanqun wrote:
> According to the comments in include/linux/init.h:
> 
> "Pointers to __devexit functions must use __devexit_p(function_name), the
> wrapper will insert either the function_name or NULL, depending on the config
> options."
> 
> Fix this issue in codecs sn95031.
> 
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> ---
>  sound/soc/codecs/sn95031.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
> index 569555f..f70977d 100644
> --- a/sound/soc/codecs/sn95031.c
> +++ b/sound/soc/codecs/sn95031.c
> @@ -918,7 +918,7 @@ static struct platform_driver sn95031_codec_driver = {
>  		.owner		= THIS_MODULE,
>  	},
>  	.probe		= sn95031_device_probe,
> -	.remove		= sn95031_device_remove,
> +	.remove		= __devexit_p(sn95031_device_remove),
>  };
>  
>  static int __init sn95031_init(void)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
