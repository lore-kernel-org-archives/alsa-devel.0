From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Check that WM8996 FLL started even
 if we don't have the IRQ
Date: Tue, 6 Sep 2011 01:40:56 +0100
Message-ID: <CABS+qY1yGa2hnGvFqmdgozXZ+6Cv0K8fGdQ7vOHLw3KAp0JS5g@mail.gmail.com>
References: <1315245962-24961-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D8A61038FF
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 02:40:58 +0200 (CEST)
Received: by qyk35 with SMTP id 35so3611682qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 17:40:56 -0700 (PDT)
In-Reply-To: <1315245962-24961-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 5 September 2011 19:06, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> We can directly read the FLL lock status on WM8996 so even if we don't
> have an interrupt wired up we can still verify that the FLL started
> successfully.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |   26 +++++++++++++++++++-------
>  1 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index 169a865..cbd0206 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -2054,7 +2054,7 @@ static int wm8996_set_fll(struct snd_soc_codec
> *codec, int fll_id, int source,
>        struct i2c_client *i2c = to_i2c_client(codec->dev);
>        struct _fll_div fll_div;
>        unsigned long timeout;
> -       int ret, reg;
> +       int ret, reg, retry;
>
>        /* Any change? */
>        if (source == wm8996->fll_src && Fref == wm8996->fll_fref &&
> @@ -2141,17 +2141,29 @@ static int wm8996_set_fll(struct snd_soc_codec
> *codec, int fll_id, int source,
>        else
>                timeout = msecs_to_jiffies(2);
>
> -       /* Allow substantially longer if we've actually got the IRQ */
> +       /* Allow substantially longer if we've actually got the IRQ, poll
> +        * at a slightly higher rate if we don't.
> +        */
>        if (i2c->irq)
> -               timeout *= 1000;
> +               timeout *= 10;
> +       else
> +               timeout /= 2;
>
> -       ret = wait_for_completion_timeout(&wm8996->fll_lock, timeout);
> +       for (retry = 0; retry < 10; retry++) {
> +               ret = wait_for_completion_timeout(&wm8996->fll_lock,
> +                                                 timeout);
> +               if (ret != 0) {
> +                       WARN_ON(!i2c->irq);
> +                       break;
> +               }
>
> -       if (ret == 0 && i2c->irq) {
> +               ret = snd_soc_read(codec, WM8996_INTERRUPT_RAW_STATUS_2);
> +               if (ret & WM8996_FLL_LOCK_STS)
> +                       break;
> +       }
> +       if (retry == 10) {
>                dev_err(codec->dev, "Timed out waiting for FLL\n");
>                ret = -ETIMEDOUT;
> -       } else {
> -               ret = 0;
>        }
>
>        dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
> --
> 1.7.5.4
>
> Acked-by: Liam Girdwood <lrg@ti.com>
