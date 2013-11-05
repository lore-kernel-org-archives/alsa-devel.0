From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 15/31] ASoC: omap: Use WARN_ON() instead of
	BUG_ON()
Date: Tue, 5 Nov 2013 20:54:59 +0200
Message-ID: <20131105185459.GA24848@bitmer.com>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-16-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7182619F9
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 19:55:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1383673218-18405-16-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 05, 2013 at 06:40:02PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/omap/n810.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
> index 5e8d640d314f..6d216cb6c19b 100644
> --- a/sound/soc/omap/n810.c
> +++ b/sound/soc/omap/n810.c
> @@ -344,8 +344,11 @@ static int __init n810_soc_init(void)
>  	clk_set_parent(sys_clkout2_src, func96m_clk);
>  	clk_set_rate(sys_clkout2, 12000000);
>  
> -	BUG_ON((gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0) ||
> -	       (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0));
> +	if (WARN_ON((gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0) ||
> +		    (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0))) {

Strong ack! (/me wondering why I put it there in the first place)

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
