From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH] ALSA: ASoC: TWL4030 codec - fix 256*Fs
	clock
Date: Wed, 05 Nov 2008 14:24:10 -0800
Message-ID: <1225923850.10608.8.camel@otto>
References: <1225921865-27463-1-git-send-email-notasas@gmail.com>
Reply-To: steve@sakoman.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx11.roch.ny.frontiernet.net (mx11.roch.ny.frontiernet.net
	[66.133.183.238])
	by alsa0.perex.cz (Postfix) with ESMTP id DD80F2414E
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 23:55:40 +0100 (CET)
In-Reply-To: <1225921865-27463-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-11-05 at 23:51 +0200, Grazvydas Ignotas wrote:
> According to TRM, 256*Fs clock output should be enabled
> when TWL4030 is in slave mode, not master.
> This allows sound to work on OMAP3 Pandora, which uses
> 256*Fs clock.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Acked-by: Steve Sakoman <steve@sakoman.com>

As we discussed on IRC you are correct!  I apologize for not making this
change when I resubmitted the patches last week.  Somehow fell off my
todo list.

Steve

> ---
>  sound/soc/codecs/twl4030.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index ee2f0d3..90f3b4d 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -469,11 +469,11 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		format &= ~(TWL4030_AIF_SLAVE_EN);
> -		format |= TWL4030_CLK256FS_EN;
> +		format &= ~(TWL4030_CLK256FS_EN);
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFS:
> -		format &= ~(TWL4030_CLK256FS_EN);
>  		format |= TWL4030_AIF_SLAVE_EN;
> +		format |= TWL4030_CLK256FS_EN;
>  		break;
>  	default:
>  		return -EINVAL;
