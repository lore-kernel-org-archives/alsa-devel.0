From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8985: Remove unneeded declaration.
Date: Fri, 24 Sep 2010 16:31:04 +0100
Message-ID: <1285342264.13240.22.camel@odin>
References: <1285329727-15786-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4962824521
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 17:31:07 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2845805wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 08:31:07 -0700 (PDT)
In-Reply-To: <1285329727-15786-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-24 at 13:02 +0100, Dimitris Papastamos wrote:
> We are not using the private data in this function, so get rid of it.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8985.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
> index 247585a..b94af96 100644
> --- a/sound/soc/codecs/wm8985.c
> +++ b/sound/soc/codecs/wm8985.c
> @@ -557,12 +557,10 @@ static int wm8985_dac_mute(struct snd_soc_dai *dai, int mute)
>  
>  static int wm8985_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  {
> -	struct wm8985_priv *wm8985;
>  	struct snd_soc_codec *codec;
>  	u16 format, master, bcp, lrp;
>  
>  	codec = dai->codec;
> -	wm8985 = snd_soc_codec_get_drvdata(codec);
>  
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
