From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Check return value from
 wm_adsp_buffer_init
Date: Tue, 22 Nov 2016 22:17:37 +0200
Message-ID: <e4a2b271-d4d2-0539-cc83-f5a753af3b9a@sakamocchi.jp>
References: <1479829114-11579-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1AEB7266E43
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 21:17:47 +0100 (CET)
In-Reply-To: <1479829114-11579-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On Nov 22 2016 17:38, Charles Keepax wrote:
> We are not checking the return value from a call to wm_adsp_buffer_init
> it looks like this used to be returned at the bottom of the function but
> probably got missed when more error paths were added. This patch adds
> the appropriate error check.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> 
> Changes since v1:
>  - Add unlock of the mutex on the error path
> 
> Thanks,
> Charles
> 
>  sound/soc/codecs/wm_adsp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 6ccb731..e00ccfc 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -2580,8 +2580,13 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
>  
>  		mutex_lock(&dsp->pwr_lock);
>  
> -		if (wm_adsp_fw[dsp->fw].num_caps != 0)
> +		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
>  			ret = wm_adsp_buffer_init(dsp);
> +			if (ret < 0) {
> +				mutex_unlock(&dsp->pwr_lock);
> +				goto err;
> +			}
> +		}
>  
>  		mutex_unlock(&dsp->pwr_lock);

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto @ UTC+2
