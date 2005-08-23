From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI Soundchip
Date: Mon, 22 Aug 2005 18:13:25 -0600
Message-ID: <20050823001325.GA19568@colo.lackof.org>
References: <20050817101017.008D03658E8@mail.esiee.fr> <Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de> <20050819174655.GA6376@colo.lackof.org> <s5hr7cpdd9p.wl%tiwai@suse.de> <20050820013655.GC6376@colo.lackof.org> <s5hpss6p721.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hpss6p721.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Clemens Ladisch <clemens@ladisch.de>, Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2005 at 01:03:34PM +0200, Takashi Iwai wrote:
> At Fri, 19 Aug 2005 19:36:55 -0600,
> Grant Grundler wrote:
> > 
> > On Fri, Aug 19, 2005 at 07:53:22PM +0200, Takashi Iwai wrote:
> > > Check his patch carefully.  It doesn't add any extra accesses (except
> > > for one readl to flush in irq handler - I guess it was added to be
> > > sure?).  The original driver didn't use these fields effectively at
> > > all, too.
> > 
> > Sorry - I didn't look at patch at all.
> > If the fields were never used, removing them is fine.
> > If they *could* have been used, then removing them is a bad idea.
> 
> They won't be used/referred any more at all, so why do you need still
> to keep them?

I don't - removing them is fine.

> > In general, referencing parameters in IO device registers is NOT
> > a good substitute for caching the values "locally" in host mem.
> 
> A cached value is not accurate, especially if you want to get a
> precise position.

Caching is only possible if the register is "constant" for
the duration of it's use. e.g. offset or "count down" registers
can't be cached.


>   The position callback should return the accurate
> position as much as possible since this can be used from the low
> latency calculation like dmix.

ok - no problem. That's reasonable.

grant


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
