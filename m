From: Martin Langer <martin-langer@gmx.de>
Subject: Re: RME HDSP9652
Date: Thu, 28 Nov 2002 16:10:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021128151036.GC641@tuba.home>
References: <200211281337.gASDbvf00556@tench.street-vision.com> <1038494386.20379.31.camel@lotte>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1038494386.20379.31.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: paul@linuxaudiosystems.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 28, 2002 at 02:39:41PM +0000, Justin Cormack wrote:
> On Thu, 2002-11-28 at 13:42, Paul Davis wrote:
> > >I have just got a couple of the new RME Hammerfall HDSP9652 cards, and
> > >find that they are not supported by the snd-hdsp driver yet. The card is
> > >basically the same hardware as the other hdsp cards but with the io
> > >integrated on the card.
> > >
> > >I would guess that it will need a different firmware and another type in
> > >HDSP_Type, plus the channel info.  Does anyone know how to get the
> > >formware from RME (who to contact)?
> > 
> > all i need is the PCI ID from you. i've already spoken to RME about
> > the card, and the claim is that it will with the existing h-dsp
> > driver. the only thing that won't work are the RMS meters. the
> > existing driver, however, doesn't recognize the PCI ID and so it
> > doesn't work.
> > 
> 
> Its the same PCI ID, but insmod segfaults...
> 

Maybe there is a difference in the revision number. RME had used this way to
separate between Digi 96/8 PAD and Digi 96/8 PST in the past. 

martin


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
