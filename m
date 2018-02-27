From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 3/7] ASoC: simple_card_utils: Set clock
	frequency
Date: Tue, 27 Feb 2018 18:19:42 +0100
Message-ID: <20180227171942.GF1479@piout.net>
References: <20180130110604.GA18123@lenoch>
 <20180130110844.GD18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED472676E9
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 18:19:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180130110844.GD18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 30/01/2018 at 12:08:45 +0100, Ladislav Michl wrote:
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  sound/soc/generic/simple-card-utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 3751a07de6aa..6b0cadc56933 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -185,6 +185,10 @@ int asoc_simple_card_parse_clk(struct device *dev,
>  	 */
>  	clk = devm_get_clk_from_child(dev, node, NULL);
>  	if (!IS_ERR(clk)) {
> +		if (!of_property_read_u32(node, "clock-frequency", &val)) {
> +			if (clk_set_rate(clk, val))
> +				dev_err(dev, "failed to set frequency %d\n", val);
> +		}

This would need to be documented in the simple card bindings but I think
you may instead use: assigned-clocks and assigned-clock-rates.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
