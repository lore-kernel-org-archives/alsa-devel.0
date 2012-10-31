From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix channel swap for
	24-bit format
Date: Wed, 31 Oct 2012 16:50:50 +0800
Message-ID: <CAP1dx+ydbcYfFrdG0sa2Ro2kfJbCS99nm4J_uFWT4JUo7NkcdQ@mail.gmail.com>
References: <1351638429-13865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D5B22615F5
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 09:50:51 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id c10so1626218ieb.38
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 01:50:50 -0700 (PDT)
In-Reply-To: <1351638429-13865-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 31 October 2012 07:07, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Playing 24-bit format file leads to channel swap on mx28 and the reason is that
> the current driver performs one write/read to/from the SAIF_DATA register to
> trigger the transfer.
>
> This approach works fine for S16_LE case because SAIF_DATA is a 32-bit register
> and thus is capable of storing the 16-bit left and right channels, but for the
> S24_LE case it can only store one channel, so in order to not lose the FIFO sync
> an extra read/write is needed.
>
> Reported-by: Dan Winner <DWinner@tc-helicon.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Tested-by: Dan Winner <DWinner@tc-helicon.com>
> ---
>  sound/soc/mxs/mxs-saif.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index aa037b2..05a875c 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -523,16 +523,22 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
>
>                 if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                         /*
> -                        * write a data to saif data register to trigger
> -                        * the transfer
> +                        * write data to saif data register to trigger
> +                        * the transfer.
> +                        * For 24-bit format the 32-bit FIFO register stores
> +                        * only one channel, so we need to write twice.
>                          */
>                         __raw_writel(0, saif->base + SAIF_DATA);
> +                       __raw_writel(0, saif->base + SAIF_DATA);
This probably could a workaround for the customer, but i'm not sure
Mark could accept it
since the code is a bit confusing. (Mark, what's your suggestion on this?)
Maybe the correct way to do is to get rid of this write for playback
and the read for capture,
since I did not see any place in datasheet to specify we must
write/read to trigger the transfer,
But the test result seems we indeed need this to trigger.
And this code also exists in Freescale internal BSP for a long time.
Maybe we need spend some more time to dig into why the trigger is needed,
however, one bad thing is that the original owner of this IC module
has left Freescale,
i have no one to ask about hw details now.

Regards
Dong Aisheng

>                 } else {
>                         /*
> -                        * read a data from saif data register to trigger
> -                        * the receive
> +                        * read data from saif data register to trigger
> +                        * the receive.
> +                        * For 24-bit format the 32-bit FIFO register stores
> +                        * only one channel, so we need to read twice.
>                          */
>                         __raw_readl(saif->base + SAIF_DATA);
> +                       __raw_readl(saif->base + SAIF_DATA);
>                 }
>
>                 master_saif->ongoing = 1;
> --
> 1.7.9.5
>
