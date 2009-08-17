From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set	TDM when needed
Date: Mon, 17 Aug 2009 17:08:44 +0100
Message-ID: <20090817160844.GA29225@sirena.org.uk>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
	<1250266661.18028.249.camel@brutus>
	<20090817153548.GB19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D91F2479D
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 18:08:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090817153548.GB19257@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 17, 2009 at 05:35:48PM +0200, Daniel Mack wrote:
> On Fri, Aug 14, 2009 at 01:17:41PM -0300, Daniel Ribeiro wrote:

> > Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).

> Again - shouldn't we care for a consistent calling convention here and
> handle the special cases in the implementation rather than feeding
> nebulous integer arguments to it, which vary depending on the clocking
> directions?

Yes, the arguments to set_tdm_slot() should have a consistent meaning
over all devices and configurations of those devices.  There will be an
inversion of the input vs. output between two connected devices but that
would be the only difference.

The key issue here is if we're looking at stereo slots or mono slots.
Stereo is probably a bit easier to work with when you're using that
(especially for I2S derived modes where the interface is fundamentally
stereo) but obviously there's the potential to run into cases where that
causes issues so mono covers our bets more.

> > This still violates the "DMYSTOP must be clear on network mode" rule,
> > but as all slots are active its not really network mode. And it seems to
> > work for you, so... ;)

> Yeah, that makes no sense at all. I think we should ignore that comment.
> It seems to be simply wrong, or we're not in network mode afterall, even
> though we selected it. I don't know.

Or the network mode is perfectly happy to support a range slot numbers
including zero.
