From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: weird xrun problem
Date: Tue, 1 Jun 2004 09:56:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406010952400.1781@pnote.perex-int.cz>
References: <20040522123855.12837e8d.pochini@shiny.it>
 <Pine.LNX.4.58.0405231116590.2139@pnote.perex-int.cz>
 <20040525231642.4ae3c3a1.pochini@shiny.it> <Pine.LNX.4.58.0405260942320.1937@pnote.perex-int.cz>
 <20040530211239.28fe33a4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040530211239.28fe33a4.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 30 May 2004, Giuliano Pochini wrote:

> On Wed, 26 May 2004 09:52:06 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > > ALSA does not know about this. All period sizes must be equal.
> > > 
> > > I thought about this again. Are you sure all periods must be aqual ?  
> > > When I record or play something using unequal periods, sound is perfect.
> > > It means ALSA reads and writes the last (sometimes a lot) smaller period
> > > as well.
> >
> > The driver must not acknowledge the settled period with the midlevel and
> > application before the specified time. Of course, if you're running into
> > a rounding problem, you can acknowledge more periods at one time.
> > In other cases, it's not very practical to program hardware to use 
> > different period sizes, because you need more interrupts for processing.
> 
> My question was about your sentence: "All period sizes must be equal". Is it
> true ? It seems quite strange to me because ALSA passes a buffer size that

Yes, the time distance between period boundaries must be equal in longer 
term. Of course, interrupt/hardware latencies might shift the interrupt 
processing a few samples after.

> is not multiple than the period size almost always. This is not a problem in

I don't say that periods * period_size == buffer_size. It's another 
special case.

> my case because the s-g list is generic enough to handle it.

Yes, that's right.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
