From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Sat, 21 Jan 2006 01:57:28 +0100
Message-ID: <20060121005728.GO31803__16337.3651718304$1137805089$gmane$org@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain> <20060119224222.GW21663@redhat.com> <1137711088.3241.9.camel@mindpipe> <1137719627.8471.89.camel@localhost.localdomain> <20060120013402.GF3798@redhat.com> <s5hacdr9mdi.wl%tiwai@suse.de> <1137803349.3241.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 05528191
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 01:57:27 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1137803349.3241.21.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 20, 2006 at 07:29:09PM -0500, Lee Revell wrote:
> On Fri, 2006-01-20 at 12:20 +0100, Takashi Iwai wrote:
> > At Thu, 19 Jan 2006 20:34:02 -0500,
> > Dave Jones wrote:
> > > 
> > > On Fri, Jan 20, 2006 at 01:13:47AM +0000, Alan Cox wrote:
> > >  > On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
> > >  > > The status is we need someone who has the hardware who can add printk's
> > >  > > to the driver to identify what triggers the hang.  It should not be
> > >  > > hard, the OSS driver reportedly works.
> > >  > > 
> > >  > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
> > >  > > 
> > >  > > The bug has been in FEEDBACK state for a long time.
> > >  > 
> > >  > 99.9% of users don't ever look in ALSA bugzilla. 
> > >  > 
> > >  > A dig shows
> > >  > 
> > >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
> > >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221
> > > 
> > > Lee, if you can point me at a patch with debugging printk's I'm
> > > happy to throw that into the next Fedora test update for the
> > > users in the latter bug to test. (The first one seemed to go AWOL)
> > 
> > The bug for Latitude CSx should have been fixed by the following
> > commit:
> > 
> > 	commit 47530cf44cb5f3945ed04a5ae65d06bf423cd97b
> > 	Author: John W. Linville <linville@tuxdriver.com>
> > 	Date:   Wed Oct 19 16:03:10 2005 +0200
> > 
> > 	    [ALSA] nm256: reset workaround for Latitude CSx
> > 
> > This might not conver all Dell models.  In such a case, try
> > reset_workaround2=1.  See the section of nm256 in
> > ALSA-Configuration.txt for details.
> 
> OK I will update the ALSA bug report with this info.  IIRC at least one
> user already reported that the above commit does not fix the hangs.

The bug reporter reported this in the last comment of the bug (1.0.10rc3 
already included the mentioned fix).

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
