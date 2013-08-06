From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: wm8994: Fix class W controls
Date: Tue, 06 Aug 2013 10:40:56 +0200
Message-ID: <5200B698.7080908@metafoo.de>
References: <1375742107-7583-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id DF28C2616C5
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 10:40:40 +0200 (CEST)
In-Reply-To: <1375742107-7583-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 12:35 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Commit 6e0650 (ASoC: wm8994: Use SOC_SINGLE_EXT() instead of open-coding
> it) went too far and converted a DAPM control to use SOC_SINGLE_EXT()
> which crashes.  Revert that portion of the patch.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   sound/soc/codecs/wm8994.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index d76b056..29ad480 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -1432,8 +1432,8 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
>   };
>
>   #define WM8994_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
> -	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
> -		snd_soc_get_volsw, wm8994_put_class_w)
> +	SOC_SINGLE_EXT(xname, reg, shift, 1, 0, \

The patch changed 'max' to 1 and 'invert' to 0.

> +		snd_soc_dapm_get_volsw, wm8994_put_class_w)
>
>   static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
>   			      struct snd_ctl_elem_value *ucontrol)
>
