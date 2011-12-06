From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC][PATCH] ASoC: Fix build dependency for
	SND_SOC_JZ4740_CODEC
Date: Tue, 06 Dec 2011 09:55:45 +0100
Message-ID: <4EDDD891.5090208@metafoo.de>
References: <1323157131.22557.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-061.synserver.de
	[212.40.185.61]) by alsa0.perex.cz (Postfix) with SMTP id D5D98103B57
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 09:55:26 +0100 (CET)
In-Reply-To: <1323157131.22557.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 12/06/2011 08:38 AM, Axel Lin wrote:
> Currently SND_SOC_JZ4740_CODEC depends on SOC_JZ4740 but SOC_JZ4740 is not
> defined in any Kconfig. Thus the codec driver will not be built when select
> "Build all ASoC CODEC drivers". 
> (Unless it is selected by SND_JZ4740_SOC_QI_LB60).
> Remove the dependency with SOC_JZ4740, then this code driver can be built when
> select "Build all ASoC CODEC drivers".
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> I'm a little bit doubt if I should just remove the dependency as this patch does.
> Or alternatively make it depends on MACH_JZ4740.
> Comments?

MACH_JZ4740 was called SOC_JZ4740 at some point, seems like this one slipped
through the renaming. But since there is no compile time dependency on any
MACH_JZ4740 specific functionality it should be fine to remove the
dependency completely.

Thanks.

> 
> Axel
>  sound/soc/codecs/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index bc2364ac..7c205e7 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -35,7 +35,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_CX20442
>  	select SND_SOC_DA7210 if I2C
>  	select SND_SOC_DFBMCS320
> -	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
> +	select SND_SOC_JZ4740_CODEC
>  	select SND_SOC_LM4857 if I2C
>  	select SND_SOC_MAX98088 if I2C
>  	select SND_SOC_MAX98095 if I2C
