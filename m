From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: RFC: OSS driver removal, a slightly different	approach
Date: Fri, 20 Jan 2006 18:22:10 -0500
Message-ID: <1137799330.13530.30.camel__30448.0849802077$1137818709$gmane$org@grayson>
References: <20060119174600.GT19398@stusta.de>
 <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
 <20060120212917.GA14405@suse.de>
 <1137799001.12998.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from a34-mta01.direcway.com (a34-mta01.direcpc.com [66.82.4.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA12C192
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 05:44:46 +0100 (MET)
Received: from mail.phunnypharm.org ([67.142.247.22]) by a34-mta01.direcway.com
 (iPlanet Messaging Server 5.2 HotFix 2.05 (built Mar  3 2005))
 with ESMTP id <0ITE0060PZNKK2@a34-mta01.direcway.com> for
 alsa-devel@alsa-project.org; Fri, 20 Jan 2006 18:23:48 -0500 (EST)
In-reply-to: <1137799001.12998.59.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-01-21 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
> >  On Fri, Jan 20, Adrian Bunk wrote:
> > 
> >  
> > > Can someone from the ppc developers drop me a small note whether 
> > > SND_POWERMAC completely replaces DMASOUND_PMAC?
> > 
> > It doesnt. Some tumbler models work only after one plug/unplug cycle of
> > the headphone. early powerbooks report/handle the mute settings
> > incorrectly. there are likely more bugs.
> 
> Interesting... Ben Collins hacked something to have Toonie work as a
> "default" driver for non supported machine and saw that problem too, I
> think he fixes it, I'll check with him what's up there and if his fix
> applied to tumbler.c as well.

My "fix" was basically the result of converting to the platform
functions. It's hit or miss whether this works with tumbler too.

You can try the Ubuntu kernel packages (they can be unpacked and used on
non Ubuntu systems pretty easily) to see if it works for you. Tumbler
platform function conversion isn't even tested, so I'd be happy to hear
any feedback.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
