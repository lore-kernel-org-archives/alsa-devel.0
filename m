From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/6] ASoC: dwc: Ensure FIFOs are flushed
 to prevent channel swap
Date: Fri, 12 Dec 2014 10:37:34 +0100
Message-ID: <548AB75E.9030302@metafoo.de>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
 <a3b4a11dfe1688eea07471c6cfa27676cc9a58a8.1418372910.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-075.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1C326535C
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 10:37:35 +0100 (CET)
In-Reply-To: <a3b4a11dfe1688eea07471c6cfa27676cc9a58a8.1418372910.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <andrew.jackson@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 12/12/2014 10:25 AM, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>
> If the FIFOs aren't flushed, the left/right channels may be swapped:
> this may occur if the FIFOs are not empty when the streams start.
>
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> ---
>   sound/soc/dwc/designware_i2s.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> index ef771ea..b9d6a25 100644
> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
> @@ -228,12 +228,14 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
>   	i2s_disable_channels(dev, substream->stream);
>
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		i2s_write_reg(dev->i2s_base, TXFFR, 1);
>   		i2s_write_reg(dev->i2s_base, TCR(ch_reg), xfer_resolution);
>   		i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
>   		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>   		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
>   		i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
>   	} else {
> +		i2s_write_reg(dev->i2s_base, RXFFR, 1);
>   		i2s_write_reg(dev->i2s_base, RCR(ch_reg), xfer_resolution);
>   		i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
>   		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>

This should probably go into the prepare callback. prepare is for example 
also called when recovering from a underrun/overrun. Whereas hwparams is 
only called during initial setup of the stream.
