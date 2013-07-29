From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: bfin-ac97: Fix prototype error
 following AC'97 refactoring
Date: Mon, 29 Jul 2013 18:55:11 +0200
Message-ID: <51F69E6F.8040205@metafoo.de>
References: <1375084417-29437-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-143.synserver.de (smtp-out-144.synserver.de
 [212.40.185.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D5B2625FE
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 18:54:21 +0200 (CEST)
In-Reply-To: <1375084417-29437-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/29/2013 09:53 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> As part of the multiplatform refactoring for AC'97 the AC'97 bus ops were
> staticised meaning that the prototype (which was never needed) conflicts
> with the declaration causing build failures.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/blackfin/bf5xx-ac97.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
> index 15c635e..0c3e22d 100644
> --- a/sound/soc/blackfin/bf5xx-ac97.h
> +++ b/sound/soc/blackfin/bf5xx-ac97.h
> @@ -9,7 +9,6 @@
>  #ifndef _BF5XX_AC97_H
>  #define _BF5XX_AC97_H
>  
> -extern struct snd_ac97_bus_ops bf5xx_ac97_ops;
>  extern struct snd_ac97 *ac97;
>  /* Frame format in memory, only support stereo currently */
>  struct ac97_frame {
> 
