From: Leif Lindholm <leif.lindholm@i3micro.com>
Subject: Re: Migration from 0.5 to 0.9?
Date: 05 Apr 2002 12:00:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1018000807.2534.66.camel@lel1.sthlm.i3micro.se>
References: <1017927701.1777.12.camel@lel1.sthlm.i3micro.se>
	<3CAD0534.5050102@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mail.i3micro.se (i3micro-gw1.dcs.net [217.78.32.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA00946
	for <alsa-devel@alsa-project.org>; Fri, 5 Apr 2002 12:00:40 +0200
In-Reply-To: <3CAD0534.5050102@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: James@superbug.demon.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 2002-04-05 at 04:00, James Courtier-Dutton wrote:
> I would post the source code of your current driver somewhere (URL).

If you still think so after reading this mail (especially license stuff
at end of mail), I could post a diff somewehere.

> If the set top box uses the AC97-Controller, alsa09 might already have a 
> sound driver for it, but someone might need to add an extra bit of card 
> recognition code to get it to work.

It uses the internal AC97-controller of the SC1200 processor
(XpressAUDIO - PCI device 100b:0503). I didn't find anything like that
in the 0.9 code when I browsed through it. The driver also incorporates
some MIDI stuff and such.

> Also, if you can post to a URL any documents about the set-top-box, 
> which would make it easier for people to help you. We might be able to 
> recognise which of the current drivers is closest to it from that.

Well - I'm _paid_ to write these drivers :)

National puts "Confidential" notices on all their documentation, so I
don't think it would be a good idea to post those...

And since our box is not quite on the market yet, I think my managers
might not like me releasing too much specs.

So what I can say is about this:

The audio controller is described pretty well in this message I located
on google:
http://www.alsa-project.org/archive/alsa-howto/msg00312.html

Different revisions of the box use CS4299 or CS4205 codecs.

> It would probably be better to get support for the set top box into the 
> publically available version of alsa09, so that it will be kept up to 
> date with any other changes which might happen in alsa without you 
> having to worry about it.

I definitely agree with you about this, however Nationals driver has
some weird "BSD with export restrictions" license attached to it.

Personally I think they should release the code under GPL so that it can
be integrated with the main project, and I will try to convince them to
do so - but for now I simply don't have time to wait for that.

To clarify myself: what I really need right now is some hints about what
differs between 0.5 and 0.9 from the driver(programmer)s point of view.

regards
	/
		Leif
