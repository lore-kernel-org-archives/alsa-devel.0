From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH 1/4] snd-usb-caiaq: Do not disable local
	interrupts
Date: Sun, 18 Oct 2009 18:52:00 +0100 (BST)
Message-ID: <alpine.NEB.2.01.0910171716460.5442@jrf.vwaro.pbz>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
	<1253892138-10827-1-git-send-email-mark@pogo.org.uk>
	<20090925160024.GT21654@buzzloop.caiaq.de>
	<alpine.BSO.2.01.0909261630400.8841@zrgural.vwaro.pbz>
	<s5hiqf34gf4.wl%tiwai@suse.de>
	<20091017161214.GX28832@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id A32E910380E
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 19:48:34 +0200 (CEST)
In-Reply-To: <20091017161214.GX28832@buzzloop.caiaq.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 17 Oct 2009, Daniel Mack wrote:

> On Mon, Sep 28, 2009 at 10:33:35AM +0200, Takashi Iwai wrote:
> > At Sat, 26 Sep 2009 17:06:23 +0100 (BST),
> > Mark Hills wrote:
> > > 
> > > On Fri, 25 Sep 2009, Daniel Mack wrote:
> > > 
> > > > On Fri, Sep 25, 2009 at 04:22:15PM +0100, Mark Hills wrote:
> > > >> The driver documentation states that local interrupts are already
> > > >> disabled when trigger() is called, so only a spinlock is required.
> > > >
> > > > Hmm. I assume you tested them well. But I remember to have had quite 
> > > > some trouble at this point on SMP machines and ended up with that 
> > > > irqsave code. However, if you're sure that fixes a bug or is not 
> > > > necessary, let's take the patches and I'll test them once I'm back home 
> > > > around mid Oct.
> > > 
> > > I did check both non and SMP machines, and it corresponds to the docs. I 
> > > also removed the patches to verify I could reproduce the original 
> > > problems.
> > 
> > The irqsave is needed for deactivate_substream() because it's called
> > also in your hw_free callback, which is non-atomic.
> > In the real case, it's hard to hit this codepath, though.
> 
> Well, the nature of race conditions is that they are hard to hit, right? ;)
> 
> However, I tested the patches now, and couldn't reproduce anything like
> the things I remember I had.
> 
> So from my side, they can go in then. Sorry for the long delay on this.

No, Takashi is correct -- deactivate_substream() is also used in hw_free. 
It means that "[PATCH 1/4] Do not disable local interrupts" should not be 
applied. It was meant to be a cleanup only but introduces a new problem.

The other patches (2-4) are good and should be applied. I'll resubmit with 
my Signed-off-by, but this will be in a week or so.

-- 
Mark
