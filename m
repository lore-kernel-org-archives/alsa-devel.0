From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: McASP: Fix data rotation
	for	playback. Enables 24bit audio playback
Date: Fri, 18 Jan 2013 08:22:53 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB49910@DBDE01.ent.ti.com>
References: <1358260860-10370-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id BFECF265D64
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 09:23:08 +0100 (CET)
In-Reply-To: <1358260860-10370-1-git-send-email-michal.bachraty@streamunlimited.com>
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
To: Michal Bachraty <michal.bachraty@streamunlimited.com>, "tiwai@suse.de" <tiwai@suse.de>, "perex@perex.cz" <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2013 at 20:11:00, Michal Bachraty wrote:
> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>

Even simple patches need a simple changelog.
Add a brief description about what & why it is done?


> ---
>  sound/soc/davinci/davinci-mcasp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 13f8d73..a03bece 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -626,7 +626,7 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>  				       int word_length)
>  {
>  	u32 fmt;
> -	u32 rotate = (32 - word_length) / 4;
> +	u32 rotate = (word_length / 4) & 0x7;
>  	u32 mask = (1ULL << word_length) - 1;
>  
>  	/*
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


Regards, 
Gururaja
