From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2.6.37 1/2] ASoC: Fix dapm_seq_compare()
 for multi-component
Date: Fri, 12 Nov 2010 21:06:37 +0200
Message-ID: <20101112210637.0ec2d25c.jhnikula@gmail.com>
References: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D881103935
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 20:06:52 +0100 (CET)
Received: by ewy2 with SMTP id 2so72385ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 11:06:52 -0800 (PST)
In-Reply-To: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2010 16:01:10 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> Ensure that we keep all widget powerups in DAPM sequence by making
> the CODEC the last thing we compare on rather than the first thing.
> Also fix the fact that we're currently comparing the widget pointers
> rather than the CODEC pointers when we do the substraction so we
> won't get stable results.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 8352430..bc2ec06 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -706,12 +706,12 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
>  			    struct snd_soc_dapm_widget *b,
>  			    int sort[])
>  {
> -	if (a->codec != b->codec)
> -		return (unsigned long)a - (unsigned long)b;
>  	if (sort[a->id] != sort[b->id])
>  		return sort[a->id] - sort[b->id];
>  	if (a->reg != b->reg)
>  		return a->reg - b->reg;
> +	if (a->codec != b->codec)
> +		return (unsigned long)a->codec - (unsigned long)b->codec;
>  
This sounds feasible change. What I was thinking are there any
benefit which one, the register or codec is compared first but I don't
think there's any practical difference.

A1, B1, A2, B2 (now)
or
A1, A2, B1, B2 (codec comparison before register)

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
