From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Relax restrictions on WM8962 BCLK
	configuration
Date: Thu, 30 Sep 2010 22:50:59 +0100
Message-ID: <1285883459.3101.130.camel@odin>
References: <1285882000-17669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E517C103998
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 23:51:00 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2545836wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 14:51:00 -0700 (PDT)
In-Reply-To: <1285882000-17669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-09-30 at 14:26 -0700, Mark Brown wrote:
> The restrictions on configuring BCLK are overly cautious, other constraints
> in the system should ensure that reconfiguration is not possible when the
> device is sufficiently active to be unable to support reclocking.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index be34146..38cbf85 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -911,12 +911,6 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
>  	int clocking2 = 0;
>  	int aif2 = 0;
>  
> -	/* If the CODEC is powered on we can configure BCLK */
> -	if (codec->bias_level != SND_SOC_BIAS_OFF) {
> -		dev_dbg(codec->dev, "Bias is off, can't configure BCLK\n");
> -		return;
> -	}
> -
>  	if (!wm8962->bclk) {
>  		dev_dbg(codec->dev, "No BCLK rate configured\n");
>  		return;

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
