From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Enabling in-kernel synch for M-Audio boards
Date: Tue, 18 Sep 2007 07:57:23 +0100
Message-ID: <20070918065723.GA2512@localhost>
References: <46EE555B.9000700@alice.it> <20070917194403.GA3655@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D5724450
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 08:52:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070917194403.GA3655@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ludovico Verducci <ludwigvan@alice.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 17, 2007 at 08:44:03PM +0100, John Rigg wrote:
> On Mon, Sep 17, 2007 at 12:22:19PM +0200, Ludovico Verducci wrote:
> > Hello all! 
> >  
> > I'm developing a complex multichannel audio distribution system where 
> > multiple linux boxes will stream audio data over ethernet and then 
> > should play audio at sample level resolution synchronization. The boxes 
> > clocks are synchronized over ethernet using PTP. 
> > I need to keep in synch the audio board's clocks and I can't use an 
> > external wordclock nor s/pdif. 
> 
> Won't this cause serious clock jitter problems? I don't see how the
> PCI bus can deliver precise enough timing, considering how much other
> data it has to handle.

And I can't see any way that the clocks can be synced to sample
accuracy over ethernet. That's what external word clocks are for.
Even with a word clock I suspect that the latency of the
ethernet connection would be too high to allow sample accurate sync
of the audio.

John
