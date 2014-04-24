From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Drop node->name
	checking
Date: Thu, 24 Apr 2014 15:47:59 +0300
Message-ID: <535907FF.3040303@ti.com>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
 <ef6f96d375c8771c93469168790e0098610bd250.1398337861.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 97F8C26524C
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:48:06 +0200 (CEST)
In-Reply-To: <ef6f96d375c8771c93469168790e0098610bd250.1398337861.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>, broonie@kernel.org
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/24/2014 02:13 PM, Nicolin Chen wrote:
> The current simple-card driver limits the DT node name to "sound".
> Any of other names is forbidden while actually we should allow DT
> to pass other node names.
>
> And if this function is being called, the node must already have
> the compatible "simple-audio-card" in DTB. So there should be no
> need to check the name here.
>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>   sound/soc/generic/simple-card.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 3f2e580..383a4a1 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -156,8 +156,7 @@ static int simple_card_dai_link_of(struct device_node *node,
>   	char *prefix = "";
>   	int ret;
>
> -	if (!strcmp("sound", node->name))
> -		prefix = "simple-audio-card,";
> +	prefix = "simple-audio-card,";
>
>   	daifmt = snd_soc_of_parse_daifmt(node, prefix,
>   					 &bitclkmaster, &framemaster);
>

I think you have missed the point of selecting the prefix based on the 
node name.

Before the change the "simple-audio-card,"-prefix was only needed for 
dai-link properties and subnodes if the dai-link node was omitted in a 
single dai-link setup.

After your change the prefix is also needed for the properties and 
subnodes inside dai-link subnodes.

See the details in: Documentation/devicetree/bindings/sound/simple-card.txt

Maybe the implementation could have been more explicit, but I think the 
old behavior is more convenient. If we anyway decide to go with this 
change then at least the DT binding document should be updated.

Best regards,
Jyri
