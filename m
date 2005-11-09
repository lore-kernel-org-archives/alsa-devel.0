From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Fwd: Re: emu10k1 multichannel issue/observation]
Date: Wed, 09 Nov 2005 17:38:01 -0500
Message-ID: <1131575882.8383.108.camel@mindpipe>
References: <436FE555.7040400@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <436FE555.7040400@vt.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rick Wright <riwright@vt.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please make sure to cc: alsa-devel on these messages.

Thanks,

Lee

On Mon, 2005-11-07 at 18:37 -0500, Rick Wright wrote:
> 
> 
> -------- Original Message --------  
>                           Subject: 
> Re: [Alsa-devel] emu10k1
> multichannel issue/observation
>                              Date: 
> Mon, 07 Nov 2005 13:19:41 -0500
>                              From: 
> Rick Wright <riwright@vt.edu>
>                                To: 
> Lee Revell <rlrevell@joe-job.com>
>                                CC: 
> alsa-devel
> <alsa-devel@lists.sourceforge.net>,
> James Courtier-Dutton
> <James@superbug.co.uk>
>                        References: 
> <434E7646.3000507@poeticstudios.com> <5bdc1c8b0510221502v28a2cbe0ybfe049be2f34e186@mail.gmail.com> <200510230053.44479.Martin.Wohlleben@gmx.de> <5bdc1c8b0510221655r4d28430fr7b80f5403d8daaa4@mail.gmail.com> <435AF023.70903@woh.rr.com> <5bdc1c8b0510221957s278a28a7n8ead2de1e0760cf6@mail.gmail.com> <435B74E9.20308@woh.rr.com> <20051023180312.GA4544@mobilat.informatik.uni-bremen.de> <5bdc1c8b0510231123h5ed64b38nd178ce9dfcb13f87@mail.gmail.com> <1130097599.11980.54.camel@mindpipe> <5bdc1c8b0510231318j4e9db7b0x1106e9b240329249@mail.gmail.com> <435CFC95.6000703@vt.edu> <1130170444.16563.22.camel@mindpipe> <4362CBD7.8080606@vt.edu> <1130552828.32367.66.camel@mindpipe> <43656175.3040303@vt.edu> <1130719826.32101.2.camel@mindpipe> <43664057.3000205@vt.edu> <1131218656.13627.12.camel@mindpipe>
> 
> 
> 
> 
> Lee Revell wrote: 
> > On Mon, 2005-10-31 at 11:03 -0500, Rick Wright wrote:
> >   
> > > > > These machines are basically clones and the Audigy2 card is in the
> > > > > same PCI slot in both machines.
> > > > > 
> > > > >     
> > > > >         
> > > > Sorry I should have been more specific.  I need 
> > > > "lspci -vn | grep -A1 0401" output for both machines.
> > > > 
> > > >   
> > > >       
> > > Ok, here they are.
> > > 
> > > Rick
> > > plain text document attachment (lspci-output-no-side-channels.txt)
> > > 00:0b.0 Class 0401: 1102:0004 (rev 04)
> > > 	Subsystem: 1102:1005
> > > plain text document attachment
> > > (lspci-output-side-channels-working.txt)
> > > 00:0b.0 Class 0401: 1102:0004 (rev 04)
> > > 	Subsystem: 1102:2001
> > >     
> > 
> > The driver currently detects the card with the non-working side channels
> > as an Audigy 2 EX.  Is this correct?  Do you know whether all Audigy2 EX
> > cards have side channels?
> > 
> > Anyway, here's a patch to enable the side channels.
> > 
> > Enable side surround channels for Audigy2 EX.  Tested by Rick Wright
> > <riwright@vt.edu>.
> > 
> > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> > 
> > --- alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-10-28 17:20:22.000000000 -0400
> > +++ alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-05 14:22:34.000000000 -0500
> > @@ -680,6 +680,7 @@
> >  	 .emu10k2_chip = 1,
> >  	 .ca0102_chip = 1,
> >  	 .ca0151_chip = 1,
> > +	 .spk71 = 1,
> >  	 .spdif_bug = 1} ,
> >  	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
> >  	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
> > 
> > 
> > 
> >   
> 
> 
> "The new (1.0.10rc2) patched alsa-driver detects this card as an
> "Audigy 2 EX [1005]".  There are still no PCM Side channel sliders
> (though now we know the card doesn't support these), which suprises me
> since that was the patch, no?  At any rate, the patch should be
> changed to remove 7.1 and add 6.1, assuming there is support for this.
> I would expect a "PCM Center Rear" volume slider to appear and be
> functional for this card."
> 
> 
> Please disregard the statement above from my previous reply about ther
> not being PCM Side volume control devices.  They are indeed there, I
> simply needed to add them to the mixer from the Preferences menu -
> duh.  I haven't had time to check on the 6.1 functionality - even
> though we turned on 7.1.  It may be that one of these sliders controls
> the volume to the center rear channel.
> 
> Sorry for the persistent misinformation :-/   My bad.
> 
> Let me know how to help,
> Rick
> 
> 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
