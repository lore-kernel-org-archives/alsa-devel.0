From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
	devm_input_allocate_device()
Date: Wed, 24 Apr 2013 16:50:48 +0300
Message-ID: <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3322615CC
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 15:51:09 +0200 (CEST)
Received: by mail-vc0-f179.google.com with SMTP id hz11so1754431vcb.38
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 06:51:08 -0700 (PDT)
In-Reply-To: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Dec 20, 2012 at 4:18 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 50b0983..1cee9b3 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3210,7 +3210,6 @@ static void wm8962_init_beep(struct snd_soc_codec *codec)
>
>         ret = input_register_device(wm8962->beep);
>         if (ret != 0) {
> -               input_free_device(wm8962->beep);
>                 wm8962->beep = NULL;
>                 dev_err(codec->dev, "Failed to register beep device\n");
>         }

I'm not sure if this patch is correct.
According to comment of input_free_memory()
(http://lxr.free-electrons.com/source/drivers/input/input.c#L1825) you
need to call it if input_register_device failed.


--
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
