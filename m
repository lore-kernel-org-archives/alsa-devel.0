From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: DaVinci: fix kernel panic due to
 uninitialized platform_data
Date: Thu, 27 Jan 2011 20:42:06 +0000
Message-ID: <1296160926.3376.56.camel@odin>
References: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-27 at 19:17 +0530, Manjunathappa, Prakash wrote:
> This patch fixes the Kernel panic issue on accessing davinci_vc in
> cq93vc_probe function. struct davinci_vc is part of platform device's
> private driver data(codec->dev->p->driver_data) and this is populated
> by DaVinci Voice Codec MFD driver.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> This patch applies to Linus's tree at [1].
> 
> [1] http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> ---
>  sound/soc/codecs/cq93vc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
> index 46dbfd0..347a567 100644
> --- a/sound/soc/codecs/cq93vc.c
> +++ b/sound/soc/codecs/cq93vc.c
> @@ -153,7 +153,7 @@ static int cq93vc_resume(struct snd_soc_codec *codec)
>  
>  static int cq93vc_probe(struct snd_soc_codec *codec)
>  {
> -	struct davinci_vc *davinci_vc = codec->dev->platform_data;
> +	struct davinci_vc *davinci_vc = snd_soc_codec_get_drvdata(codec);
>  
>  	davinci_vc->cq93vc.codec = codec;
>  	codec->control_data = davinci_vc;

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
