From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH] ASoC: es8328: Remove extra blank lines
Date: Thu, 9 Mar 2017 17:00:06 +0100
Message-ID: <91ec78bf-bf28-405f-2486-0d70229cd424@collabora.com>
References: <1488019328-9481-1-git-send-email-narcisaanamaria12@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488019328-9481-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, john@metanate.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,


Le 25/02/2017 à 11:42, Narcisa Ana Maria Vasile a écrit :
> This was reported by checkpatch.pl
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
>  sound/soc/codecs/es8328.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
> index 3f84fbd..1967157 100644
> --- a/sound/soc/codecs/es8328.c
> +++ b/sound/soc/codecs/es8328.c
> @@ -177,8 +177,6 @@ static int es8328_put_deemph(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> -
> -
>  static const struct snd_kcontrol_new es8328_snd_controls[] = {
>  	SOC_DOUBLE_R_TLV("Capture Digital Volume",
>  		ES8328_ADCCONTROL8, ES8328_ADCCONTROL9,
Reviewed-by: Romain Perier <romain.perier@collabora.com>


Regards,
Romain
