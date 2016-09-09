From: Richard Leitner <dev@g0hl1n.net>
Subject: Re: [PATCH v2] ASoC: sgtl5000: add headphone and LINEOUT mute
 controls
Date: Fri, 9 Sep 2016 09:46:45 +0200
Message-ID: <20160909094645.64b7744a@g0hl1n.net>
References: <20160830202501.19323-1-dev@g0hl1n.net>
        <20160831092631.013c8170@g0hl1n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831092631.013c8170@g0hl1n.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: eric@nelint.com, clemens.gruber@pqgruber.com, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com, Richard Leitner <dev@g0hl1n.net>
List-Id: alsa-devel@alsa-project.org

Hi,
any comments, updates or ideas for improvement on that patch?

regards,
Richard

On Wed, 31 Aug 2016 09:26:31 +0200
Richard Leitner <dev@g0hl1n.net> wrote:

> These controls mute/unmute the LINEOUT and headphone outputs of SGTL5000
> using its CHIP_ANA_CTRL register.
> 
> Signed-off-by: Richard Leitner <dev@g0hl1n.net>
> ---
> CHANGES v2: fix invert value for both controls
> 	(sorry I've missed that in my initial tests!)
> ---
>  sound/soc/codecs/sgtl5000.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 527b759..a6af65d 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -411,6 +411,8 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
>  			0, 8,
>  			0x7f, 1,
>  			headphone_volume),
> +	SOC_SINGLE("Headphone Playback Switch", SGTL5000_CHIP_ANA_CTRL,
> +			4, 1, 1),
>  	SOC_SINGLE("Headphone Playback ZC Switch", SGTL5000_CHIP_ANA_CTRL,
>  			5, 1, 0),
>  
> @@ -423,6 +425,7 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
>  			SGTL5000_LINE_OUT_VOL_RIGHT_SHIFT,
>  			0x1f, 1,
>  			lineout_volume),
> +	SOC_SINGLE("Lineout Playback Switch", SGTL5000_CHIP_ANA_CTRL, 8, 1, 1),
>  };
>  
>  /* mute the codec used by alsa core */
