From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: unhide snd_soc_new_compress() declaration
Date: Thu, 31 May 2018 10:12:19 +0900
Message-ID: <583985db-c99c-9b22-ab00-186d5d5cfa67@sakamocchi.jp>
References: <20180530220628.1613824-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530220628.1613824-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 31 2018 07:06, Arnd Bergmann wrote:
> My randconfig build setup came across a new build failure today:
> 
> sound/soc/soc-topology.c: In function 'soc_tplg_dai_create':
> sound/soc/soc-topology.c:1758:27: error: 'snd_soc_new_compress' undeclared (first use in this function); did you mean 'snd_soc_compr_ops'?
>     dai_drv->compress_new = snd_soc_new_compress;
> 
> Simply making that prototype visible again fixes the build failure
> for me, though I'm not exactly sure why we don't get a link
> error now.
> 
> The reference to snd_soc_new_compress() was added a few weeks
> ago and seems to have caused the problem.
> 
> Fixes: 5db6aab6f36f ("ASoC: topology: Add support for compressed PCMs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/sound/soc.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 600a7ebd10c0..8e073865bde3 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -460,9 +460,7 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
>   						   const char *driver_name);
>   
>   int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
> -#ifdef CONFIG_SND_SOC_COMPRESS
>   int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
> -#endif
>   
>   void snd_soc_disconnect_sync(struct device *dev);

This bug was fixed by a commit 0b014d72ebae ('ASoC: fix 0-day warnings
with snd_soc_new_compress()')[1][2] in Mark's tree. It applies an 
different solution to add an alternative inline function.

A small nitpicking; please add 'ASoC' prefix when posting patches to
ALSA SoC part, instead of 'ALSA'.

[1] [alsa-devel] [PATCH] ASoC: fix 0-day warnings with 
snd_soc_new_compress()
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-May/136620.html
[2] ASoC: fix 0-day warnings with snd_soc_new_compress()
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-4.18&id=0b014d72ebae14c0c6ab3fb36a442fda91e1a1b3


Thanks

Takashi Sakamoto
