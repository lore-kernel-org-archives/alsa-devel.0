From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4/6] clk: at91: clk-generated: create
 function to find best_diff
Date: Mon, 3 Jul 2017 16:02:45 +0200
Message-ID: <20170703160245.1481942e@bbrezillon>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
 <20170623090059.8371-5-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D3C266B38
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 16:02:46 +0200 (CEST)
In-Reply-To: <20170623090059.8371-5-quentin.schulz@free-electrons.com>
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

On Fri, 23 Jun 2017 11:00:57 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> The way to find the best_diff and do the appropriate process afterwards
> can be re-used.
> 
> This patch prepares the driver for an upcoming patch that will allow
> clk_generated to determine the rate of the audio_pll.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/clk/at91/clk-generated.c | 41 ++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index dab7002937e6..6530a2e7e84d 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -99,15 +99,36 @@ clk_generated_recalc_rate(struct clk_hw *hw,
>  	return DIV_ROUND_CLOSEST(parent_rate, gck->gckdiv + 1);
>  }
>  
> +static void clk_generated_best_diff(struct clk_rate_request *req,
> +				    struct clk_hw *parent,
> +				    unsigned long parent_rate, u32 div,
> +				    int *best_diff, long *best_rate)
> +{
> +	unsigned long tmp_rate;
> +	int tmp_diff;
> +
> +	if (!div)
> +		tmp_rate = parent_rate;
> +	else
> +		tmp_rate = parent_rate / div;
> +	tmp_diff = abs(req->rate - tmp_rate);
> +
> +	if (*best_diff < 0 || *best_diff > tmp_diff) {
> +		*best_rate = tmp_rate;
> +		*best_diff = tmp_diff;
> +		req->best_parent_rate = parent_rate;
> +		req->best_parent_hw = parent;
> +	}
> +}
> +
>  static int clk_generated_determine_rate(struct clk_hw *hw,
>  					struct clk_rate_request *req)
>  {
>  	struct clk_generated *gck = to_clk_generated(hw);
>  	struct clk_hw *parent = NULL;
>  	long best_rate = -EINVAL;
> -	unsigned long tmp_rate, min_rate;
> +	unsigned long min_rate;
>  	int best_diff = -1;
> -	int tmp_diff;
>  	int i;
>  
>  	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
> @@ -125,18 +146,10 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  			continue;
>  
>  		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
> -		if (!div)
> -			tmp_rate = parent_rate;
> -		else
> -			tmp_rate = parent_rate / div;
> -		tmp_diff = abs(req->rate - tmp_rate);
> -
> -		if (best_diff < 0 || best_diff > tmp_diff) {
> -			best_rate = tmp_rate;
> -			best_diff = tmp_diff;
> -			req->best_parent_rate = parent_rate;
> -			req->best_parent_hw = parent;
> -		}
> +
> +		clk_generated_best_diff(req, parent, parent_rate, div,
> +					&best_diff, &best_rate);
> +
>  
>  		if (!best_diff)
>  			break;
