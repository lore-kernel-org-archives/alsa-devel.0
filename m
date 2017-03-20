From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 5/9] ASoC: soc-core: enable "dai-name"
 on snd_soc_of_parse_daifmt()
Date: Mon, 20 Mar 2017 14:30:19 -0500
Message-ID: <20170320193019.lnoli55xcv5vhc2r@rob-hp-laptop>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com>
 <87y3w9hgj8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A8912668F6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 20:30:21 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id x37so20360175ota.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:30:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y3w9hgj8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 05:53:30AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current snd_soc_of_parse_daifmt() detects [prefix]format, but
> "format" was unclear. This patch expand it to [prefix]dai-format, too
> This patch update simple-xx-card.txt which uses this feature
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - expand format
> 
>  Documentation/devicetree/bindings/sound/simple-card.txt     | 2 +-
>  Documentation/devicetree/bindings/sound/simple-scu-card.txt | 3 ++-
>  sound/soc/soc-core.c                                        | 9 +++++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> index f34a810..6e8a8a3 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -48,7 +48,7 @@ Required dai-link subnodes:
>  
>  Optional dai-link subnode properties:
>  
> -- format				: CPU/CODEC common audio format.
> +- dai-format / format			: CPU/CODEC common audio format.
>  					  "i2s", "right_j", "left_j" , "dsp_a"
>  					  "dsp_b", "ac97", "pdm", "msb", "lsb"
>  - frame-master				: Indicates dai-link frame master.
> diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> index 01eb56e..47b4677 100644
> --- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> @@ -17,9 +17,10 @@ Optional properties:
>  
>  Optional subnode properties:
>  
> -- simple-audio-card,format		: CPU/CODEC common audio format.
> +- simple-audio-card,dai-format		: CPU/CODEC common audio format.

This one should not be added.

>  					  "i2s", "right_j", "left_j" , "dsp_a"
>  					  "dsp_b", "ac97", "pdm", "msb", "lsb"
> +- simple-audio-card,format		: see simple-audio-card,dai-format
>  - simple-audio-card,frame-master	: Indicates dai-link frame master.
>  					  phandle to a cpu or codec subnode.
>  - simple-audio-card,bitclock-master	: Indicates dai-link bit clock master.
