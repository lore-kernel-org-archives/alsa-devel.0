From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 8/8] ASoC: core: Add a warning for
 link_dai_widget in the multicodec case
Date: Tue, 01 Jul 2014 15:41:41 +0200
Message-ID: <53B2BA95.9020504@metafoo.de>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-9-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A462656F9
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 15:41:43 +0200 (CEST)
In-Reply-To: <1404200881-32253-9-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/01/2014 09:48 AM, Benoit Cousson wrote:
> Multicodec links are not supported in the case of CODEC to CODEC links.
> Just print a warning if it happens.
>
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>

This looks good, by maybe just squash it into the other patch that updates 
soc-core.c

> ---
>   sound/soc/soc-core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 3764150..3640242 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1486,6 +1486,9 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
>   	struct snd_soc_dapm_widget *play_w, *capture_w;
>   	int ret;
>
> +	if (rtd->num_codecs > 1)
> +		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
> +
>   	/* link the DAI widgets */
>   	play_w = codec_dai->playback_widget;
>   	capture_w = cpu_dai->capture_widget;
>
