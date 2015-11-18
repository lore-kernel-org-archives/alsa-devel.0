From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: ak4613: add single-end optional
 property for IN/OUT pins
Date: Wed, 18 Nov 2015 09:33:05 +0100
Message-ID: <564C37C1.1070103@metafoo.de>
References: <87oaeud01r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-064.synserver.de
 [212.40.185.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F91226051B
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 09:33:10 +0100 (CET)
In-Reply-To: <87oaeud01r.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/16/2015 05:51 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ak4613 IN/OUT pin can be selected as differential/single-end.
> Default is differential, because it is register default settings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - add vender prefix
> 
>  Documentation/devicetree/bindings/sound/ak4613.txt | 10 ++++++++
>  sound/soc/codecs/ak4613.c                          | 29 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
> index 15a9195..3cf63e7 100644
> --- a/Documentation/devicetree/bindings/sound/ak4613.txt
> +++ b/Documentation/devicetree/bindings/sound/ak4613.txt
> @@ -7,6 +7,16 @@ Required properties:
>  - compatible : "asahi-kasei,ak4613"
>  - reg : The chip select number on the I2C bus
>  
> +Optional properties:
> +- ak4613,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
> +- ak4613,in2-single-end	  rather than differential.
> +- ak4613,out1-single-end
> +- ak4613,out2-single-end
> +- ak4613,out3-single-end
> +- ak4613,out4-single-end
> +- ak4613,out5-single-end
> +- ak4613,out6-single-end

The vendor prefix is usually the same as for the compatible string, rather
than the part name. E.g. in this case asahi-kasei.
