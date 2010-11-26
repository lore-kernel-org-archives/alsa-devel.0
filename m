From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove redundant hw_write
 initialisation in WM8737
Date: Fri, 26 Nov 2010 12:26:57 +0000
Message-ID: <1290774417.3298.7.camel@odin>
References: <1290772916-31532-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE7451037FF
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 13:27:04 +0100 (CET)
Received: by wwe15 with SMTP id 15so1998273wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 04:27:00 -0800 (PST)
In-Reply-To: <1290772916-31532-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-26 at 12:01 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8737.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
> index 2301338..30c67d0 100644
> --- a/sound/soc/codecs/wm8737.c
> +++ b/sound/soc/codecs/wm8737.c
> @@ -560,7 +560,6 @@ static int wm8737_probe(struct snd_soc_codec *codec)
>  	struct wm8737_priv *wm8737 = snd_soc_codec_get_drvdata(codec);
>  	int ret, i;
>  
> -	codec->hw_write = (hw_write_t)i2c_master_send;
>  	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8737->control_type);
>  	if (ret != 0) {
>  		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
