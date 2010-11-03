From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove register write trace from
 WM8994
Date: Wed, 03 Nov 2010 18:26:14 +0000
Message-ID: <1288808774.3277.109.camel@odin>
References: <1288806654-29936-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3442110383D
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 19:26:19 +0100 (CET)
Received: by wye20 with SMTP id 20so975883wye.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 11:26:18 -0700 (PDT)
In-Reply-To: <1288806654-29936-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-11-03 at 13:50 -0400, Mark Brown wrote:
> We now have trace in the ASoC core so we don't need to our own trace in
> the driver.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 3f70dee..d81cac5 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -1730,8 +1730,6 @@ static int wm8994_write(struct snd_soc_codec *codec, unsigned int reg,
>  	if (!wm8994_volatile(reg))
>  		wm8994->reg_cache[reg] = value;
>  
> -	dev_dbg(codec->dev, "0x%x = 0x%x\n", reg, value);
> -
>  	return wm8994_reg_write(codec->control_data, reg, value);
>  }
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
