From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 14:55:22 +0000
Message-ID: <20190308145522.jobjk4bq2ccmd6tj@shell.armlinux.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308142943.GA17581@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70DC4F806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 15:55:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190308142943.GA17581@workstation>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2019 at 11:29:46PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Fri, Mar 08, 2019 at 12:59:16PM +0000, Russell King - ARM Linux admin wrote:
> > > In your case:
> > > 
> > > +---+            +-----+
> > > |CPU| <- wire -> |CODEC|
> > > |DAI|            | DAI |
> > > +---+            +-----+
> > > 
> > > So that:
> > > 
> > > CPU-DAI = fsl_ssi
> > > CODEC-DAI = tda998x
> > > wire = I2S
> > > 
> > > In I2S:
> > >  - SCK-line = serial clock
> > >  - WS-line = word select
> > >  - SD-line = serial data 
> > > 
> > > In general I2S communication:
> > >  - 2 samples are transferred in a phase of WS
> > > 
> > > In my opinion:
> > >  - 'the number of clocks per frame on the wire' (=you need)
> > >    = the number of phases of SCK per phase of WS
> > > 
> > > In expectation of ALSA PCM interface for hardware for usual device:
> > >  - half number of phases of SCK per phase of WC
> > >    = physical_width of sample
> > >    = bytes per sample
> > 
> > They are not the same thing.
> > 
> > Let's take SNDRV_PCM_FORMAT_S16_LE.  The in-memory layout of this format
> > is two 16-bit samples next to each other in a single 32-bit word.  Their
> > width is 16, their physical_width is 16, and bytes per sample is 2.
> > 
> > A CPU DAI can do one of two things:
> > 
> > 1) it can generate exactly 16 SCK clock cycles per sample before WS
> >    changes state, leading to a total of 32 SCK clock cycles per
> >    frame.
> > 
> > 2) it can generate more than 16 SCK clock cycles per sample.
> >
> > Both are entirely legal and permissable under the I2S specification.
> > Both look the same in memory.
> > 
> > The ALSA format specification (SNDRV_PCM_FORMAT_*) does not specify
> > which of these two is used on the wire - it only specifies the in-
> > memory format.
> > 
> > If it were to specify the on-wire format, then we'd have to multiply
> > the number of in-memory formats by the number of on-wire formats.
> > These are (at least): AC'97, SPDIF, I2S(Philips), I2S(Left justified),
> > I2S(Right justified), two different DSP formats, and PDM.  Then for
> > at least the tree I2S modes, there are the number of SCK clocks per
> > sample which can be anything from the number of bits in the sample
> > up to an undefined limit.
> > 
> > What this means is that multiplying the number of in-memory formats
> > by the number of unboundable bus-specific formats leads to an
> > unboundable quantity of formats.
> > 
> > This is why ASoC has the ability to set the bclk (bit clock, SCK)
> > to sample rate ratio - in other words, the number of clocks to
> > completely transmit the samples for the number of channels on the
> > link - bit clock rate = sample rate * bclk_ratio.
> 
> Hm. In ALSA PCM core, the combination of 'rate_num' and 'rate_den' is
> another representation of sampling rate[1], and drivers can have
> constraints and rules for these two parameters of runtime of PCM
> substream. Once core functionalities and drivers in ALSA SoC part have
> common specifications about actual value of these two parameters, the
> issue could be solved, in my opinion.
> (But I need time to consider it further in this weekend...)

rate_num and rate_den describe the sampling rate in fractional
notation, as described by the ALSA tracepoint documentation:

``rate_num``
        Read-only. This value represents numerator of sampling rate in fraction
        notation. Basically, when a parameter of SNDRV_PCM_HW_PARAM_RATE was
        decided as a single value, this value is also calculated according to
        it. Else, zero. But this behaviour depends on implementations in driver
        side.
``rate_den``
        Read-only. This value represents denominator of sampling rate in
        fraction notation. Basically, when a parameter of
        SNDRV_PCM_HW_PARAM_RATE was decided as a single value, this value is
        also calculated according to it. Else, zero. But this behaviour depends
        on implementations in driver side.

and is also described in the header files as:

        unsigned int rate_num;          /* R: rate numerator */
        unsigned int rate_den;          /* R: rate denominator */

params_rate() returns the rate from the interval negotiated with
userspace, and is described in the ALSA header files as:

#define SNDRV_PCM_HW_PARAM_RATE         11      /* Approx rate */

This only describes the sample rate, it does not describe anything to do
with bit clocks or their ratio to the sample rate.

> However, I don't have clear view of your case 2) yet. In that case,
> how drivers calculate return value in 'struct snd_pcm_ops.pointer'
> callback?  It should be frame count, but WS seems not to be available
> for 16 bit sample because the number of SCK clock cycles per sample is
> larger than 16.
> (If WS clock works as I expected, SCK clock cycles per sample include
> expression of padding bits added to 16 bit sample.)

snd_pcm_ops.pointer has nothing at all to do with what is happening on
the I2S bus.  It has nothing to do with the WS nor SCK.  Please see the
documentation in Documentation/sound/kernel-api, which states:

  pointer callback
  ~~~~~~~~~~~~~~~

  ::

    static snd_pcm_uframes_t snd_xxx_pointer(struct snd_pcm_substream *substream)

  This callback is called when the PCM middle layer inquires the current
  hardware position on the buffer. The position must be returned in
  frames, ranging from 0 to ``buffer_size - 1``.

  This is called usually from the buffer-update routine in the pcm
  middle layer, which is invoked when :c:func:`snd_pcm_period_elapsed()`
  is called in the interrupt routine. Then the pcm middle layer updates
  the position and calculates the available space, and wakes up the
  sleeping poll threads, etc.

This is the position within the memory buffer in frames (hence the
return type) where the hardware has read or written.  It does *not*
take account of any FIFO that may be between the DMA accessing the
memory buffer and the samples appearing on the wire to the codec.
ALSA models that effective delay using the "fifo_size" member of
struct snd_pcm_hardware.

ALSA defines frames as (also from the documentation):

  In the ALSA world, ``1 frame = channels \* samples-size``.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
