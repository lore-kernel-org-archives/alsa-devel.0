From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: da7218: Fix incorrect usage of
 bitwise '&' operator for SRM check
Date: Wed, 3 May 2017 23:10:21 +0900
Message-ID: <e03173b7-3ec5-7971-c996-7b9803cd0936@sakamocchi.jp>
References: <20170503135406.5EA1E3FB6C@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C2EE92667FE
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 16:10:26 +0200 (CEST)
In-Reply-To: <20170503135406.5EA1E3FB6C@swsrvapps-01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On May 3 2017 22:54, Adam Thomson wrote:
> In the SRM lock check section of code the '&' bitwise operator is
> used as part of checking lock status. Functionally the code works
> as intended, but the conditional statement is a boolean comparison
> so should really use '&&' logical operator instead. This commit
> rectifies this discrepancy.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  sound/soc/codecs/da7218.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> index d256ebf..6e1940e 100644
> --- a/sound/soc/codecs/da7218.c
> +++ b/sound/soc/codecs/da7218.c
> @@ -1457,7 +1457,7 @@ static int da7218_dai_event(struct snd_soc_dapm_widget *w,
>  				++i;
>  				msleep(DA7218_SRM_CHECK_DELAY);
>  			}
> -		} while ((i < DA7218_SRM_CHECK_TRIES) & (!success));
> +		} while ((i < DA7218_SRM_CHECK_TRIES) && (!success));
>  
>  		if (!success)
>  			dev_warn(codec->dev, "SRM failed to lock\n");

Would you please fix codes for da7213, too?


Regards

Takashi Sakamoto
