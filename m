From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2] ASoC: sun4i-codec: fix first delay on Speaker
Date: Wed, 29 May 2019 10:34:25 +0800
Message-ID: <CAGb2v64osE5yVdpCxSRfpkaq2TqeUUiLUbr3wZWW1rawuqxW-Q@mail.gmail.com>
References: <1559040459-16488-1-git-send-email-georgii.staroselskii@emlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1559040459-16488-1-git-send-email-georgii.staroselskii@emlid.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgii Staroselskii <georgii.staroselskii@emlid.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Danny Milosavljevic <dannym@scratchpost.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 6:48 PM Georgii Staroselskii
<georgii.staroselskii@emlid.com> wrote:
>
> Allwinner DAC seems to have a delay in the Speaker audio routing. When
> playing a sound for the first time, the sound gets chopped. On a second
> play the sound is played correctly. After some time (~5s) the issue gets
> back.

FYI that is DAPM powering down the amp. You'll here a light pop when that
happens.

> This commit seems to be fixing the same issue as bf14da7 but
> for another codepath.
>
> This is the DTS that was used to debug the problem.
>
> &codec {
>         allwinner,pa-gpios = <&r_pio 0 11 GPIO_ACTIVE_HIGH>; /* PL11 */
>         allwinner,audio-routing =
>                 "Speaker", "LINEOUT";
>
>         status = "okay";
> }
>
> Signed-off-by: Georgii Staroselskii <georgii.staroselskii@emlid.com>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index f2deffe..9e1f00e 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1320,6 +1320,15 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
>         gpiod_set_value_cansleep(scodec->gpio_pa,
>                                  !!SND_SOC_DAPM_EVENT_ON(event));
>
> +       if (SND_SOC_DAPM_EVENT_ON(event)) {
> +               /*
> +                * Need a delay to wait for DAC to push the data. 700ms seems
> +                * to be the best compromise not to feel this delay while
> +                * playing a sound.

It is not that the DAC is not pushing data, it's just the internal headphone
amp needs some time to charge up. So this patch basically adds a delay before
sound is actually pushed out, thereby preventing any sound from being silently
dropped. It doesn't help with the pop on power down though, and the latency
might not be that great.

I wonder if we shouldn't just keep the amplifier section powered up
all the time.
Also it seems not very many codec drivers go all out with DAPM.

Mark, any suggestions on the matter?

ChenYu


> +                */
> +               msleep(700);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
