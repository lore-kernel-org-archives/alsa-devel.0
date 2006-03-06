From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel threads etc
Date: Mon, 06 Mar 2006 18:49:10 -0500
Message-ID: <1141688951.25487.93.camel@mindpipe>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141688305.9230.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0503519E
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 00:49:12 +0100 (MET)
In-Reply-To: <1141688305.9230.26.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-06 at 23:38 +0000, Adrian McMenamin wrote:
> On Mon, 2006-03-06 at 18:11 -0500, Lee Revell wrote:
> > On Mon, 2006-03-06 at 22:27 +0000, Adrian McMenamin wrote:
> > > I have an interrupt handler in my sound driver that calls this:
> > 
> > You never explained why you want to create a kernel thread rather than
> > implementing copy/silence callbacks like the docs say.
> > 
> > Lee
> 
> Reading through the notes it states:
> 
> "The third argument (pos) points the current position offset in frames."
> 
> Presumably that means the position in the playback ring buffer? It's not
> at all clear. 

Yes.  If the buffer contains 1024 frames then pos will range from 0 to
1023.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
