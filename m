From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Ensure we delay long enough for
 WM8994 FLL to lock when starting
Date: Mon, 4 Jul 2011 10:44:44 +0100
Message-ID: <4E118B8C.5020600@ti.com>
References: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 61F591037F2
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 11:44:52 +0200 (CEST)
In-Reply-To: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 02/07/11 01:35, Mark Brown wrote:
> This delay is very conservative.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 38abdff..2eb4594 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -1725,6 +1725,8 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
>  		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_1 + reg_offset,
>  				    WM8994_FLL1_ENA | WM8994_FLL1_FRAC,
>  				    reg);
> +
> +		msleep(5);
>  	}
>  
>  	wm8994->fll[id].in = freq_in;

Acked-by: Liam Girdwood <lrg@ti.com>
