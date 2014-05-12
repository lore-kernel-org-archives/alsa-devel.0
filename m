From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/5] ASoC: Revert "ASoC: dapm: Fix
 double prefix addition"
Date: Mon, 12 May 2014 17:00:23 +0200
Message-ID: <5370E207.4010605@metafoo.de>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4CE265057
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 17:00:29 +0200 (CEST)
In-Reply-To: <1399472428-11034-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/07/2014 04:20 PM, Lars-Peter Clausen wrote:
> This reverts commit bd23c5b661858446267f4d6b2fb4edd8eb710dda.
>
> The patch claims that the patch is necessary to avoid double prefix addition
> when calling snd_soc_dapm_add_route() from snd_soc_dapm_connect_dai_link_widgets().
> But snd_soc_dapm_add_route() is called with the card's DAPM context, which does
> not have a prefix, which means there is no prefix that could be added a second
> time.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I might be missing something. My best guess is that this was needed in some
> vendor tree, but not in upstream.

Hi Songhee, Arun,

Can you take a look at this? I think the reason why you had this patch is 
because this was needed to prevent double prefix addition in 
snd_soc_dapm_link_dai_widgets(). All other places where dapm_add_route() 
is/was used do not suffer the problem of double prefix addition. But 
snd_soc_dapm_link_dai_widgets() was changed in commit commit 2553628e 
("ASoC: dapm: Add snd_soc_dapm_add_path() helper function") to use 
dapm_add_path which does not have the problem since it doesn't try to add a 
prefix. v3.12 was the first kernel that had this commit and I think that you 
forward ported this change from a vendor tree that was based on an earlier 
version. So in summery I think the issue that you tried to fix this patch 
was already fixed by the time you submitted the patch.

Thanks,
- Lars


> ---
>   sound/soc/soc-dapm.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 142a738..08d869c 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2381,8 +2381,7 @@ err:
>   }
>
>   static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
> -				  const struct snd_soc_dapm_route *route,
> -				  unsigned int is_prefixed)
> +				  const struct snd_soc_dapm_route *route)
>   {
>   	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
>   	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
> @@ -2392,7 +2391,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
>   	char prefixed_source[80];
>   	int ret;
>
> -	if (dapm->codec && dapm->codec->name_prefix && !is_prefixed) {
> +	if (dapm->codec && dapm->codec->name_prefix) {
>   		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
>   			 dapm->codec->name_prefix, route->sink);
>   		sink = prefixed_sink;
> @@ -2520,7 +2519,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
>
>   	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
>   	for (i = 0; i < num; i++) {
> -		r = snd_soc_dapm_add_route(dapm, route, false);
> +		r = snd_soc_dapm_add_route(dapm, route);
>   		if (r < 0) {
>   			dev_err(dapm->dev, "ASoC: Failed to add route %s -> %s -> %s\n",
>   				route->source,
> @@ -3430,7 +3429,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
>   				cpu_dai->codec->name, r.source,
>   				codec_dai->platform->name, r.sink);
>
> -			snd_soc_dapm_add_route(&card->dapm, &r, true);
> +			snd_soc_dapm_add_route(&card->dapm, &r);
>   		}
>
>   		/* connect BE DAI capture if widgets are valid */
> @@ -3441,7 +3440,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
>   				codec_dai->codec->name, r.source,
>   				cpu_dai->platform->name, r.sink);
>
> -			snd_soc_dapm_add_route(&card->dapm, &r, true);
> +			snd_soc_dapm_add_route(&card->dapm, &r);
>   		}
>
>   	}
>
