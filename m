From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode
	to	psp
Date: Thu, 5 Mar 2009 11:21:33 +0000
Message-ID: <20090305112133.GD2416@sirena.org.uk>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
	<74d0deb30903041256u8eeea03n5500cd59afadd86e@mail.gmail.com>
	<20090304230301.GA20915@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 707BA10386C
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 12:21:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304230301.GA20915@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 12:03:01AM +0100, Daniel Mack wrote:
> On Wed, Mar 04, 2009 at 09:56:01PM +0100, pHilipp Zabel wrote:

> > Shouldn't this be somehow set by set_dai_clkdiv instead?

> This is actually a very common case - MCLK is BCLK*4, so I put it here.
> We could still move it to some more configurable place if it turns out
> we need to configure it per board.

It's a common option but far from universal - apart from anything else
normally the MCLK requirement is a multiple of the sampling frequency
rather than the bitclock rate so the ratio with BCLK will often vary
with sample size.  I've seen devices able to operate as low as 64fs and
IIRC I've seen things up to 512fs, though 256fs is more common.
