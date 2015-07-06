From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH 2/6] ASoC: tas571x: Replace direct
 snd_soc_codec dapm field access
Date: Mon, 6 Jul 2015 07:11:10 -0700
Message-ID: <CAJzqFtbvqw6L0cG81GdmuP8Q1QgUh_6y4woZkFygKkRxS8fPXA@mail.gmail.com>
References: <1436189891-15343-1-git-send-email-lars@metafoo.de>
 <1436189891-15343-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FAB0260616
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 16:11:32 +0200 (CEST)
Received: by wgjx7 with SMTP id x7so141373851wgj.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 07:11:32 -0700 (PDT)
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com.
 [209.85.212.177])
 by mx.google.com with ESMTPSA id lq9sm19662229wjb.35.2015.07.06.07.11.30
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2015 07:11:31 -0700 (PDT)
Received: by wiwl6 with SMTP id l6so286079668wiw.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 07:11:30 -0700 (PDT)
In-Reply-To: <1436189891-15343-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Yang A Fang <yang.a.fang@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 6, 2015 at 6:38 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level().
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/tas571x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
> index 85bcc37..39307ad 100644
> --- a/sound/soc/codecs/tas571x.c
> +++ b/sound/soc/codecs/tas571x.c
> @@ -179,7 +179,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
>         case SND_SOC_BIAS_PREPARE:
>                 break;
>         case SND_SOC_BIAS_STANDBY:
> -               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +               if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
>                         if (!IS_ERR(priv->mclk)) {
>                                 ret = clk_prepare_enable(priv->mclk);
>                                 if (ret) {
> --
> 2.1.4
>

Acked-by: Kevin Cernekee <cernekee@chromium.org>
