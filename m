From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] cs4270: add support for slave
	mode	configurations
Date: Sat, 28 Feb 2009 18:47:13 +0100
Message-ID: <20090228174713.GA20813@buzzloop.caiaq.de>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
	<20090228121343.GA18336@buzzloop.caiaq.de>
	<ed82fe3e0902280832u2a6e907l8195b5d9b00eafa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 109A3243C4
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 18:47:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0902280832u2a6e907l8195b5d9b00eafa2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Timur,

On Sat, Feb 28, 2009 at 10:32:30AM -0600, Timur Tabi wrote:
> On Sat, Feb 28, 2009 at 6:13 AM, Daniel Mack <daniel@caiaq.de> wrote:
> > Hmm - mclk bits are set with 'reg |= cs4270_mode_ratios[i].mclk;'
> > unconditionally, and both speed flags are used when in slave mode. Don't
> > see where you suspect a flaw here?
> 
> I think the code is fine, my question is more about the behavior of
> the hardware.  We were never able to get our board to run reliably
> with the cs4270 in slave mode, so I never gave it much thought.  I was
> hoping you could explain why you still need to set the mclk bits in
> the mode register when you're in slave mode.

We use the CS4270 in many projects (external soundcards) and in some of
them, we even link up to four of them together and put them all to slave
mode which works perfectly fine. It's just the first time I use it on a
Linux based board, though.

Setting the MCLKs for slave mode is probably not necessary (the
datesheet says so, too), but it doesn't harm either. We're doing that
for our other applications, so I copied the behaviour. In general, I
can says that this codec is a very smoothly working piece of hardware,
we never had any hazzle with it and use it for years now - what are the
effects that you see?

Daniel
