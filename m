From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI
	Soundchip
Date: Thu, 18 Aug 2005 13:12:34 -0400
Message-ID: <1124385155.5973.20.camel@mindpipe>
References: <Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-08-18 at 17:35 +0200, Clemens Ladisch wrote:
> > > +/* keep track of some hw registers */
> > >  struct ad1889_register_state {
> > >     u16 reg;        /* reg setup */
> > >     u32 addr;       /* dma base address */
> > > -   u16 rate;       /* sample rate */
> > > -   unsigned long pos;      /* last recorded DMA buffer position
> */
> > > -   unsigned long buf;      /* period # */
> > >     unsigned long size;     /* DMA buffer size */
> > > -   unsigned long count;    /* period size, aka nb bytes sent in
> the current DMA transfer */
> >
> > reading the patch through webmail doesn't help a lot getting a grasp
> > of its whole but i wonder if we could still find some debugging
> > purposes for these values. Remember this driver is work in
> progress ;)
> 
> Those fields just aren't used anymore; anything interesting is in the
> chip's registers. 

Isn't it still useful to maintain a cached copy of the register state
for suspend/resume purposes?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
