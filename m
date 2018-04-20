From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH][next] ASoC: rt5668: fix incorrect 'and'
	operator
Date: Fri, 20 Apr 2018 06:08:29 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7027C9E45@RTITMBSV02.realtek.com.tw>
References: <20180419143431.13173-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B0958266CA1
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 08:08:40 +0200 (CEST)
In-Reply-To: <20180419143431.13173-1-colin.king@canonical.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Thursday, April 19, 2018 10:35 PM
> To: Bard Liao; Oder Chiou; Liam Girdwood; Mark Brown; Jaroslav Kysela;
> Takashi Iwai; alsa-devel@alsa-project.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently logical and is being used instead of bitwise and. Fix this.
> 
> Detected by CoverityScan, CID#1468008 ("Logical vs bitwise operator")
> 
> Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-By: Bard Liao <bardliao@realtek.com>

> ---
>  sound/soc/codecs/rt5668.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
> index 52a343f96eb2..3c19d03f2446 100644
> --- a/sound/soc/codecs/rt5668.c
> +++ b/sound/soc/codecs/rt5668.c
> @@ -1194,7 +1194,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget
> *w,
>  	int ref, val, reg, idx = -EINVAL;
>  	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
> 
> -	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1)
> &&
> +	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &
>  		RT5668_GP4_PIN_MASK;
>  	if (w->shift == RT5668_PWR_ADC_S1F_BIT &&
>  		val == RT5668_GP4_PIN_ADCDAT2)
> --
> 2.17.0
> 
> 
> ------Please consider the environment before printing this e-mail.
