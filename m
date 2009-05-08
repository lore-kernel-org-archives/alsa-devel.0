From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Fri, 8 May 2009 09:40:44 +0300
Message-ID: <20090508094044.0c85e86a.jhnikula@gmail.com>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 72AF6248A6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 08:39:13 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so353874eyw.56
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 23:39:13 -0700 (PDT)
In-Reply-To: <1241763077-6851-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, getarunks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri,  8 May 2009 09:11:17 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> This patch fixes the 'tuck' phenomena observed on the headset
> output after the streams are stopped and DAPM send the codec
> to standby mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/twl4030.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index fd392c6..06042a1 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -599,7 +599,7 @@ static int headsetl_event(struct
> snd_soc_dapm_widget *w, /* Is this needed? Can we just use whatever
> gain here? */ twl4030_write(w->codec, TWL4030_REG_HS_GAIN_SET,
>  				(hs_gain & (~0x0f)) | 0x0a);
> -		hs_pop |= TWL4030_RAMP_EN;
> +		hs_pop &= ~TWL4030_VMID_EN;
>  		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET,
> hs_pop); 
>  		/* Restore the original volume */
> @@ -613,7 +613,7 @@ static int headsetl_event(struct
> snd_soc_dapm_widget *w, twl4030_i2c_write_u8
> (TWL4030_MODULE_AUDIO_VOICE, hs_gain & (~0x0f),
>  					TWL4030_REG_HS_GAIN_SET);
> -		hs_pop &= ~TWL4030_VMID_EN;
> +		hs_pop |= TWL4030_RAMP_EN;
>  		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET,

It really does fix the power-up & -down pops on Beagle. By listening
carefully I can hear slight power-up and -down pops but only if really
focusing on it.

But now the audio output is distorted and volume level is a little bit
lower. Without the patch it plays fine. Is it possible that now the
output voltage is not correctly biased? Worth to check with a scope.


-- 
Jarkko
