From: Martin Langer <martin-langer@gmx.de>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 15:36:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021216143611.GN773@tuba.home>
References: <E18NleD-0004xk-00@sc8-sf-list1.sourceforge.net> <1040013536.2187.4.camel@Godzilla> <20021216101721.GM773@tuba.home> <1040040264.1358.8.camel@Godzilla>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1040040264.1358.8.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: paul@linuxaudiosystems.com, alsa-devel@lists.sourceforge.net, swpatrick@earthlink.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 16, 2002 at 04:04:23AM -0800, Mark Knecht wrote:
> 
>    I'm having an interesting problem with this setup with now that's
> probably based in this area. If I bring up these two systems with the
> main DAW in Linux, and the slave system in Windows everything is fine.
> The DAW controls the frequency via my running jack, but even at first
> boot the two sides lock together just fine. 
> 
>    If I then boot the DAW into Windows, the two sides start making noise
> through the speakers, and if I look at the RME app in Windows on the
> slave machine, the frequency is bouncing around and so is the mode
> saying it's master or slave. The worst part is I get ugly noise out of
> my speakers unless I tell one f the two Windows machines what mode to be
> in.
> 
> On Mon, 2002-12-16 at 02:17, Martin Langer wrote:
> > 
> > But using master clock mode without defining a frequency before isn't
> > plausible for me and defining one master mode for each frequency was only a
> > quick solution by me.
> > 

IMHO this is a design bug of all rme cards. The documents about rme32 and
rme96 where identical in this point. They were talking about one master-mode
and nothing about the frequency. I don't know anything about rme9652 or
hdsp, but the sourcecode looks not very different to the older rme96.

But if you read the datasheet from prodif24 (not supported by alsa) you have
a switch with one slave position and three frequency positions. After
changing my driver from the rme way to this prodif24 way it runs without
this strange frequency problems some people have (I remember
vanDongen/Gilcher talking about a similar problem with his 96/8).

Alsa has copied here the documented rme way, but this seems to be wrong for
me. I have just checked the behaviour of rme32, but I'm very sure that the
bigger ones are working in the same style.

BTW: prodif24 document is on ftp.alsa-project.org


martin






-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
