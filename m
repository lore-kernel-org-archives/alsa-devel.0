From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: wm_adsp: Check return value from
 wm_adsp_buffer_init
Date: Tue, 22 Nov 2016 17:22:17 +0200
Message-ID: <3aa7c6c7-07f8-2463-48d9-a0d5d73f2f82@sakamocchi.jp>
References: <1479825975-7219-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 02D092665B0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 16:22:26 +0100 (CET)
In-Reply-To: <1479825975-7219-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Charles,

On Nov 22 2016 16:46, Charles Keepax wrote:
> We are not checking the return value from a call to wm_adsp_buffer_init
> it looks like this used to be returned at the bottom of the function but
> probably got missed when more error paths were added. This patch adds
> the appropriate error check.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm_adsp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 6ccb731..7e4f8dd 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -2580,8 +2580,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
>  
>  		mutex_lock(&dsp->pwr_lock);
>  
> -		if (wm_adsp_fw[dsp->fw].num_caps != 0)
> +		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
>  			ret = wm_adsp_buffer_init(dsp);
> +			if (ret < 0)
> +				goto err;
> +		}

Need to call mutex_unlock() before jumping to err label?

>  
>  		mutex_unlock(&dsp->pwr_lock);


Regards

Takashi Sakamoto
