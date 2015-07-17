From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] ASoC: rt5645: remove unused variable
Date: Fri, 17 Jul 2015 16:07:36 +0800
Message-ID: <CANMq1KCpt-eME0d7qZ0pWh+xwsJy-B9ZSRSZjLSYpoEmA+MNxg@mail.gmail.com>
References: <1437117818-25972-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 41E3526067B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 10:07:37 +0200 (CEST)
Received: by obnw1 with SMTP id w1so61726654obn.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 01:07:36 -0700 (PDT)
In-Reply-To: <1437117818-25972-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2015 at 3:23 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> We were getting a build warning about unused variable. This variable was
> a leftover from:
> a4e3c5fa955c ("ASoC: rt5645: Simplify rt5645_enable_push_button_irq")

Yes, I already sent a patch to fix it:
https://patchwork.kernel.org/patch/6812261/ .

Thanks.

> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  sound/soc/codecs/rt5645.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index d24c979..ff091d6 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -2763,7 +2763,6 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
>         bool enable)
>  {
>         struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> -       struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
>
>         if (enable) {
>                 snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> --
> 1.8.1.2
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
