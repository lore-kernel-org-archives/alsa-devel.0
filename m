From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: Intel: Skylake: make function
 skl_clk_round_rate static
Date: Fri, 9 Feb 2018 11:07:41 +0900
Message-ID: <88ad9256-5c68-1e36-dd72-eba8ecba66e7@sakamocchi.jp>
References: <20180208143530.11450-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 0971A267767
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 03:07:44 +0100 (CET)
In-Reply-To: <20180208143530.11450-1-colin.king@canonical.com>
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
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 8 2018 23:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function skl_clk_round_rate is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
> 'skl_clk_round_rate' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/soc/intel/skylake/skl-ssp-clk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> index 7fbddf5e3b00..cda1b5fa7436 100644
> --- a/sound/soc/intel/skylake/skl-ssp-clk.c
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -247,8 +247,8 @@ static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
>   }
>   
>   /* Not supported by clk driver. Implemented to satisfy clk fw */
> -long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> -				unsigned long *parent_rate)
> +static long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
>   {
>   	return rate;
>   }


Thanks

Takashi Sakamoto
