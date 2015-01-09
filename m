From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the
	HDMI transmitter
Date: Fri, 09 Jan 2015 17:39:08 +0000
Message-ID: <54B0123C.9070800@arm.com>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0CF261583
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 18:39:10 +0100 (CET)
In-Reply-To: <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jyri Sarha <jsarha@ti.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/07/15 10:51, Jean-Francois Moine wrote:
> This patch adds a CODEC to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF inputs.
> It maintains the audio format and rate constraints according
> to the HDMI device parameters (EDID) and sets dynamically the input
> ports in the TDA998x I2C driver on start/stop audio streaming.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

[snip]

> +static int tda998x_codec_startup(struct snd_pcm_substream *substream,
> +                                struct snd_soc_dai *dai)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct snd_pcm_hw_constraint_list *rate_constraints;
> +       u8 *sad;                /* Short Audio Descriptor (3 bytes) */

[...]

> +       snd_pcm_hw_constraint_minmax(runtime,
> +                               SNDRV_PCM_HW_PARAM_CHANNELS,
> +                               1, sad[SAD_MX_CHAN_I]);

In the light of our discussions elsewhere [1], shouldn't this
be constrained by the number of hardware channels that the TDA998x
supports too?  That is, the maximum number of channels should
be the lesser of sd[SAD_MX_CHAN_I] and number_of_I2S channels 
(or S/PDIF channels if so configured).

	Andrew

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086090.html
