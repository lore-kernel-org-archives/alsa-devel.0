From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ASoC: ams-delta: remove duplicate 'const'
Date: Thu, 7 Mar 2019 08:22:06 -0700
Message-ID: <20190307152206.GF20201@archlinux-ryzen>
References: <20190307101101.613881-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307101101.613881-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 07, 2019 at 11:10:49AM +0100, Arnd Bergmann wrote:
> clang points out that SOC_ENUM_SINGLE_EXT_DECL() contains a 'const'
> modifier already, so adding another one does not make it more const:
> 
> sound/soc/ti/ams-delta.c:203:14: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
> static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>              ^
> include/sound/soc.h:351:2: note: expanded from macro 'SOC_ENUM_SINGLE_EXT_DECL'
>         const struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  sound/soc/ti/ams-delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
> index 4dce494dfbd3..b9611db14c86 100644
> --- a/sound/soc/ti/ams-delta.c
> +++ b/sound/soc/ti/ams-delta.c
> @@ -200,7 +200,7 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> -static const SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
> +static SOC_ENUM_SINGLE_EXT_DECL(ams_delta_audio_enum,
>  				      ams_delta_audio_mode);
>  
>  static const struct snd_kcontrol_new ams_delta_audio_controls[] = {
> -- 
> 2.20.0
> 
