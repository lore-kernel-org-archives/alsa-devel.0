From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 23:37:03 +0100
Message-ID: <200503242337.03657.rjw@sisk.pl>
References: <20050324044114.5aa5b166.akpm@osdl.org> <20050324121722.759610f4.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503242331.46985.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

On Thursday, 24 of March 2005 23:31, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 24 of March 2005 21:17, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > On Thu, 2005-03-24 at 04:41 -0800, Andrew Morton wrote:
> > > >   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
> > > >   they are pulled 3-4 hours before the release of the -mm kernel.  
> > > > 
> > > 
> > > Andrew,
> > > 
> > > Do you notify the subsystem maintainers ahead of time so that critical
> > > fixes can be pushed to BK?
> > 
> > Occasionally I'll go out and ping people, but almost always the subsystem
> > guys know what the development cycle is, and they appropriately decide
> > which code should go in, and when.
> > 
> > > I am thinking of the recent ALSA example, where the emu10k1 driver was
> > > b0rked in 2.6.12-mm1, but the fix had been in ALSA CVS for a week.
> > > 
> > 
> > We've been discussing how to get ALSA CVS into ALSA bk more promptly.
> 
> BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
> goes into the D state immediately), which did not happen before.  This is 100%
> reproducible, on two different AMD64-based boxes, with different sound chips.

Er, sorry for the noise on alsa-devel.  Actually, rmmod doesn't work for me at all
on x86-64 (on two different boxes).

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
