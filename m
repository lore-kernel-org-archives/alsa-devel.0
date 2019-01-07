From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 19/21] ASoC: da7219: use logical AND
Date: Mon, 7 Jan 2019 13:26:05 +0000
Message-ID: <AM5PR1001MB099401B759C21332BC92403F80890@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
 <20190105020249.8639-20-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.4]) by alsa0.perex.cz (Postfix) with ESMTP id 4CF6E2665E5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 14:26:09 +0100 (CET)
In-Reply-To: <20190105020249.8639-20-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Support Opensource <Support.Opensource@diasemi.com>, "tiwai@suse.de" <tiwai@suse.de>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 05 January 2019 02:03, Pierre-Louis Bossart wrote:

> Reported by Sparse:
> da7219.c:841:57: warning: dubious: x & !y
> 
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c index
> ce165047b9f9..513ec0368653 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -838,7 +838,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget
> *w,
>  				++i;
>  				msleep(50);
>  			}
> -		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
> +		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
> 
>  		if (!srm_lock)
>  			dev_warn(component->dev, "SRM failed to lock\n");
> --
> 2.17.1
