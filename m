From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix missing space in WM8994
Date: Fri, 18 Feb 2011 09:17:01 +0000
Message-ID: <1298020621.9630.0.camel@odin>
References: <1297897918-6598-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3FD22243FA
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 10:17:06 +0100 (CET)
Received: by wyi11 with SMTP id 11so3388325wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 01:17:05 -0800 (PST)
In-Reply-To: <1297897918-6598-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2011-02-16 at 15:11 -0800, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index d78abec..c0adbf8 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -526,7 +526,7 @@ static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
>  					 struct snd_ctl_elem_value *ucontrol)
>  {
>  	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> -	struct wm8994_priv *wm8994 =snd_soc_codec_get_drvdata(codec);
> +	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
>  	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
>  
>  	ucontrol->value.enumerated.item[0] = wm8994->retune_mobile_cfg[block];

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
