From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsa cvs not building on top
	of	2.6.10-rc2-mm3-V0.7.32_14
Date: 10 Dec 2004 12:08:13 -0800
Message-ID: <1102709293.21476.245.camel@cmn37.stanford.edu>
References: <1102657139.4096.5.camel@cmn37.stanford.edu>
	 <1102659979.24675.6.camel@krustophenia.net>
	 <1102704485.21582.80.camel@cmn37.stanford.edu>
	 <s5hfz2e0yr5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.Stanford.EDU (smtp1.Stanford.EDU [171.67.16.123])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8241349
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 21:08:26 +0100 (MET)
In-Reply-To: <s5hfz2e0yr5.wl@alsa2.suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-12-10 at 10:55, Takashi Iwai wrote:
> At 10 Dec 2004 10:48:05 -0800,
> Fernando Lopez-Lezcano wrote:
> > 
> > On Thu, 2004-12-09 at 22:26, Lee Revell wrote:
> > > On Thu, 2004-12-09 at 21:38 -0800, Fernando Lopez-Lezcano wrote:
> > > > I can't seem to build current alsa cvs on top of
> > > > 2.6.10-rc2-mm3-V0.7.32-14...
> > > 
> > > I think I had this problem, and it went away mysteriously.  I can't
> > > reproduce it now. 
> > 
> > Lucky you :-)
> > 
> > > Try a clean cvs checkout.
> > 
> > The checkout was clean (ie: on a newly created directory). I'm
> > installing the kernel on another of my test machines to do another clean
> > download and install. 
> 
> Make sure that you have no alsa-driver/acore/memalloc.c after make
> clean.

I'm very confused......

The build process works under an older kernel, but not the newer (using
cvscompile). I'm suspecting that somehow the version of the kernel is
not being detected correctly somewhere in the alsa code and then
something breaks while building. 

Booting in the old kernel (a 2.6.8.1-U9.2 based kernel):
  cvscompile works
  cvscompile --with-kernel newer_kernel fails
Booting into the new kernel
  cvscompile always fails no matter where I point it too
Does not make sense...

-- Fernando




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
