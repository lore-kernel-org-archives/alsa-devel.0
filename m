From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: soc.h: Add new caching API
 prototypes and hooks
Date: Thu, 4 Nov 2010 14:20:19 -0400
Message-ID: <20101104182019.GC6088@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-2-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CFEC243F5
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:20:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288880564-31957-2-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 02:22:41PM +0000, Dimitris Papastamos wrote:

> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

As previously mentioned please split this series up into patches which
individually add some useful functiionality 

> +/* SoC cache ops */
> +struct snd_soc_cache_ops {
> +	int id; /* corresponds to snd_soc_compress_type */

Shouldn't this be using the enum then?

> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -4,6 +4,8 @@
>  
>  menuconfig SND_SOC
>  	tristate "ALSA for SoC audio support"
> +	select LZO_COMPRESS
> +	select LZO_DECOMPRESS
>  	select SND_PCM
>  	select AC97_BUS if SND_SOC_AC97_BUS
>  	select SND_JACK if INPUT=y || INPUT=SND

This definitely looks like it should be in a separate patch.
