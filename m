From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: RME96 driver patch
Date: Tue, 7 Jan 2003 12:32:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030107113235.GB20015@tuba.home>
References: <200301061851.44248.torger@ludd.luth.se> <Pine.LNX.4.33.0301061851560.551-100000@pnote.perex-int.cz>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA20582
	for <alsa-devel@alsa-project.org>; Tue, 7 Jan 2003 12:20:43 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301061851560.551-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: torger@ludd.luth.se, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 06, 2003 at 06:52:29PM +0100, Jaroslav Kysela wrote:
> On Mon, 6 Jan 2003, Anders Torger wrote:
> 
> > On Monday 06 January 2003 18.23, Jaroslav Kysela wrote:
> > > On Mon, 6 Jan 2003, Martin Langer wrote:
> > > >
> > > > If the card is in slave mode without an input signal and I'm
> > > > starting playing: Should the card jump into master mode therefore?
> > >
> > > No, an error return code is sufficient. Users know that the card is
> > > in slave mode.
> > 
> > In the case of the RME96 driver, this is no error, the card works with 
> > slave mode active and no input signal. As stated in a previous mail, 
> > I'm quite sure that it runs in master mode until the cards get a signal 
> > to synch with. This is how RME9652 works (hardware and driver), and I 
> > like that behaviour, so I have that in the RME96 driver as well.
> 
> If hardware supports this behaviour, then it's also ok for me.
> 

Let's suppose this playing is going on and a new fresh input arrives on my
input channel. So I would think the hardware will run in master mode and the
software will say: slave mode. I'm really not happy about this solution. I
would prefer a solution with precise modes or error messages if necassary.

I should repair my power supply for trying out...

martin


-- 
"2b|!2b"


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
