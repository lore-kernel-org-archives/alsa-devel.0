From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 15:49:29 -0800
Message-ID: <20050303154929.1abd0a62.akpm@osdl.org>
References: <4227085C.7060104@drzeus.cx>
	<29495f1d05030309455a990c5b@mail.gmail.com>
	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	<1109875926.2908.26.camel@mindpipe>
	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	<1109876978.2908.31.camel@mindpipe>
	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Canter <marcus@vfxcomputing.com>
Cc: rlrevell@joe-job.com, nish.aravamudan@gmail.com, drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mark Canter <marcus@vfxcomputing.com> wrote:
>
> 
> To close this issue out of the LKML and alsa-devel, a bug report has been 
> written.
> 
> It appears to be an issue with the 'headphone jack sense' (as kde labels 
> it).  The issue is in the way the 8x0 addresses the docking station/port 
> replicator's audio output jack.  The mentioned quick fix does not work for 
> using the ds/pr audio output, but does resolve it for a user that is only 
> using headphones/internal speakers.

But there was a behavioural change: applications which worked in 2.6.10
don't work in 2.6.11, is that correct?

If so, the best course of action is to change the kernel so those
applications work again.  Can that be done?
