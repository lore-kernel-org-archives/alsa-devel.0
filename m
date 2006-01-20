From: Dave Jones <davej@redhat.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 20:34:02 -0500
Message-ID: <20060120013402.GF3798@redhat.com>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain> <20060119224222.GW21663@redhat.com> <1137711088.3241.9.camel@mindpipe> <1137719627.8471.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00140148
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 02:34:16 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1137719627.8471.89.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 20, 2006 at 01:13:47AM +0000, Alan Cox wrote:
 > On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
 > > The status is we need someone who has the hardware who can add printk's
 > > to the driver to identify what triggers the hang.  It should not be
 > > hard, the OSS driver reportedly works.
 > > 
 > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
 > > 
 > > The bug has been in FEEDBACK state for a long time.
 > 
 > 99.9% of users don't ever look in ALSA bugzilla. 
 > 
 > A dig shows
 > 
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221

Lee, if you can point me at a patch with debugging printk's I'm
happy to throw that into the next Fedora test update for the
users in the latter bug to test. (The first one seemed to go AWOL)

		Dave



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
