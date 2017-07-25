From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4 1/9] clk: at91: clk-generated: remove
 useless divisor loop
Date: Tue, 25 Jul 2017 17:28:02 +0200
Message-ID: <4bffddd0-cf9d-8f68-204a-f754f7f384d5@microchip.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
 <b9d92004d22f745e8acde0599359d67538c006a9.1500968090.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa3.microchip.iphmx.com (esa3.microchip.iphmx.com
 [68.232.153.233])
 by alsa0.perex.cz (Postfix) with ESMTP id DD713266CFE
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 17:27:24 +0200 (CEST)
In-Reply-To: <b9d92004d22f745e8acde0599359d67538c006a9.1500968090.git-series.quentin.schulz@free-electrons.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 25/07/2017 at 09:37, Quentin Schulz wrote:
> The driver requests the current clk rate of each of its parent clocks to
> decide whether a clock rate is suitable or not. It does not request
> determine_rate from a parent clock which could request a rate change in
> parent clock (i.e. there is no parent rate propagation).
> 
> We know the rate we want (passed along req argument of the function) and
> the parent clock rate, thus we know the closest rounded divisor, we
> don't need to iterate over the available divisors to find the best one
> for a given clock.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index f0b7ae9..ef4b4e0 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -124,19 +124,18 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  		    (gck->range.max && min_rate > gck->range.max))
>  			continue;
>  
> -		for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
> -			tmp_rate = DIV_ROUND_CLOSEST(parent_rate, div);
> -			tmp_diff = abs(req->rate - tmp_rate);
> -
> -			if (best_diff < 0 || best_diff > tmp_diff) {
> -				best_rate = tmp_rate;
> -				best_diff = tmp_diff;
> -				req->best_parent_rate = parent_rate;
> -				req->best_parent_hw = parent;
> -			}
> -
> -			if (!best_diff || tmp_rate < req->rate)
> -				break;
> +		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
> +		if (!div)
> +			tmp_rate = parent_rate;
> +		else
> +			tmp_rate = parent_rate / div;
> +		tmp_diff = abs(req->rate - tmp_rate);
> +
> +		if (best_diff < 0 || best_diff > tmp_diff) {
> +			best_rate = tmp_rate;
> +			best_diff = tmp_diff;
> +			req->best_parent_rate = parent_rate;
> +			req->best_parent_hw = parent;
>  		}
>  
>  		if (!best_diff)
> 


-- 
Nicolas Ferre
