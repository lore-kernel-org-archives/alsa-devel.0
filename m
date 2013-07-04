From: varun Yadav <varunyadav83@gmail.com>
Subject: Re: ASoC: wm8962: NULL pdata pointer
Date: Thu, 4 Jul 2013 15:13:30 +0530
Message-ID: <CAEdSvOz5dmUfLZ0SQdym0HJhf21DsqxTqGqZ2fG=J684s=xdVg@mail.gmail.com>
References: <20130704062913.GC14617@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id EB23C26563C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 11:43:30 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id eg20so1035465lab.5
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 02:43:30 -0700 (PDT)
In-Reply-To: <20130704062913.GC14617@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Shwan,

Do you have spk-mono in imx6q-sabresd.dts file, if yes then remove it.

Regards,
Varun



On Thu, Jul 4, 2013 at 11:59 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Mark,
>
> I'm running next-20130703 and seeing the following NULL pointer bug.
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> pgd = 80004000
> [00000004] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-next-20130703 #6
> task: bf870000 ti: bf874000 task.ti: bf874000
> PC is at wm8962_probe+0x140/0x6b4
> ...
>
> It seems to me that it's caused by a merge error in 384b834.  And the
> change below can remove the problem.
>
> Shawn
>
> ---8<----
>
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index b1dc7d4..e2de9ec 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3377,7 +3377,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
>  {
>         int ret;
>         struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
> -       struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
> +       struct wm8962_pdata *pdata = &wm8962->pdata;
>         int i, trigger, irq_pol;
>         bool dmicclk, dmicdat;
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
