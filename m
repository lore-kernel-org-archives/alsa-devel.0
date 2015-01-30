From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: rx51: Correct DAPM route for capture
Date: Fri, 30 Jan 2015 20:32:36 +0200
Message-ID: <54CBCE44.6040907@bitmer.com>
References: <1422603163-13346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 23AA326047F
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 19:32:58 +0100 (CET)
In-Reply-To: <1422603163-13346-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On 01/30/2015 09:32 AM, Peter Ujfalusi wrote:
> "Mic Bias" is DAPM_SUPPLY so it has to be connected in the route
> accordingly.
> Fixes audio capture on the board.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> ---
>  sound/soc/omap/rx51.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 04896d6252a2..7f299357c2d2 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"FM Transmitter", NULL, "LLOUT"},
>  	{"FM Transmitter", NULL, "RLOUT"},
>  
> -	{"DMic Rate 64", NULL, "Mic Bias"},
> -	{"Mic Bias", NULL, "DMic"},
> +	{"DMic Rate 64", NULL, "DMic"},
> +	{"DMic", NULL, "Mic Bias"},
>  
>  	{"b LINE2R", NULL, "MONO_LOUT"},
>  	{"Earphone", NULL, "b HPLOUT"},
>  
> -	{"LINE1L", NULL, "b Mic Bias"},
> -	{"b Mic Bias", NULL, "HS Mic"}
> +	{"LINE1L", NULL, "HS Mic"},
> +	{"HS Mic", NULL, "b Mic Bias"},
>  };
>  
Here's additional data. Without this patch there are these errors below
when registering the card:

[    8.804626] rx51-audio n900-audio: Connecting non-supply widget to
supply widget is not supported (DMic -> Mic Bias)
[    8.815795] rx51-audio n900-audio: ASoC: no dapm match for DMic -->
(null) --> Mic Bias
[    8.824249] rx51-audio n900-audio: ASoC: Failed to add route DMic ->
direct -> Mic Bias
[    8.832763] rx51-audio n900-audio: Connecting non-supply widget to
supply widget is not supported (HS Mic -> b Mic Bias)
[    8.844238] rx51-audio n900-audio: ASoC: no dapm match for HS Mic -->
(null) --> b Mic Bias
[    8.853057] rx51-audio n900-audio: ASoC: Failed to add route HS Mic
-> direct -> b Mic Bias

This don't happen on v3.18 so in that sense Peter's patch is kind of
half-regression fix for v3.19. On the another hand DMIC recording is not
working anyway since codec mic bias definition is missing at the moment
from omap3-n900.dts.

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
