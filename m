From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Tue, 4 Feb 2014 20:30:02 +0000
Message-ID: <A40422ED-1EEB-4A09-A550-0AAAAA89464D@cirrus.com>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id A672B261A91
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 21:30:10 +0100 (CET)
In-Reply-To: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org



> On Feb 4, 2014, at 13:55, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
> 
> SNDRV_PCM_RATE_KNOT means that the device can support rates that can not be
> expressed using the rate bits. The driver will provide a list of those rates
> specified through constraints. Any rate bits that are set in the rates mask will
> be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT wont have any
> effect, but might be confusing to the casual reader, so remove them.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> sound/soc/codecs/cs42l73.c | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> index 549d5d6..7cae046 100644
> --- a/sound/soc/codecs/cs42l73.c
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -1255,9 +1255,6 @@ static int cs42l73_pcm_startup(struct snd_pcm_substream *substream,
>    return 0;
> }
> 
> -/* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
> -#define CS42L73_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
> -
> 
> #define CS42L73_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
>    SNDRV_PCM_FMTBIT_S24_LE)
> @@ -1278,14 +1275,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
>            .stream_name = "XSP Playback",
>            .channels_min = 1,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .capture = {
>            .stream_name = "XSP Capture",
>            .channels_min = 1,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .ops = &cs42l73_ops,
> @@ -1298,14 +1295,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
>            .stream_name = "ASP Playback",
>            .channels_min = 2,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .capture = {
>            .stream_name = "ASP Capture",
>            .channels_min = 2,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .ops = &cs42l73_ops,
> @@ -1318,14 +1315,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
>            .stream_name = "VSP Playback",
>            .channels_min = 1,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .capture = {
>            .stream_name = "VSP Capture",
>            .channels_min = 1,
>            .channels_max = 2,
> -            .rates = CS42L73_RATES,
> +            .rates = SNDRV_PCM_RATE_KNOT,
>            .formats = CS42L73_FORMATS,
>        },
>        .ops = &cs42l73_ops,
> -- 
> 1.8.0
> 
> 
I don't see how this makes it any less confusing to the casual reader. I think the define works well in the descriptive sense. maybe a comment about what KNOT really means instead of just using a non-rate define?

Thanks,
Brian 
