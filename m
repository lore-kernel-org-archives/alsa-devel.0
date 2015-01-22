From: Zidan Wang <b50113@freescale.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Date: Thu, 22 Jan 2015 12:55:35 +0800
Message-ID: <20150122045515.GA3467@b50113>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
 <20150121180801.GA3361@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150121180801.GA3361@Alpha>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Zidan Wang <zidan.wang@freescale.com>, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2015 at 10:08:03AM -0800, Nicolin Chen wrote:
> On Tue, Jan 20, 2015 at 08:21:19PM +0800, Zidan Wang wrote:
> > @@ -369,10 +380,25 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> >  	u32 word_width = snd_pcm_format_width(params_format(params));
> >  	u32 val_cr4 = 0, val_cr5 = 0;
> >  	int ret;
> > +	u32 bclk;
> > +
> > +	if (channels == 1)
> > +		channels = 2;
> > +
> > +	if (!sai->slots || sai->slots % channels)
> > +		sai->slots = channels;
> > +
> > +	sai->slots = sai->slots / channels;
> > +
> > +	if (sai->slot_width < word_width || sai->is_dsp_mode)
> > +		sai->slot_width = word_width;
> 
> Could you pls explain a bit what's this overriding for?
> Or it might be better to put into a comment.
>
In machine driver, we should use snd_soc_dai_set_tdm_slot to set slots
and slot width. In my opinion, slots in machine driver means the slot
number of all channels. But in sai driver, the slots means the slot number
of one channel. So snd_soc_calc_bclk use fs*sample_size*channels*tdm_slots
to caculate bclk.

So i use "sai->slots = sai->slots / channels" to calculate slots per channel. 
If we missing set slots, use channel number to set slots and get one slot per 
channel. If we missing set slot width, set default slot width to word width. 

If slot width is 32 and wrod width is 16, for 2 channels and one slot
per channel, it will be 64 bit clock for one frame.

val_cr5 |= FSL_SAI_CR5_WNW(sai->slot_width).
val_cr5 |= FSL_SAI_CR5_W0W(sai->slot_width);

So sai word length is 32, it will trans 32 bit data per channel. But dma only
trans 16 bit data to fifo, the continues 16 bit will be 0. So for 16 bit data 
formate, it will just one channel has data. When it is dsp mode, let slot
width equal to word width can fix the issue.


> Nicolin
