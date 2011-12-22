From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3 v2] sound/soc/lapis: add platform
 driver for ML7213 IOH I2S
Date: Thu, 22 Dec 2011 10:39:47 +0000
Message-ID: <20111222103946.GA4546@opensource.wolfsonmicro.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111220132314.GQ2866@opensource.wolfsonmicro.com>
	<CANKRQng8N3oS2o17HPUZeonXB3KLBK9oNQj-zd9+aUUvWcTo0A@mail.gmail.com>
	<20111222005816.GB27144@opensource.wolfsonmicro.com>
	<CANKRQnjCTAX02wJt7StjB0rXkg3Q6bPBRYCbkgq6vS5NFd97Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E95B7244A7
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 11:39:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnjCTAX02wJt7StjB0rXkg3Q6bPBRYCbkgq6vS5NFd97Fg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 05:10:24PM +0900, Tomoya MORINAGA wrote:

> I can understand your saying.
> However, in case of Tx interrupt, only ALMOST-EMPTY occurs. in case of
> Rx, only Rx ALMOST-FULL occurs.
> So as long as a user uses ML7213 I2S, your mentioned behavior is never ha=
ppened.

That's not what your code says...  it may be that the other interrupts
are very rare but that's not the same thing.

> They have the "filter" function immediately next to the code uses
> "dma_request_channel".

That's a rather large function...

> Anyway, if you want me to change the name, I can change the name.
> Please decide it.

Rename.

> > You're implementing some sort of custom buffering in your driver? =A0Th=
at
> > sounds terribly unidiomatic - pretty much all DMA drivers are very thin
> > and manage to work well, I'd expect this is masking some problems in the
> > code rather than anything else. =A0Can you provide more detail on what
> > this is working around?

> Not sorted but queuing only.
> In sound/voice control system, queuing is not rare, I think.
> If necessary, though this method is very common, I can send the method
> of the queue.

No, please describe the problem you're trying to fix.  If nothing else
think about what you're saying here - if this is a common need then it's
something that's going to be handled in generic code, not open coded in
individual drivers.  Like I say I would expect that you have problems
elsewhere in your code which you are masking with this.
