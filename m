From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: [PATCH 19/21] ASoC: s3c-i2s-v2 needs to declare a
	license for modular builds
Date: Thu, 23 Apr 2009 21:53:34 +0100
Message-ID: <20090423205334.GA30431@trinity.fluff.org>
References: <20090423195420.GA20863@sirena.org.uk>
	<1240516555-22249-19-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EF241037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 22:53:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1240516555-22249-19-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 08:55:53PM +0100, Mark Brown wrote:
> It relies on EXPORT_SYMBOL_GPL() symbols.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/s3c24xx/s3c-i2s-v2.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
> index 689ffcd..ab680aa 100644
> --- a/sound/soc/s3c24xx/s3c-i2s-v2.c
> +++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
> @@ -636,5 +636,6 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
>  
>  	return snd_soc_register_dai(dai);
>  }
> -
>  EXPORT_SYMBOL_GPL(s3c_i2sv2_register_dai);
> +
> +MODULE_LICENSE("GPL");

A MODULE_DESCRIPTION and MODULE_AUTHOUR tag woudln't go amiss either,
if this is available on a branch i'll look at adding these.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
