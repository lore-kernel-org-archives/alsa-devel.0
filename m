From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 11/11] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Tue, 7 Jul 2009 10:31:32 +0100
Message-ID: <20090707093132.GB14393@rakim.wolfsonmicro.main>
References: <1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>
	<20090705130352.GE5334@sirena.org.uk>
	<4A52A081.9070003@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8138A246F7
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 11:31:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A52A081.9070003@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 06:10:25PM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > that causes issues in situations like TDM since there
> > can be transfers going on independantly of the CPU which may need the
> > clocks running.  Not everything will be able to gate the clocks, too.

> What is TDM? time division multiplexing? You mean the frame carries
> more than just audio data? I think I'm misunderstanding something.
> Can you elaborate please.

Yes, time division multiplexing.  The extra signals could be non-audio
or they could be audio.  For example, you could have the CPU, CODEC and
a bluetooth chip connected to a single bus.  In such a scenario you
could have audio going directly between bluetooth and the CODEC with no
CPU involvement (allowing the CPU to suspend itself during a call).

That's not the only case - sometimes people do other things that need
the clocks running even when audio is off like sharing them with some
unrelated functionality.

> > Is it perhaps saner to just look at the current position as being the
> > position of the transfer to SRAM?  This does mean more variation from
> > the point at which data is audibly playing but on the other hand as far

> Hmm. Good point. I just wanted as accurate lip-sync as possible.

Yeah, it's tricky to know what's best.

> > battery life by setting up very big DMAs.  On a similar vein is it worth
> > considering making this feature entirely optional and/or falling back to
> > non-SRAM if SRAM allocation fails?

> Yes Chris Ring also asked for that, and it is fairly easy to allocate another
> SDRAM buffer to use for the SRAM. But I'd rather another patch after this

Incremental patches sounds fine to me.

> if I need to use plaform data. Maybe audio_sram_buffer_size = 0 in platform
> data to mean use SDRAM?

The only potential problem I see there is that that'd make disabling the
SDRAM the default.  I guess if people have been living without it so far
that's not a big problem, though, and it'll stop people getting surprised
by audio grabbing SDRAM when they weren't expecting it.

I guess if you're using SDRAM there's no need for the double buffering
(though that could be a third patch)?
