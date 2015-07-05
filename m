From: Laurence Darby <ldarby@tuffmail.com>
Subject: Re: [PATCH] ALSA: oxygen: Fix S/PDIF muting
Date: Sun, 5 Jul 2015 19:56:50 +0100
Message-ID: <20150705195650.96c58d265a2c0118ab48bd2e@tuffmail.com>
References: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>
 <5590408A.6030100@ladisch.de>
 <20150629210159.b8c7f6baa83eef02555686f1@tuffmail.com>
 <559264D8.9030804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A74260462
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 20:56:55 +0200 (CEST)
In-Reply-To: <559264D8.9030804@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Jun 2015 11:43:52 +0200 Clemens Ladisch wrote:

> Laurence Darby wrote:
> > On Sun, 28 Jun 2015 20:44:26 +0200 Clemens Ladisch wrote:
> >> Laurence Darby wrote:
> >>> The S/PDIF output was muted whenever audio wasn't playing which
> >>> resulted in a clicking noise from the DAC when resuming
> >>
> >> It indeed appears that there are too many oxygen_clear_bits32()
> >> calls. However, I don't trust the hardware; please confirm that
> >> the S/PDIF output, without an active stream, play zeros and not
> >> the last sample.
> >
> > Well, to test that I created a wav file of about a quarter of a sine
> > wave (at about -15dB), consisting of 5520 samples, so it matched the
> > alsa buffer size, otherwise aplay pads the buffer with silence.
> >
> > The chip does continue playing the last sample value, then the
> > speakers pop later when something else is played.  Is this really
> > an issue though? I just found my intel hda chip behaves the same
> > way, and that chip's driver leaves it un-muted.
> 
> The current problem is that the output gets disabled, then later, when
> the driver is about to start the new stream, it enables the output
> again (which outputs the last old sample), and then the new stream
> starts (usually with zero samples).  Going from disabled(=zero) to
> old-sample to new-sample(=zero) is an extra pop.
> 
> In any case, putting a DC offset on the speakers is a bad idea.
> 
> > If this is still going to prevent fixing the popping noise for the
> > oxygen chip, what about writing a single 0x00 sample to it in the
> > driver instead of muting it?
> 
> This is likely to work (but the zero sample has to go through DMA).

Ok, I eventually got this to work, with this in oxygen_spdif_hw_free():

	memset (runtime->dma_area, 0, runtime->dma_bytes);
	oxygen_trigger(substream,SNDRV_PCM_TRIGGER_START);
	msleep (1);
	oxygen_trigger(substream,SNDRV_PCM_TRIGGER_STOP);
	
instead of disabling OXYGEN_SPDIF_OUT_ENABLE.  The 1ms sleep is
necessary otherwise it intermittently still leaves DC on the output.

If I create a proper patch for that (it should probably use
snd_pcm_format_set_silence() instead of memset) would that be
acceptable? 

> At the moment, oxygen_hw_free() pokes at the OXYGEN_DMA_FLUSH
> register. Please check if there is an improvement if it also pokes at
> the OXYGEN_DMA_RESET register.

Unfortunately not.  I did some archeology and found your CVS commit
from 2007: http://sourceforge.net/p/alsa/mailman/message/15439076/
which has this code:

+	if (chip->CMI8788IC_revision == CMI8788IC_Revision1)
+		DMARestRegister = PCI_DMA_Reset;
+	if (chip->CMI8788IC_revision == CMI8788IC_Revision2)
+		DMARestRegister = PCI_DMA_FLUSH;
...
+		/* Reset DMA Channel*/
+		reset = snd_cmipci_read_b(chip, DMARestRegister);
+		reset |= cmi_subs->DMA_chan_reset; /* set bit */

So I understand why you asked if the RESET works :) 

Regards,
Laurence
