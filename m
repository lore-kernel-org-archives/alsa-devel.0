From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v2] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 08 Jul 2014 10:17:58 +0100
Message-ID: <53BBB746.1000201@arm.com>
References: <20140704091733.10258cfe@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B1FF626072A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 11:18:00 +0200 (CEST)
In-Reply-To: <20140704091733.10258cfe@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 07/04/14 08:17, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF input and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

[snip]

> +++ b/drivers/gpu/drm/i2c/tda998x_codec.c

[snip]

> +static int tda_startup(struct snd_pcm_substream *substream,
> +                       struct snd_soc_dai *dai)
> +{
> +       struct tda998x_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
> +       u8 *eld = priv->eld;
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       u8 *sad;
> +       int sad_count;
> +       unsigned eld_ver, mnl, rate_mask;
> +       unsigned max_channels, fmt;
> +       u64 formats;
> +       struct snd_pcm_hw_constraint_list *rate_constraints =
> +                       &priv->rate_constraints;
> +       static const u32 hdmi_rates[] = {
> +               32000, 44100, 48000, 88200, 9600, 176400, 192000
> +       };
> +

Shouldn't this be 96000, not 9600?  Assuming that the table is ordered in terms of increasing frequencies.

    Andrew
