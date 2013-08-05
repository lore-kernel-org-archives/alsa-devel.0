From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: wm8994: Fix class W controls
Date: Mon, 05 Aug 2013 22:12:51 +0200
Message-ID: <52000743.7060700@metafoo.de>
References: <1375732994-19029-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 6458E2651BE
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 22:12:36 +0200 (CEST)
In-Reply-To: <1375732994-19029-1-git-send-email-broonie@kernel.org>
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

On 08/05/2013 10:03 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Commit 6e0650 (ASoC: wm8994: Use SOC_SINGLE_EXT() instead of open-coding
> it) went too far and converted a DAPM control to use SOC_SINGLE_EXT()
> which crashes.  Revert that portion of the patch.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   sound/soc/codecs/wm8994.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index d76b056..f32998a 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -1432,8 +1432,10 @@ SOC_DAPM_SINGLE("AIF1.1 Switch", WM8994_DAC2_RIGHT_MIXER_ROUTING,
>   };
>
>   #define WM8994_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
> -	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
> -		snd_soc_get_volsw, wm8994_put_class_w)
> +{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
> +	.info = snd_soc_info_volsw, \
> +	.get = snd_soc_dapm_get_volsw, .put = wm8994_put_class_w, \
> +	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }

Hm, right. But I think it should be enough to just replace the 
snd_soc_get_volsw with snd_soc_dapm_get_volsw

- Lars
