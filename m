From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/6] ASoC: Indentation fix for null loop
	operation
Date: Mon, 6 Jun 2011 20:35:57 +0100
Message-ID: <4DED2C1D.7040409@ti.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B4B87243AA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 21:36:09 +0200 (CEST)
In-Reply-To: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 19:18, Mark Brown wrote:
> More with the legibility.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 6be6546..988cdff 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -209,7 +209,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
>  		int val, item, bitmask;
>  
>  		for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
> -		;
> +			;
>  		val = snd_soc_read(w->codec, e->reg);
>  		item = (val >> e->shift_l) & (bitmask - 1);
>  

All


Acked-by: Liam Girdwood <lrg@ti.com>
