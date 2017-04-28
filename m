From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Use devm_kcalloc()
 in asoc_simple_card_parse_aux_devs()
Date: Fri, 28 Apr 2017 10:57:35 +0200
Message-ID: <20170428085735.i7xpxph24t5v5f5q@piout.net>
References: <8b5e37d1-17c5-4551-801f-ca7939d5efd7@users.sourceforge.net>
 <8c8c6979-0368-9ef5-2e10-57199f0bc03e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0CE266483
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 10:57:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8c8c6979-0368-9ef5-2e10-57199f0bc03e@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 26/04/2017 at 15:04:11 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 14:21:51 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/generic/simple-card.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 2c9dedab5184..b59d51374b89 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -334,8 +334,8 @@ static int asoc_simple_card_parse_aux_devs(struct device_node *node,
>  	if (n <= 0)
>  		return -EINVAL;
>  
> -	card->aux_dev = devm_kzalloc(dev,
> -			n * sizeof(*card->aux_dev), GFP_KERNEL);
> +	card->aux_dev = devm_kcalloc(dev, n, sizeof(*card->aux_dev),
> +				     GFP_KERNEL);

Do you realize that this change has absolutely no value and just makes
the code slower (one more test in the allocation path)?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
