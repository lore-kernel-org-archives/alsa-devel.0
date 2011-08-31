From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Allow register defaults to be larger
 than unsigned short
Date: Wed, 31 Aug 2011 11:54:49 +0100
Message-ID: <4E5E12F9.6040902@ti.com>
References: <1314209592-11433-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 58B2E1038F6
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:54:53 +0200 (CEST)
In-Reply-To: <1314209592-11433-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 24/08/11 19:13, Mark Brown wrote:
> Devices that need this exist; obviously the newer regmap defaults
> mechanism will deal with this more happily.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 6da55a1..0fc8f15 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -622,7 +622,7 @@ struct snd_soc_codec_driver {
>  	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
>  	int (*readable_register)(struct snd_soc_codec *, unsigned int);
>  	int (*writable_register)(struct snd_soc_codec *, unsigned int);
> -	short reg_cache_size;
> +	unsigned int reg_cache_size;
>  	short reg_cache_step;
>  	short reg_word_size;
>  	const void *reg_cache_default;

Acked-by: Liam Girdwood <lrg@ti.com>
