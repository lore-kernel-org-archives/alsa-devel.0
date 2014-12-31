From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adi: Add missing return statement.
Date: Wed, 31 Dec 2014 17:34:43 +0100
Message-ID: <54A425A3.2070108@metafoo.de>
References: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id E815F260429
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 17:34:44 +0100 (CET)
In-Reply-To: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <andrew.jackson@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 12/31/2014 05:20 PM, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>
> The probe routine was disabling the clock even
> if the system was configured successfully.  Add
> a return statement to leave clocks enabled.
>
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks, never noticed since the clock is shared with other peripherals.

> ---
> Spotted while reviewing clock preparation
>
>   sound/soc/adi/axi-i2s.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
> index 7752860..4c23381 100644
> --- a/sound/soc/adi/axi-i2s.c
> +++ b/sound/soc/adi/axi-i2s.c
> @@ -240,6 +240,8 @@ static int axi_i2s_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_clk_disable;
>
> +	return 0;
> +
>   err_clk_disable:
>   	clk_disable_unprepare(i2s->clk);
>   	return ret;
>
