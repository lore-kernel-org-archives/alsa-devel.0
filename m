From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: pcm/oss: mark snd_pcm_plug_slave_format arg as
 const
Date: Thu, 18 May 2017 23:08:45 +0900
Message-ID: <af2da601-4fb1-8d42-ea94-ab4211315b6a@sakamocchi.jp>
References: <20170518133610.1914235-1-arnd@arndb.de>
 <20170518133610.1914235-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518133610.1914235-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 18 2017 22:35, Arnd Bergmann wrote:
> Only one of the two declarations has the const modifier in the
> argument list, so we get a warning when CONFIG_SND_PCM_OSS_PLUGINS
> is disabled:
>
> sound/core/oss/pcm_oss.c: In function 'snd_pcm_oss_change_params':
> sound/core/oss/pcm_oss.c:898:47: error: passing argument 2 of 'snd_pcm_plug_slave_format' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>
> This makes the two declarations match again.
>
> Fixes: e76bf3c4b4e4 ("ALSA: pcm/oss: refer to parameters instead of copying to reduce usage of kernel stack")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/core/oss/pcm_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Indeed. I overlooked that it's conditional...

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
> index 38e2c14cb893..73c068abaca5 100644
> --- a/sound/core/oss/pcm_plugin.h
> +++ b/sound/core/oss/pcm_plugin.h
> @@ -172,7 +172,7 @@ snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
>
>  static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
>  static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
> -static inline int snd_pcm_plug_slave_format(int format, struct snd_mask *format_mask) { return format; }
> +static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
>
>  #endif

Thanks :D

Takashi Sakamoto
