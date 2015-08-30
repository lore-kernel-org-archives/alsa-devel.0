From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] ASoC: sh: dma-sh7760: Convert to
	devm_snd_soc_register_platform
Date: Sun, 30 Aug 2015 08:22:09 +0200
Message-ID: <CAOLZvyE3_==Eo3JyLnMRjd=2QmqemaLRnNJ_JPSv3Rm071bX6A@mail.gmail.com>
References: <1440904053.32046.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D15260705
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 08:22:49 +0200 (CEST)
Received: by lbvd4 with SMTP id d4so10500164lbv.3
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 23:22:49 -0700 (PDT)
In-Reply-To: <1440904053.32046.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 30, 2015 at 5:07 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/sh/dma-sh7760.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
> index fd11404..8fad444 100644
> --- a/sound/soc/sh/dma-sh7760.c
> +++ b/sound/soc/sh/dma-sh7760.c
> @@ -327,13 +327,7 @@ static struct snd_soc_platform_driver sh7760_soc_platform = {
>
>  static int sh7760_soc_platform_probe(struct platform_device *pdev)
>  {
> -       return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
> -}
> -
> -static int sh7760_soc_platform_remove(struct platform_device *pdev)
> -{
> -       snd_soc_unregister_platform(&pdev->dev);
> -       return 0;
> +       return devm_snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
>  }
>
>  static struct platform_driver sh7760_pcm_driver = {
> @@ -342,7 +336,6 @@ static struct platform_driver sh7760_pcm_driver = {
>         },
>
>         .probe = sh7760_soc_platform_probe,
> -       .remove = sh7760_soc_platform_remove,
>  };
>
>  module_platform_driver(sh7760_pcm_driver);
> --


Looking good,

Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
