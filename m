From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Disable wm_hubs periodic DC servo
	update
Date: Fri, 29 Jul 2011 09:12:24 +0100
Message-ID: <1311927144.2712.0.camel@CNA0741383>
References: <1311854176-6865-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id DDCB9103964
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 10:12:30 +0200 (CEST)
In-Reply-To: <1311854176-6865-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-07-28 at 13:56 +0200, Mark Brown wrote:
> This does not function correctly in all circumstances so disable the
> periodic updates unconditionally for stable; a future patch will reenable
> where appropriate.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

>  sound/soc/codecs/wm_hubs.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
> index 4de6794..4416a76 100644
> --- a/sound/soc/codecs/wm_hubs.c
> +++ b/sound/soc/codecs/wm_hubs.c
> @@ -440,9 +440,8 @@ static int hp_event(struct snd_soc_dapm_widget *w,
>  		reg |= WM8993_HPOUT1L_DLY | WM8993_HPOUT1R_DLY;
>  		snd_soc_write(codec, WM8993_ANALOGUE_HP_0, reg);
>  
> -		/* Smallest supported update interval */
>  		snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
> -				    WM8993_DCS_TIMER_PERIOD_01_MASK, 1);
> +				    WM8993_DCS_TIMER_PERIOD_01_MASK, 0);
>  
>  		calibrate_dc_servo(codec);
>  
