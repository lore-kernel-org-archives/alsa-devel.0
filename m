From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Fix some minor errors in mpc5200 psc i2s
	driver
Date: Wed, 29 Oct 2008 15:47:51 -0600
Message-ID: <fa686aa40810291447h7fdfd745w5da90459eee61846@mail.gmail.com>
References: <20081029212203.6940.61993.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EF17244A8
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 22:47:53 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so204750rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 14:47:52 -0700 (PDT)
In-Reply-To: <20081029212203.6940.61993.stgit@terra>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 29, 2008 at 3:22 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Fix missing unsigned for irqsave flags in psc i2s driver
> Make attribute visiblity static
> Collect all sysfs errors before checking status
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  sound/soc/fsl/mpc5200_psc_i2s.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
> index 8692329..809c5c4 100644
> --- a/sound/soc/fsl/mpc5200_psc_i2s.c
> +++ b/sound/soc/fsl/mpc5200_psc_i2s.c
> @@ -277,7 +277,7 @@ static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
>        struct mpc52xx_psc __iomem *regs = psc_i2s->psc_regs;
>        u16 imr;
>        u8 psc_cmd;
> -       long flags;
> +       unsigned long flags;
>
>        if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
>                s = &psc_i2s->capture;
> @@ -699,9 +699,9 @@ static ssize_t psc_i2s_stat_store(struct device *dev,
>        return count;
>  }
>
> -DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
> -DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> -DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> +static DEVICE_ATTR(status, 0644, psc_i2s_status_show, NULL);
> +static DEVICE_ATTR(playback_underrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
> +static DEVICE_ATTR(capture_overrun, 0644, psc_i2s_stat_show, psc_i2s_stat_store);
>
>  /* ---------------------------------------------------------------------
>  * OF platform bus binding code:
> @@ -819,8 +819,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
>
>        /* Register the SYSFS files */
>        rc = device_create_file(psc_i2s->dev, &dev_attr_status);
> -       rc = device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
> -       rc = device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
> +       rc |= device_create_file(psc_i2s->dev, &dev_attr_capture_overrun);
> +       rc |= device_create_file(psc_i2s->dev, &dev_attr_playback_underrun);
>        if (rc)
>                dev_info(psc_i2s->dev, "error creating sysfs files\n");
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
