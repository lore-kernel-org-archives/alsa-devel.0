From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: DA7219: Fix failure in hw_params by
 not letting set_rate error out
Date: Mon, 22 Apr 2019 15:39:13 +0800
Message-ID: <CAFv8NwKZskTeyaUQWevydfxZf0=nf+Z4kBOkYynTfiOMOq-LDA@mail.gmail.com>
References: <20190422061334.4243-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422061334.4243-1-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson.Opensource@diasemi.com" <Adam.Thomson.Opensource@diasemi.com>, yuhsuan@chromium.org, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi Akshu,


On Mon, Apr 22, 2019 at 2:15 PM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
> We need to set minimum bclk 64x of wclk as this is hw constraint in one
> of the component used.
> Since, clk_set_rate and clk is enabled in machine driver the
> clk_set_rate in hw_params of da7219 fails and errors out and when it
> tries to override the value.
>
> In cases like these not only clk_set_rate of da7219 codec should fail
> and not override the value but also should not error out.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/codecs/da7219.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 5f5fa3416af3..a041dbf442af 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1621,13 +1621,7 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
>
>                 if (bclk) {
>                         bclk_rate = frame_size * sr;
> -                       ret = clk_set_rate(bclk, bclk_rate);
> -                       if (ret) {
> -                               dev_err(component->dev,
> -                                       "Failed to set BCLK rate %lu: %d\n",
> -                                       bclk_rate, ret);
> -                               return ret;
> -                       }
> +                       clk_set_rate(bclk, bclk_rate);

I think this might mask the real issue when setting rate fails.
A more fundamental problem might be what are the acceptable ratios
between bclk and wclk.

>From existing code of da7219 I see there are only two choices of
frame_size: 32 or 64.

In da7219_hw_params:
...
if (da7219->master && !da7219->tdm_en) {
  if ((word_len * DA7219_DAI_CH_NUM_MAX) <= 32)
     frame_size = 32;
  else
     frame_size = 64;

And in https://lkml.org/lkml/2019/4/17/322
the choice from machine driver is 64 or higher.

In cz_da7219_params:
 ...
 if (bclk < (wclk * 64))
  bclk = wclk * 64;
 return da7219_clk_enable(substream, wclk, bclk);

I don't know what is the best solution to avoid this conflict.
Maybe just set a fixed ratio from device property that can best work
for the combination of codecs on the machine?





>                 } else {
>                         ret = da7219_set_bclks_per_wclk(component, frame_size);
>                         if (ret) {
> --
> 2.17.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
