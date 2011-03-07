From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add LM4857 to SND_SOC_ALL_CODECS
Date: Mon, 07 Mar 2011 12:49:54 +0000
Message-ID: <1299502194.3377.21.camel@odin>
References: <1299500627-18305-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C4AC103827
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:50:00 +0100 (CET)
Received: by wyb28 with SMTP id 28so4015083wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 04:49:58 -0800 (PST)
In-Reply-To: <1299500627-18305-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-07 at 12:23 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 212859c..10f11dd 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -31,6 +31,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_DA7210 if I2C
>  	select SND_SOC_DFBMCS320
>  	select SND_SOC_JZ4740_CODEC if SOC_JZ4740
> +	select SND_SOC_LM4857 if I2C
>  	select SND_SOC_MAX98088 if I2C
>  	select SND_SOC_MAX9877 if I2C
>  	select SND_SOC_PCM3008

Acked-by: Liam Girdwood <lrg@ti.com>
