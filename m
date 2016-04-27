From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Add support for packed transfers
Date: Wed, 27 Apr 2016 16:33:12 +0200
Message-ID: <61FCB16D-76ED-4862-8D39-A4ACCDBA0038@martin.sperl.org>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461763613-28714-1-git-send-email-hias@horus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> On 27.04.2016, at 15:26, Matthias Reichl <hias@horus.com> wrote:
> 
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

Tested-by: Martin Sperl <kernel@martin.sperl.org>
