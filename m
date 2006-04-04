From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Re: Patch for AICA sound support on SEGA Dreamcast
Date: Tue, 04 Apr 2006 08:12:02 +0100
Message-ID: <1144134722.9270.4.camel@localhost.localdomain>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
	 <200604040116.13732.s0348365@sms.ed.ac.uk>
	 <1144110986.22082.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144110986.22082.4.camel@mindpipe>
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
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, Takashi Iwai <tiwai@suse.de>, Carlos Munoz <carlos@kenati.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-03 at 20:36 -0400, Lee Revell wrote:
> On Tue, 2006-04-04 at 01:16 +0100, Alistair John Strachan wrote:
> > I think this write-up provides justification. However, it is not part
> > of linux/Documentation/CodingStyle. Perhaps somebody should add these
> > details to this file, so that new code follows this currently
> > 'unwritten' rule. 
> 
> Well, if you look at the current ALSA code, the only typedefs provided
> are for backwards compatibility.  They were all removed from the drivers
> months ago.  The problem is that you were working against old code.  The
> main coding style rule is to follow the conventions of the nearby code,
> which would mean no typedefs in the ALSA driver case.
> 


Well, the typedefs are going - look in my personal CVS
(http://newgolddream.dyndns.info/cgi-bin/cvsweb ) and you'll see that
most are now gone.

I wrote the code, however, against the 2.6.15 kernel, not an
unreasonable proposition given that it was the current kernel until
about 2 weeks ago.





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
