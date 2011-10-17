From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: wm8741: Fix setting interface
	format for DSP modes
Date: Mon, 17 Oct 2011 13:38:23 +0100
Message-ID: <CABS+qY3zP7Wp+UJXiY+ALtJ_C-ctwjkUJ=WNUAFNZrqANGGWng@mail.gmail.com>
References: <1318853696.4642.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id 18AC524417
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 14:38:25 +0200 (CEST)
Received: by gyh4 with SMTP id 4so2924687gyh.9
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 05:38:23 -0700 (PDT)
In-Reply-To: <1318853696.4642.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 17 October 2011 13:14, Axel Lin <axel.lin@gmail.com> wrote:

> According to the datasheet:
> Format Control (05h)
> BITS[3:2]
>        FMT[1:0] Audio data format selection
>                00 = right justified mode
>                01 = left justified mode
>                10 = I2S mode
>                11 = DSP mode
> BIT[4]  LRP Polarity selec for LRCLK/DSP mode select
>                0 = normal LRCLK poalrity/DSP mode A
>                1 = inverted LRCLK poarity/DSP mode B
>
> For SND_SOC_DAIFMT_DSP_A, we should set 0x000C instead of 0x0003.
> For SND_SOC_DAIFMT_DSP_B, we should set 0x001C instead of 0x0013.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/wm8741.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index a42b282..85ebe02 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -339,10 +339,10 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai
> *codec_dai,
>                iface |= 0x0004;
>                break;
>        case SND_SOC_DAIFMT_DSP_A:
> -               iface |= 0x0003;
> +               iface |= 0x000C;
>                break;
>        case SND_SOC_DAIFMT_DSP_B:
> -               iface |= 0x0013;
> +               iface |= 0x001C;
>                break;
>        default:
>                return -EINVAL;
> --
> 1.7.5.4
>
>
>
>
Both

Acked-by: Liam Girdwood <lrg@ti.com>
