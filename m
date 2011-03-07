From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sound:soc:soc-core fix one
	small	indentation issue
Date: Mon, 7 Mar 2011 15:16:22 +0000
Message-ID: <20110307151622.GH1829@sirena.org.uk>
References: <1299510885-3133-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 35C1A2447B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 16:16:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299510885-3133-1-git-send-email-guanqun.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 11:14:45PM +0800, Lu Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>

Please remember to CC maintainers on patches - in general please follow
the approach in Documentation/SubmittingPatches.

> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 64befac..f6ba502 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3438,7 +3438,7 @@ int snd_soc_register_platform(struct device *dev,
>  
>  	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
>  	if (platform == NULL)
> -			return -ENOMEM;
> +		return -ENOMEM;
>  
>  	/* create platform component name */
>  	platform->name = fmt_single_name(dev, &platform->id);
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
