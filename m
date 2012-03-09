From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Fri, 9 Mar 2012 02:09:57 +0000
Message-ID: <4F596674.5030405@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
	<4F5912D0.2090800@freescale.com>
	<20120309012653.GG2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe001.messaging.microsoft.com [213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD4E10BBC7
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 03:10:05 +0100 (CET)
In-Reply-To: <20120309012653.GG2499@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <0639069221BE7946A97D01D1DA35C8FF@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:

> Something like this:
>
> @@ -496,6 +494,10 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>          struct snd_soc_pcm_runtime *rtd = substream->private_data;
>          struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
>          struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> +       unsigned long flags;
> +       int ret = 0;
> +
> +       spin_lock_irqsave(&ssi_lock, flags);
>
>          switch (cmd) {
>          case SNDRV_PCM_TRIGGER_START:
> @@ -517,10 +519,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>                  break;
>
>          default:
> -               return -EINVAL;
> +               ret = -EINVAL;
>          }
>
> -       return 0;
> +       spin_unlock_irqrestore(&ssi_lock, flags);
> +
> +       return ret;
>   }

That's the general idea, but I think it needs more study.  I don't 
consider this to be a bug that needs to be fixed ASAP, since it's never 
been an actual problem so far.  For instance, do we need to protect 
between hw_params and _trigger?

-- 
Timur Tabi
Linux kernel developer at Freescale
