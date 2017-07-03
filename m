From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/6] clk: at91: clk-generated: remove
 useless divisor loop
Date: Mon, 3 Jul 2017 15:58:34 +0200
Message-ID: <20170703155834.4de2a304@bbrezillon>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
 <20170623090059.8371-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EF6A2266B38
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 15:58:35 +0200 (CEST)
In-Reply-To: <20170623090059.8371-2-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, thomas.petazzoni@free-electrons.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, nicolas.ferre@microchip.com, linux@armlinux.org.uk, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, broonie@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jun 2017 11:00:54 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

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

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 07c8f701e51c..dab7002937e6 100644
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
