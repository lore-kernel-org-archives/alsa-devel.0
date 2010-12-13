From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix AC'97 registration unwind
Date: Mon, 13 Dec 2010 17:27:54 +0000
Message-ID: <1292261274.3320.85.camel@odin>
References: <1292259851-31853-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F7892468C
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 18:27:58 +0100 (CET)
Received: by wwi18 with SMTP id 18so3836091wwi.2
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:27:57 -0800 (PST)
In-Reply-To: <1292259851-31853-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-13 at 17:04 +0000, Mark Brown wrote:
> soc_unregister_ac97_dai_link() takes a CODEC as an argument, not a
> rtd like the registration function, so give it what it's looking for.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 68edc69..1dc4b11 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1830,7 +1830,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
>  		if (ret < 0) {
>  			printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
>  			while (--i >= 0)
> -				soc_unregister_ac97_dai_link(&card->rtd[i]);
> +				soc_unregister_ac97_dai_link(card->rtd[i].codec);
>  			goto probe_aux_dev_err;
>  		}
>  	}

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
