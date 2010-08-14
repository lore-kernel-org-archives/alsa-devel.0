From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Set up debugfs only once per
 CODEC
Date: Sat, 14 Aug 2010 11:31:34 +0100
Message-ID: <1281781894.3394.100.camel@odin>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A87E24479
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 12:31:38 +0200 (CEST)
Received: by wwi17 with SMTP id 17so1796318wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 03:31:37 -0700 (PDT)
In-Reply-To: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-12 at 15:50 +0100, Mark Brown wrote:
> Since the debugfs directory is current per CODEC we should only init
> it when the CODEC is initialised, otherwise we end up with errors
> being generated when an attempt is made to add duplicate debugfs
> entries.
> 
> Since most of this stuff is actually for the card we should refactor
> but this can come later.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a004876..ac0fa22 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1323,6 +1323,9 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  				return ret;
>  			}
>  		}
> +
> +		soc_init_codec_debugfs(codec);
> +
>  		/* mark codec as probed and add to card codec list */
>  		codec->probed = 1;
>  		list_add(&codec->card_list, &card->codec_dev_list);
> @@ -1400,8 +1403,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  	if (ret < 0)
>  		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
>  
> -	soc_init_codec_debugfs(codec);
> -
>  	/* create the pcm */
>  	ret = soc_new_pcm(rtd, num);
>  	if (ret < 0) {


Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
