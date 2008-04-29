From: "Nathan Schulte" <reklipz@gmail.com>
Subject: Re: help with idt 92hd206 codec for intel hda?
Date: Tue, 29 Apr 2008 14:37:07 -0500
Message-ID: <a221c0100804291237n15a4da1euc94fdd986150ee29@mail.gmail.com>
References: <95ce66d80804262338k536d763bweca4e7d6ff39e06d@mail.gmail.com>
	<s5h1w4oy84a.wl%tiwai@suse.de> <s5hod7swquv.wl%tiwai@suse.de>
	<a221c0100804291001j1a2b043vdf1dc86dfd774df0@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE66134C51@CORPEXCH1.na.ads.idt.com>
	<a221c0100804291201s7d94c5efw12af5c5698b72d72@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE66134C67@CORPEXCH1.na.ads.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 605162492E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Apr 2008 21:37:09 +0200 (CEST)
Received: by rv-out-0506.google.com with SMTP id g37so62604rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2008 12:37:07 -0700 (PDT)
In-Reply-To: <16A430A423D62246A24C9A892622FE66134C67@CORPEXCH1.na.ads.idt.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Tellman, Steven" <Steven.Tellman@idt.com>
Cc: Takashi Iwai <tiwai@suse.de>, Greg Zornetzer <gzornetzer.lists@gmail.com>, alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Ok, that's good to know.

So, it looks like I'll either need to encode everything to a DTS/AC3 stream
in ALSA before sending via SPDIF, that should work, right?

Also, this is a chip limitation, not an SPDIF limitation, right?

Thanks for the support!

-Nate
On Tue, Apr 29, 2008 at 2:21 PM, Tellman, Steven <Steven.Tellman@idt.com>
wrote:

> SPDIF is limited to 2 channels when using PCM. DTS/AC3 is the only way
> to get multi-channel out of SPDIF.
>
> Unless you run ADAT, which is 8 channels uncompressed 24bit/48kHz, but
> I'm not sure that's supported in Linux.
>
> IDT PC Audio Marketing Engineer/Linux Manager
> W: (512) 330-3127
>
>
> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Nathan Schulte
> Sent: Tuesday, April 29, 2008 2:01 PM
> To: Tellman, Steven
> Cc: Takashi Iwai; Greg Zornetzer; alsa-devel@alsa-project.org; Matthew
> Ranostay
> Subject: Re: [alsa-devel] help with idt 92hd206 codec for intel hda?
>
> Well, when I first installed my distro, I managed to get the spdif to
> output
> 2 channels. I could only get two channels, unless i sent a raw DTS or
> AC3
> stream for decoding on the receiver end.
>
> Now, on after I reinstalled (changed from raid0 to raid5), I cannot get
> any
> audio whatsoever (even via analog outs).
>
> So there are really two separate issues now.
>
> 1) Getting audio to work.
> 2) Getting 6+ Channel audio via spdif.
>
> Should I try applying these patches or should I try compiling ALSA by
> hand
> instead of using the distro supplied package?
>
> Also, after looking at the sigmatel patch for hda-intel, the 92xx chips
> are
> limited to two channels via spdif... On my first install, I changed the
> limit, and recompiled by hand. ALSA would then tell me that 6 channels
> was
> ok, as opposed to throwing an error, yet I still only got two channels.
>
> Ideas?
>
> -Nate
>
> On Tue, Apr 29, 2008 at 1:19 PM, Tellman, Steven
> <Steven.Tellman@idt.com>
> wrote:
>
> >  Are you having issues with that board? The 92HD202 has the same ID as
> the
> > STAC9221.
> >
> >
> >
> > IDT *PC Audio* Marketing Engineer/Linux Manager
> >
> > W: (512) 330-3127
> >
> >
> >
> > *From:* Nathan Schulte [mailto:reklipz@gmail.com]
> > *Sent:* Tuesday, April 29, 2008 12:02 PM
> > *To:* Takashi Iwai
> > *Cc:* Greg Zornetzer; alsa-devel@alsa-project.org; Tellman, Steven;
> > Matthew Ranostay
> > *Subject:* Re: [alsa-devel] help with idt 92hd206 codec for intel hda?
> >
> >
> >
> > I recently purchased an ECS A740GM-M Motherboard which has also an IDT
> > 92HD202 integrated audio chipset.
> >
> > ALSA is recognizing it as a SigmaTel 9221 A2.
> >
> > I'm willing to test these patches as well as give any information you
> guys
> > might need.
> >
> > -Nate
> >
> > (sorry for any duplicate messages, I'm still trying to get hold of how
> > this listing thing works...)
> >
> > On Tue, Apr 29, 2008 at 11:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > At Tue, 29 Apr 2008 17:48:53 +0200,
> >
> > I wrote:
> > >
> > > At Sun, 27 Apr 2008 01:38:19 -0500,
> > > Greg Zornetzer wrote:
> > > >
> > > > Hi all,
> > > > I recently acquired an ECS GF7100PVT-M3 motherboard, which appears
> to
> > use
> > > > the IDT 92HD206 codec for HDA.  Unfortunately, it doesn't appear
> to
> > have
> > > > full support under ALSA.  It gets detected as another Sigmatel
> chip.
> >  Analog
> > > > stereo output appears to work, but the mixer doesn't find any of
> the
> > normal
> > > > inputs.
> > > >
> > > > I found the tech specs for the chip at
> > > > http://www.idt.com/products/getDoc.cfm?docID=13461840
> > > > I've attached an lspci output and the codec file to this email.
> I'm
> > not
> > > > much of an driver hacker, but if someone could give me an idea of
> what
> > needs
> > > > to go into the patch_sigmatel.c file to make this thing work, I'd
> be
> > willing
> > > > to try.  I'm also more than willing to test out patches on my
> setup.
> > >
> > > The below is an entirely untested patch quickly made from the codec
> > > information you posted.  Could you give it a try with the latest
> ALSA
> > > HG version?
> >
> > Steven informed that this codec is compatible with STAC927x.
> > So the revised patch below is dramatically shorter.  Try this one
> > instead of the previous one.
> >
> >
> >
> > thanks,
> >
> > Takashi
> >
> > ---
> >
> > diff -r 19b486f73bd8 pci/hda/patch_sigmatel.c
> > --- a/pci/hda/patch_sigmatel.c  Fri Apr 25 14:25:04 2008 +0200
> >
> > +++ b/pci/hda/patch_sigmatel.c  Tue Apr 29 20:43:43 2008 +0200
> > @@ -4289,6 +4289,8 @@
> >
> >        { .id = 0x83847635, .name = "STAC9250D", .patch =
> patch_stac925x },
> >        { .id = 0x83847636, .name = "STAC9251", .patch = patch_stac925x
> },
> >        { .id = 0x83847637, .name = "STAC9250D", .patch =
> patch_stac925x },
> >
> > +       { .id = 0x83847645, .name = "92HD206X", .patch =
> patch_stac927x },
> > +       { .id = 0x83847646, .name = "92HD206D", .patch =
> patch_stac927x },
> >
> >        /* The following does not take into account .id=0x83847661 when
> > subsys =
> >         * 104D0C00 which is STAC9225s. Because of this, some SZ
> Notebooks
> > are
> >         * currently not fully supported.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> >
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
