From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Latency of mixer reconfiguration
Date: Thu, 18 Feb 2010 10:01:27 +0000
Message-ID: <20100218100127.GJ2032@sirena.org.uk>
References: <20100217181530.GA23152@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C26E1038F7
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 11:01:28 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1Ni3CJ-0006KF-VF
	for alsa-devel@alsa-project.org; Thu, 18 Feb 2010 10:01:27 +0000
Content-Disposition: inline
In-Reply-To: <20100217181530.GA23152@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 07:15:30PM +0100, Lennart Poettering wrote:

> Now the question I have is, how should I best deal with this? I
> currently assume that mixer volume changes are basically instantaneous
> when I call the respective function of ALSA. But are they really? How
> big is the latency at max? Do we need an API to query it?

For the embedded case the hardware update should happen synchronously
with the ALSA API call to adjust the setting and begin affecting the
played audio instantaneously.  The time taken to do the hardware update
will be dominated by I/O costs, which will in turn depend on the bus
used to access the codec - it'd be good if the buses could provide some
information to ASoC to allow it to do an estimate, but at the minute
we've got nothing really to go on.

What's more interesting from this point of view is that the update will
affect the audio going through the chip at the current moment so there
will be latency from the DMA chain and possibly also from the DSP chain
within the CODEC (which may vary depending on which volume you're
updating).

I suspect that trying to offer additional resolution in this way is more
trouble than it's worth if you're concerned about the artifacts that are
introduced during updates.  Providing per-channel differentiation if the
hardware has only mono control has much fewer problems, though.
