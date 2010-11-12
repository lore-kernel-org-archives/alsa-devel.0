From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Use DAPM context rather than
 CODEC when constructing sequences
Date: Fri, 12 Nov 2010 21:06:43 +0200
Message-ID: <20101112210643.bb39d54a.jhnikula@gmail.com>
References: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1289577671-13837-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D07210398F
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 20:06:58 +0100 (CET)
Received: by eyg24 with SMTP id 24so2031165eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 11:06:57 -0800 (PST)
In-Reply-To: <1289577671-13837-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 12 Nov 2010 16:01:11 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> DAPM widgets may be associated with non-CODEC devices so compare based
> on the DAPM context rather than the CODEC pointer.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index bc2ec06..5ee93a5 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -710,8 +710,8 @@ static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
>  		return sort[a->id] - sort[b->id];
>  	if (a->reg != b->reg)
>  		return a->reg - b->reg;
> -	if (a->codec != b->codec)
> -		return (unsigned long)a->codec - (unsigned long)b->codec;
> +	if (a->dapm != b->dapm)
> +		return (unsigned long)a->dapm - (unsigned long)b->dapm;
>  
Definitely, this conversion was missing from DAPM decoupling patch.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
