From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: envy24control can't set sample rate on Delta 1010
Date: Mon, 21 Apr 2008 21:24:30 +0100
Message-ID: <20080421202430.GA3697@localhost>
References: <20080421004206.GA3431@localhost> <s5htzhvb3vd.wl%tiwai@suse.de>
	<20080421165856.GA3432@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A917243AC
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 22:15:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080421165856.GA3432@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 21, 2008 at 05:58:56PM +0100, John Rigg wrote:
> On Mon, Apr 21, 2008 at 05:54:14PM +0200, Takashi Iwai wrote:
> > At Mon, 21 Apr 2008 01:42:06 +0100,
> > John Rigg wrote:
> > > 
> > > envy24control in alsa-tools-1.0.16 cannot set sample rate
> > > on the M-Audio Delta 1010. The Actual Rate window appears to
> > > be functioning correctly, as is the "S/PDIF in" button, but
> > > none of the internal clock sample rate buttons do anything.
> > > Setting the sample rate as a jackd parameter works as normal.
> > > 
> > > I tried it with 2.6.20 and 2.6.25 kernels. Behaviour was
> > > the same on both. I've made a bug report (0003915).
> > 
> > And which version of alsa-tools works regarding this?
> > If we can narrow down the last working version, it'd be relatively
> > easy to find the culprit.
> 
> Sorry for lack of info (I was testing this at 1am).
> So far I've tested alsa-tools-1.0.13 to 1.0.16 and
> all those exhibit this behaviour. I'm using 1.0.13
> on my production system, but I hadn't noticed it because
> I don't usually use envy24control to change sample rates.
> It was brought to my attention by several users who have emailed
> me about it. 
> 
> It's quite an awkward problem because once the
> clock source gets set to S/PDIF it can no longer be reset to
> internal clock without using alsactl or re-initialising the card(s)
> by cold rebooting with alsa init.d scripts disabled.
> 
> The problem obviously appeared before 1.0.13. It might
> be a few days before I get time to test earlier versions,
> but I'll try to find the last working version.

After further tests, this doesn't actually look so serious.
When jackd is running, the clock source can be
changed to S/PDIF in or Word Clock in, but can not be changed back
to internal clock again until jackd is stopped. This might be a minor
inconvenience to some, although it could be argued that clock sources
should not be changed while jackd is running. Once jackd is stopped the 
internal clock can be selected correctly with the sample rate buttons.
I was mistaken about having to re-initialise the card to restore normal
behaviour (that's what happens when testing at 1am). Sorry about the noise.

John
