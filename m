From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Report error codes for card DAI
 instantiation failures
Date: Wed, 22 Sep 2010 09:54:49 +0100
Message-ID: <1285145689.3107.6.camel@odin>
References: <1285086241-26354-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 11F341038D9
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 10:54:52 +0200 (CEST)
Received: by wwb28 with SMTP id 28so245034wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 01:54:51 -0700 (PDT)
In-Reply-To: <1285086241-26354-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2010-09-21 at 17:24 +0100, Mark Brown wrote:
> Also clean up the error print a bit.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 7c64e03..5c58651 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1568,7 +1568,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
>  	for (i = 0; i < card->num_links; i++) {
>  		ret = soc_probe_dai_link(card, i);
>  		if (ret < 0) {
> -			printk(KERN_ERR "asoc: failed to instanciate card %s\n", card->name);
> +			pr_err("asoc: failed to instantiate card %s: %d\n",
> +			       card->name, ret);
>  			goto probe_dai_err;
>  		}
>  	}

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
