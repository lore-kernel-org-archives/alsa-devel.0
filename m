From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 5/6] ASoC: 88pm860x: Remove redundant
	platform_set_drvdata()
Date: Tue, 7 May 2013 09:53:48 +0800
Message-ID: <CAN1soZx=eSmBkx+QWCYoRuRH=J=89P42xk1+r0Y5i9ndw9nAnQ@mail.gmail.com>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f174.google.com (mail-ea0-f174.google.com
 [209.85.215.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 79953260866
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 03:53:50 +0200 (CEST)
Received: by mail-ea0-f174.google.com with SMTP id f15so15490eak.5
 for <alsa-devel@alsa-project.org>; Mon, 06 May 2013 18:53:49 -0700 (PDT)
In-Reply-To: <1367572164-19523-5-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 3, 2013 at 5:09 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  sound/soc/codecs/88pm860x-codec.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
> index 60159c0..1382f3f 100644
> --- a/sound/soc/codecs/88pm860x-codec.c
> +++ b/sound/soc/codecs/88pm860x-codec.c
> @@ -1444,7 +1444,7 @@ static int pm860x_codec_probe(struct platform_device *pdev)
>                 res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>                 if (!res) {
>                         dev_err(&pdev->dev, "Failed to get IRQ resources\n");
> -                       goto out;
> +                       return -EINVAL;
>                 }
>                 pm860x->irq[i] = res->start + chip->irq_base;
>                 strncpy(pm860x->name[i], res->name, MAX_NAME_LEN);
> @@ -1454,19 +1454,14 @@ static int pm860x_codec_probe(struct platform_device *pdev)
>                                      pm860x_dai, ARRAY_SIZE(pm860x_dai));
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to register codec\n");
> -               goto out;
> +               return -EINVAL;
>         }
>         return ret;
> -
> -out:
> -       platform_set_drvdata(pdev, NULL);
> -       return -EINVAL;
>  }
>
>  static int pm860x_codec_remove(struct platform_device *pdev)
>  {
>         snd_soc_unregister_codec(&pdev->dev);
> -       platform_set_drvdata(pdev, NULL);
>         return 0;
>  }
>
> --
> 1.7.9.5
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
