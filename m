From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Re: RE: UDA1341TS (iPAQ H3X00) sound driver for ALSA
Date: Wed, 10 Apr 2002 18:45:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204101837280.13966-100000@fest.stud.fee.vutbr.cz>
References: <s5hhemjlhdp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhemjlhdp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Hicks, Jamey" <Jamey.Hicks@compaq.com>, Nicolas Pitre <nico@cam.org>, alsa-devel@lists.sourceforge.net, Linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Apr 2002, Takashi Iwai wrote:

> > > > I would prefer that the ALSA driver for the iPAQ have a
> > > different name
> > > > than the OSS driver for the iPAQ, since they have different
> > > interfaces.
> > > > How about h3600-alsa?
> > >
> > > No.  Please pick a relevant name.  H3600 is not the only
> > > device with an UDA1341 out there.
> >
> > The alsa driver mentioned is iPAQ specific.  It would be useful to restructure it in the way the other SA11x0/UDA134x driver is structured.
>
> the alsa modules have "snd-" prefix, so they don't conflict with
> others anyway.
>
> IMO, if the driver is iPAQ specific, i prefer a simple name such as
> snd-ipaq or snd-ipaq-h3x00.  if a part of the driver will be shared by
> others, then we can split it to a lowlevel module with a proper device
> name.

Hmm ,I expected comments to driver quality and behavior, not to its
name :).

This is first public release of the driver. UDA1341TS specific part is
placed in "snd-uda1341" module and should be ARM-independent. The rest is
placed in snd-h3600-uda1341. There you could find H3x00 specific parts
same as a bit of SA1100 DMA code. The SA1100 DMA stuff could be moved into
independent module (like sa1100-audio in OSS), but it's just "few lines"
of code now.

The driver could be structuded better of course, but I don't have any
other ARM and/or UDA1341 device to be able to exactly select parts which
are common.

This first release is intended for basic functionality tests. I think,
there is enough time to discuss final names of modules.

Bye

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
