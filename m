From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 23:29:46 +0900
Message-ID: <20190308142943.GA17581@workstation>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20800F80724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 15:29:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Mar 08, 2019 at 12:59:16PM +0000, Russell King - ARM Linux admin wrote:
> > In your case:
> > 
> > +---+            +-----+
> > |CPU| <- wire -> |CODEC|
> > |DAI|            | DAI |
> > +---+            +-----+
> > 
> > So that:
> > 
> > CPU-DAI = fsl_ssi
> > CODEC-DAI = tda998x
> > wire = I2S
> > 
> > In I2S:
> >  - SCK-line = serial clock
> >  - WS-line = word select
> >  - SD-line = serial data 
> > 
> > In general I2S communication:
> >  - 2 samples are transferred in a phase of WS
> > 
> > In my opinion:
> >  - 'the number of clocks per frame on the wire' (=you need)
> >    = the number of phases of SCK per phase of WS
> > 
> > In expectation of ALSA PCM interface for hardware for usual device:
> >  - half number of phases of SCK per phase of WC
> >    = physical_width of sample
> >    = bytes per sample
> 
> They are not the same thing.
> 
> Let's take SNDRV_PCM_FORMAT_S16_LE.  The in-memory layout of this format
> is two 16-bit samples next to each other in a single 32-bit word.  Their
> width is 16, their physical_width is 16, and bytes per sample is 2.
> 
> A CPU DAI can do one of two things:
> 
> 1) it can generate exactly 16 SCK clock cycles per sample before WS
>    changes state, leading to a total of 32 SCK clock cycles per
>    frame.
> 
> 2) it can generate more than 16 SCK clock cycles per sample.
>
> Both are entirely legal and permissable under the I2S specification.
> Both look the same in memory.
> 
> The ALSA format specification (SNDRV_PCM_FORMAT_*) does not specify
> which of these two is used on the wire - it only specifies the in-
> memory format.
> 
> If it were to specify the on-wire format, then we'd have to multiply
> the number of in-memory formats by the number of on-wire formats.
> These are (at least): AC'97, SPDIF, I2S(Philips), I2S(Left justified),
> I2S(Right justified), two different DSP formats, and PDM.  Then for
> at least the tree I2S modes, there are the number of SCK clocks per
> sample which can be anything from the number of bits in the sample
> up to an undefined limit.
> 
> What this means is that multiplying the number of in-memory formats
> by the number of unboundable bus-specific formats leads to an
> unboundable quantity of formats.
> 
> This is why ASoC has the ability to set the bclk (bit clock, SCK)
> to sample rate ratio - in other words, the number of clocks to
> completely transmit the samples for the number of channels on the
> link - bit clock rate = sample rate * bclk_ratio.

Hm. In ALSA PCM core, the combination of 'rate_num' and 'rate_den' is
another representation of sampling rate[1], and drivers can have
constraints and rules for these two parameters of runtime of PCM
substream. Once core functionalities and drivers in ALSA SoC part have
common specifications about actual value of these two parameters, the
issue could be solved, in my opinion.
(But I need time to consider it further in this weekend...)


However, I don't have clear view of your case 2) yet. In that case,
how drivers calculate return value in 'struct snd_pcm_ops.pointer'
callback? It should be frame count, but WS seems not to be available
for 16 bit sample because the number of SCK clock cycles per sample is
larger than 16.
(If WS clock works as I expected, SCK clock cycles per sample include
expression of padding bits added to 16 bit sample.)


[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/sound/pcm.h#n380

Thanks

Takashi Sakamoto
