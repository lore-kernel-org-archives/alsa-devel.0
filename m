From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH 2/8] ASoC: alc5632: Use params_width()
 rather than memory format
Date: Thu, 9 Jan 2014 06:55:17 +0200
Message-ID: <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
 <1389210723-16535-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f47.google.com (mail-vb0-f47.google.com
 [209.85.212.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C1EE2651DA
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 05:55:38 +0100 (CET)
Received: by mail-vb0-f47.google.com with SMTP id m10so1808497vbh.6
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2014 20:55:37 -0800 (PST)
In-Reply-To: <1389210723-16535-2-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Jan 8, 2014 at 9:51 PM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/alc5632.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
> index 19e9f222d09c..fb001c56cf8d 100644
> --- a/sound/soc/codecs/alc5632.c
> +++ b/sound/soc/codecs/alc5632.c
> @@ -869,14 +869,14 @@ static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
>         iface &= ~ALC5632_DAI_I2S_DL_MASK;
>
>         /* bit size */
> -       switch (params_format(params)) {
> -       case SNDRV_PCM_FORMAT_S16_LE:
> +       switch (params_width(params)) {
> +       case 16:
May be the better way will be to use define here and not hard coded value?

>                 iface |= ALC5632_DAI_I2S_DL_16;
>                 break;
> -       case SNDRV_PCM_FORMAT_S20_3LE:
> +       case 20:
>                 iface |= ALC5632_DAI_I2S_DL_20;
>                 break;
> -       case SNDRV_PCM_FORMAT_S24_LE:
> +       case 24:
>                 iface |= ALC5632_DAI_I2S_DL_24;
>                 break;
>         default:
> --
> 1.8.5.2
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
