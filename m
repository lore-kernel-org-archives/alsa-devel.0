From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: force byte-swap at soc level before codec?
Date: Sat, 23 May 2009 11:43:57 +0100
Message-ID: <20090523104356.GB19148@sirena.org.uk>
References: <13717.1243074521@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE08F245CE
	for <alsa-devel@alsa-project.org>;
	Sat, 23 May 2009 12:44:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <13717.1243074521@mini>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brad Parker <brad@heeltoe.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 06:28:41AM -0400, Brad Parker wrote:

> The codec claims S16_LE.  The i2s layer claims S16_LE as does the pcm

A change has been merged for 2.6.31 which makes CODEC drivers match
against either endianess in order to support this use case, though
obviously the 2.6.31 release won't happen for a while.

> layer inside soc.  The source data in user land is S16_LE.  But when the
> i2s hardware (which I can't change) does dma the bytes go to the codec
> in reverse order.

> So, I need a byte swap somewhere.  I verified this by sending constant
> data from user land via the oss compat layer (i.e. /dev/dsp).  If I swap
> them in userland they come out on the scope at the codec in the correct
> order.

> Any know the simplest way to do this?

> I've tried a bunch of ways but nothing seems to work correctly. It seems like
> ALSA already handles this as long as I tell the right thing from below.

Yes, if your driver tells userspace the format it needs then things
should've been figured out by the time the driver sees the data.  Change
your CPU drivers to advertise _BE variants instead and either change the
CODEC driver locally to do the same thing or run with the latest ASoC
code which will make the change for you.  The ASoC core will pass on the
common constraints that the individual drivers advertise to userspace.
