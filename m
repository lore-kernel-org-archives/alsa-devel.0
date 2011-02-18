From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Log wm_hubs DC servo operation code
 when reporting a timeout
Date: Fri, 18 Feb 2011 09:18:01 +0000
Message-ID: <1298020681.9630.2.camel@odin>
References: <>
	<1297973257-27612-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E071910395E
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 10:18:04 +0100 (CET)
Received: by wwe15 with SMTP id 15so3438786wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 01:18:04 -0800 (PST)
In-Reply-To: <1297973257-27612-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2011-02-17 at 20:07 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm_hubs.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
> index 613df5d..a5c1556 100644
> --- a/sound/soc/codecs/wm_hubs.c
> +++ b/sound/soc/codecs/wm_hubs.c
> @@ -82,7 +82,8 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
>  	} while (reg & op && count < 400);
>  
>  	if (reg & op)
> -		dev_err(codec->dev, "Timed out waiting for DC Servo\n");
> +		dev_err(codec->dev, "Timed out waiting for DC Servo %x\n",
> +			op);
>  }
>  
>  /*

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
