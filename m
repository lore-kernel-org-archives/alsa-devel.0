From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME DIGI96 ADAT input selection bug fix
Date: Thu, 3 Jul 2003 10:00:13 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.55.0307030958250.27426@brother.ludd.luth.se>
References: <200307012014.59778.torger@ludd.luth.se> <s5hadbxkzb5.wl@alsa2.suse.de>
 <200307021503.29038.torger@ludd.luth.se> <s5hsmppjchl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmppjchl.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Martin Langer <martin-langer@gmx.de>, Anders Torger <torger@ludd.luth.se>
List-Id: alsa-devel@alsa-project.org


On Wed, 2 Jul 2003, Takashi Iwai wrote:

> At Wed, 2 Jul 2003 15:03:28 +0200,
> Anders Torger wrote:
> >
> >
> > On Wednesday 02 July 2003 12.17, Takashi Iwai wrote:
> > > Hi,
> > >
> > > At Tue, 1 Jul 2003 20:14:59 +0200,
> > >
> > > Anders Torger wrote:
> > > > Stefan Mueller found a bug in my Digi96 driver. Sometimes I write
> > > > != when I mean == or the other way around:
> > >
> > > thanks, applied to cvs.
> > >
> > > BTW, shall i apply the patch by Martin Langer for unifying the clock
> > > source control?  it's been pending for long time for evaluation.
> >
> > Oh, sorry, I have forgot about that one, could I get to look at the
> > patch again? I suppose it is ok, but it could potentially make the
> > driver refuse sampling from the input (returning -EIO) when there is no
> > signal there.
>
> well, i think you're referring to a different patch (yeah, i remember
> there was something like that, too).
>
> the patch below is the one i wanted to include.
> basically this changes only the name of clock source control element
> to be compliant to the definition in ControlNames.txt.

Ah, thanks. It looks perfectly ok to me, I suggest that you apply it.
Sorry for not reacting earlier...

/Anders


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
