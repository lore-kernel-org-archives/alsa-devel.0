From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC][PATCH] ASoC: Add soc_remove_dai_links
Date: Fri, 08 Apr 2011 18:35:32 +0100
Message-ID: <1302284132.3315.120.camel@odin>
References: <w3pfwptwats.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E6710387B
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 19:35:36 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3604683wwf.20
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 10:35:36 -0700 (PDT)
In-Reply-To: <w3pfwptwats.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-04-08 at 14:50 +0900, Kuninori Morimoto wrote:
> card->num_rtd should be 0 after soc_romve_dai_link
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> To Mark, Liam
> 
> I'm not sure that this is correct patch for ASoC.
> But without this patch, below command doesn't work
> 
> ex) FSI-AK4642 case
> 
> # cd /sys/bus/platform/drivers/fsi-ak4642-audio
> # echo sh_fsi2_a_ak4643.0 > unbind
> # echo sh_fsi2_a_ak4643.0 > bind    *1
> 
> *1
> soc_new_pcm isn't called, and "aplay -l" doens't show fsi-ak4642.
> snd_soc_instantiate_card return around /* bind comleted ? */
> 

Can you confirm are you unloading (all ?) then reloading the driver
modules in this test case ?


>  sound/soc/soc-core.c |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 4dda589..9cd0770 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1451,6 +1451,16 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
>  	}
>  }
>  
> +static void soc_remove_dai_links(struct snd_soc_card *card)
> +{
> +	int i;
> +
> +	for (i = 0; i < card->num_rtd; i++)
> +		soc_remove_dai_link(card, i);
> +
> +	card->num_rtd = 0;
> +}
> +
>  static void soc_set_name_prefix(struct snd_soc_card *card,
>  				struct snd_soc_codec *codec)
>  {
> @@ -1947,8 +1957,7 @@ probe_aux_dev_err:
>  		soc_remove_aux_dev(card, i);
>  
>  probe_dai_err:
> -	for (i = 0; i < card->num_links; i++)
> -		soc_remove_dai_link(card, i);
> +	soc_remove_dai_links(card);
>  
>  card_probe_error:
>  	if (card->remove)
> @@ -2010,8 +2019,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
>  		soc_remove_aux_dev(card, i);
>  
>  	/* remove and free each DAI */
> -	for (i = 0; i < card->num_rtd; i++)
> -		soc_remove_dai_link(card, i);
> +	soc_remove_dai_links(card);
>  
>  	soc_cleanup_card_debugfs(card);
>  

Thanks

Liam
