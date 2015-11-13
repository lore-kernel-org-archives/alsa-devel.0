From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ak4613: add single-end optional
 property for IN/OUT pins
Date: Fri, 13 Nov 2015 11:06:39 +0100
Message-ID: <5645B62F.3020101@metafoo.de>
References: <87ziyiij30.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-240.synserver.de
 [212.40.185.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 83D882612D0
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 11:06:45 +0100 (CET)
In-Reply-To: <87ziyiij30.wl%kuninori.morimoto.gx@renesas.com>
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

On 11/13/2015 06:12 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ak4613 IN/OUT pin can be selected as differential/single-end.
> Differential is default, because it is register default settings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/ak4613.txt | 10 ++++++++
>  sound/soc/codecs/ak4613.c                          | 29 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
> index 15a9195..392b5b5 100644
> --- a/Documentation/devicetree/bindings/sound/ak4613.txt
> +++ b/Documentation/devicetree/bindings/sound/ak4613.txt
> @@ -7,6 +7,16 @@ Required properties:
>  - compatible : "asahi-kasei,ak4613"
>  - reg : The chip select number on the I2C bus
>  
> +Optional properties:
> +- in1-single-end	: Boolean. Indicate input / output pins are single-ended.
> +- in2-single-end	  rather than differential.
> +- out1-single-end
> +- out2-single-end
> +- out3-single-end
> +- out4-single-end
> +- out5-single-end
> +- out6-single-end

vendor prefix?
