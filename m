From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Latency of mixer reconfiguration
Date: Thu, 18 Feb 2010 19:04:22 +0100
Message-ID: <20100218180422.GA5606@tango.0pointer.de>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6514D103901
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 19:04:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100218100127.GJ2032@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 18.02.10 10:01, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> > Now the question I have is, how should I best deal with this? I
> > currently assume that mixer volume changes are basically instantaneous
> > when I call the respective function of ALSA. But are they really? How
> > big is the latency at max? Do we need an API to query it?
> 
> For the embedded case the hardware update should happen synchronously
> with the ALSA API call to adjust the setting and begin affecting the
> played audio instantaneously.  The time taken to do the hardware update
> will be dominated by I/O costs, which will in turn depend on the bus
> used to access the codec - it'd be good if the buses could provide some
> information to ASoC to allow it to do an estimate, but at the minute
> we've got nothing really to go on.

But what would you guess? In which range will this most likely be? < 1ms? 
1ms? 10ms? 100ms? 1s? 1h? 10h? 10d? 10y?

tbh I feared less the actually IO latency but more that some PCM data
fifos might need flushing before the volume is actually updated. And
the latency of those fifos I feared might be more than a handful of
samples?

> What's more interesting from this point of view is that the update will
> affect the audio going through the chip at the current moment so there
> will be latency from the DMA chain and possibly also from the DSP chain
> within the CODEC (which may vary depending on which volume you're
> updating).
> 
> I suspect that trying to offer additional resolution in this way is more
> trouble than it's worth if you're concerned about the artifacts that are
> introduced during updates.  Providing per-channel differentiation if the
> hardware has only mono control has much fewer problems, though.

The current logic is to not do any software adjustment if the hardware
adjustment is "close enough" to the total adjustment we want to do,
tested against a threshold. Which I think is quite a reasonable
approach because it enables/disables this feature not globally, but
looks at each case and enables this logic only if it really has a
benefit.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
