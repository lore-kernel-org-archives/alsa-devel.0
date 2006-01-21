From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Fri, 20 Jan 2006 20:01:17 -0500
Message-ID: <1137805277.3241.53.camel__13849.7922955596$1137805344$gmane$org@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com>  <1137711088.3241.9.camel@mindpipe>
	 <1137719627.8471.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 24A50191
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 02:01:19 +0100 (MET)
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
Cc: Dave Jones <davej@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 01:13 +0000, Alan Cox wrote:
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
> 

I know, we don't expect users to look in it.  But you can't expect a
handful of developers, only two of whom are paid to work on ALSA, to
track every distro's bugzilla either.  It's hard enough to keep up with
the ALSA bug tracker.

The best solution is for the distros to make sure to refer users with
ALSA problems to the ALSA bug tracker, and for the maintainers of the
distro bugzillas to properly forward bugs upstream, like Debian does.

Lee





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
