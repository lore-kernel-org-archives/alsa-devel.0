From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Add support for packed transfers
Date: Wed, 27 Apr 2016 16:14:24 +0200
Message-ID: <5720C940.5010809@metafoo.de>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461763613-28714-1-git-send-email-hias@horus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: kernel@martin.sperl.org
List-Id: alsa-devel@alsa-project.org

On 04/27/2016 03:26 PM, Matthias Reichl wrote:
> dmaengine_pcm currently only supports setups where FIFO reads/writes
> correspond to exactly one sample, eg 16-bit sample data is transferred
> via 16-bit FIFO accesses, 32-bit data via 32-bit accesses.
> 
> This patch adds support for setups with fixed width FIFOs where
> multiple samples are packed into a larger word.
> 
> For example setups with a 32-bit wide FIFO register that expect
> 16-bit sample transfers to be done with the left+right sample data
> packed into a 32-bit word.
> 
> Support for packed transfers is controlled via the
> SND_DMAENGINE_PCM_DAI_FLAG_PACK flag in snd_dmaengine_dai_dma_data.flags
> 
> If this flag is set dmaengine_pcm doesn't put any restriction on the
> supported formats and sets the DMA transfer width to undefined.
> 
> This means control over the constraints is now transferred to the DAI
> driver and it's responsible to provide proper configuration and
> check for possible corner cases that aren't handled by the ALSA core.
> 
> Signed-off-by: Matthias Reichl <hias@horus.com>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
