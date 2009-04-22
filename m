From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP: Add checking to detect
	bufferless pcms
Date: Wed, 22 Apr 2009 11:30:32 +0300
Message-ID: <bd7b27490904220130g13602721u6ae4fd3dca21fde5@mail.gmail.com>
References: <49EE7962.6080008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id AA97724619
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 10:30:33 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1673979bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2009 01:30:32 -0700 (PDT)
In-Reply-To: <49EE7962.6080008@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2009 at 4:56 AM, Joonyoung Shim <jy0922.shim@samsung.com>wrote:

> Add checking in hw_params and prepare to detect bufferless pcms(i.e. BT
> <--> codec).
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  sound/soc/omap/omap-pcm.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 07cf7f4..6454e15 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -87,8 +87,10 @@ static int omap_pcm_hw_params(struct snd_pcm_substream
> *substream,
>        struct omap_pcm_dma_data *dma_data = rtd->dai->cpu_dai->dma_data;
>        int err = 0;
>
> +       /* return if this is a bufferless transfer e.g.
> +        * codec <--> BT codec or GSM modem -- lg FIXME */
>        if (!dma_data)
> -               return -ENODEV;
> +               return 0;
>
>
I see exactly similar lines in s3c24xx-pcm.c but don't point now the use
case where this is used and I don't have idea what is this all about.

Is this something where DAI driver or another end of connection is used to
provide clocking and the whole setup is then controlled with ALSA PCM API?
Somehow I have the feeling that would there be a better way to achieve it
than with dummy bufferless transfer?


-- 
Jarkko
