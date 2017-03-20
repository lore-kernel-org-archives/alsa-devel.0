From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/9] ASoC: simple-card-utils: enable
 "label" on asoc_simple_card_parse_card_name
Date: Mon, 20 Mar 2017 14:20:45 -0500
Message-ID: <20170320192045.ktdkuz55lwfpzob6@rob-hp-laptop>
References: <8760jdivfm.wl%kuninori.morimoto.gx@renesas.com>
 <87zigphgjq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D372B2668F6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 20:20:47 +0100 (CET)
Received: by mail-ot0-f194.google.com with SMTP id i50so10766519otd.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:20:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87zigphgjq.wl%kuninori.morimoto.gx@renesas.com>
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

On Mon, Mar 13, 2017 at 05:53:12AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current asoc_simple_card_parse_card_name() detect [prefix]name,
> but in generally, we uses "label" for user visible names.
> This patch expand it to [prefix]label.
> This patch also update simple-xx-card.txt which is using this feature
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - new patch to expand name/labal
> 
>  .../devicetree/bindings/sound/simple-card.txt          |  1 +
>  .../devicetree/bindings/sound/simple-scu-card.txt      |  1 +
>  sound/soc/generic/simple-card-utils.c                  | 18 ++++++++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> index c7a9393..f34a810 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -8,6 +8,7 @@ Required properties:
>  
>  Optional properties:
>  
> +- simple-audio-card,label		: see simple-audio-card,name

Just "label". That's a standard property name.

>  - simple-audio-card,name		: User specified audio sound card name, one string
>  					  property.
>  - simple-audio-card,widgets		: Please refer to widgets.txt.
> diff --git a/Documentation/devicetree/bindings/sound/simple-scu-card.txt b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> index d6fe47e..01eb56e 100644
> --- a/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-scu-card.txt
> @@ -9,6 +9,7 @@ Required properties:
>  
>  Optional properties:
>  
> +- simple-audio-card,label		: see simple-audio-card,name

Ditto.

>  - simple-audio-card,name		: User specified audio sound card name, one string
>  					  property.
>  - simple-audio-card,cpu			: CPU   sub-node
