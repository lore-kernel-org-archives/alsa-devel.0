From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 23:31:46 +0100
Message-ID: <200503242331.46985.rjw@sisk.pl>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe> <20050324121722.759610f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050324121722.759610f4.akpm@osdl.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Thursday, 24 of March 2005 21:17, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Thu, 2005-03-24 at 04:41 -0800, Andrew Morton wrote:
> > >   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
> > >   they are pulled 3-4 hours before the release of the -mm kernel.  
> > > 
> > 
> > Andrew,
> > 
> > Do you notify the subsystem maintainers ahead of time so that critical
> > fixes can be pushed to BK?
> 
> Occasionally I'll go out and ping people, but almost always the subsystem
> guys know what the development cycle is, and they appropriately decide
> which code should go in, and when.
> 
> > I am thinking of the recent ALSA example, where the emu10k1 driver was
> > b0rked in 2.6.12-mm1, but the fix had been in ALSA CVS for a week.
> > 
> 
> We've been discussing how to get ALSA CVS into ALSA bk more promptly.

BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
goes into the D state immediately), which did not happen before.  This is 100%
reproducible, on two different AMD64-based boxes, with different sound chips.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
