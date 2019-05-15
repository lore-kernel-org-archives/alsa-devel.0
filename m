From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] ASoC: sun4i-codec: fix first delay on Speaker
Date: Wed, 15 May 2019 15:58:13 +0200
Message-ID: <20190515135813.5y72f2h526yjkncy@flea>
References: <1557925120-31498-1-git-send-email-georgii.staroselskii@emlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1557925120-31498-1-git-send-email-georgii.staroselskii@emlid.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgii Staroselskii <georgii.staroselskii@emlid.com>
Cc: alsa-devel@alsa-project.org, dannym@scratchpost.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 15, 2019 at 03:58:40PM +0300, Georgii Staroselskii wrote:
> This commit fixes the same issue as bf14da7 but for another codepath.
> The issue can be triggered by having Speaker in codec audio routing.

Mentionning what "the issue" is in the commit log would be great.

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
> index 15d08e3..e0099519 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1329,6 +1329,15 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
>  	gpiod_set_value_cansleep(scodec->gpio_pa,
>  				 !!SND_SOC_DAPM_EVENT_ON(event));
>
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		/*
> +		 * Need a delay to have the amplifier up. 700ms seems the best
> +		 * compromise between the time to let the amplifier up and the
> +		 * time not to feel this delay while playing a sound.
> +		 */
> +		msleep(700);
> +	}
> +

Since this is an external amplifier, I guess they would have different
warm-up time depending on the exact part being used?

If so, we should use a property and set it on a per-board basis.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
