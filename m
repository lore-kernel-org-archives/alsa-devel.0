From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 12:59:16 +0000
Message-ID: <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F6C8F80724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 13:59:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190308041056.GA1172@workstation>
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

On Fri, Mar 08, 2019 at 01:10:57PM +0900, Takashi Sakamoto wrote:
> On Tue, Mar 05, 2019 at 09:23:46AM -0500, Sven Van Asbroeck wrote:
> > The original problem was that the fsl_ssi did not appear to work with the
> > tda998x hdmi codec. This codec seems to be 'unique' in the sense that it
> > needs to know the number of clocks per frame on the wire, i.e. the bclk_ratio,
> > which no-one in alsa is providing or using at the moment.
> > 
> > I first made the error of conflating the physical width and the bclk_ratio,
> > and posted this patch - Russell King quickly pointed out my error:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145916.html
> > 
> > This then led to the following discussions:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145985
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145947
> > 
> > Most of the discussion is about a mechanism to convey bclk_ratio from
> > the frame master
> > to the tda998x. We don't yet seem to have a consensus on how to do this best.
> > 
> > My rfc patch was only intended to provoke discussion, and to allow
> > people to experiment
> > with a flawed solution that would allow the alsa core to negotiate
> > bclk_ratio between
> > components. The uapi change is a serious flaw. bclk_ratio negotiation should be
> > invisible to userspace. But I cannot see a way to accomplish this.
> 
> In your case:
> 
> +---+            +-----+
> |CPU| <- wire -> |CODEC|
> |DAI|            | DAI |
> +---+            +-----+
> 
> So that:
> 
> CPU-DAI = fsl_ssi
> CODEC-DAI = tda998x
> wire = I2S
> 
> In I2S:
>  - SCK-line = serial clock
>  - WS-line = word select
>  - SD-line = serial data 
> 
> In general I2S communication:
>  - 2 samples are transferred in a phase of WS
> 
> In my opinion:
>  - 'the number of clocks per frame on the wire' (=you need)
>    = the number of phases of SCK per phase of WS
> 
> In expectation of ALSA PCM interface for hardware for usual device:
>  - half number of phases of SCK per phase of WC
>    = physical_width of sample
>    = bytes per sample

They are not the same thing.

Let's take SNDRV_PCM_FORMAT_S16_LE.  The in-memory layout of this format
is two 16-bit samples next to each other in a single 32-bit word.  Their
width is 16, their physical_width is 16, and bytes per sample is 2.

A CPU DAI can do one of two things:

1) it can generate exactly 16 SCK clock cycles per sample before WS
   changes state, leading to a total of 32 SCK clock cycles per
   frame.

2) it can generate more than 16 SCK clock cycles per sample.

Both are entirely legal and permissable under the I2S specification.
Both look the same in memory.

The ALSA format specification (SNDRV_PCM_FORMAT_*) does not specify
which of these two is used on the wire - it only specifies the in-
memory format.

If it were to specify the on-wire format, then we'd have to multiply
the number of in-memory formats by the number of on-wire formats.
These are (at least): AC'97, SPDIF, I2S(Philips), I2S(Left justified),
I2S(Right justified), two different DSP formats, and PDM.  Then for
at least the tree I2S modes, there are the number of SCK clocks per
sample which can be anything from the number of bits in the sample
up to an undefined limit.

What this means is that multiplying the number of in-memory formats
by the number of unboundable bus-specific formats leads to an
unboundable quantity of formats.

This is why ASoC has the ability to set the bclk (bit clock, SCK)
to sample rate ratio - in other words, the number of clocks to
completely transmit the samples for the number of channels on the
link - bit clock rate = sample rate * bclk_ratio.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
