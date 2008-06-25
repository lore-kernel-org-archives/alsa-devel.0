From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [Fwd: [Alsa-user] Intel Poulsbo(SCH) chipset
	does	not recognize Adi 1986 codec under linux]]
Date: Tue, 24 Jun 2008 18:50:00 -0700
Message-ID: <1214358600.4303.155.camel@razman>
References: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CF9D24AF8
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 03:50:02 +0200 (CEST)
In-Reply-To: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kan-I Jyo <cecilhsujp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If the system you are referring to is a development platform, then it is
possible that the jumper settings on your sound board are not configured
correctly.  One simple test is to swap sound boards.  Another thing to
look at is the bios settings.  The mainstream alsa driver should not
care about the chipset revision.  But if the audio hardware is
misconfigured, that would cause it not to work.

Tobin


On Wed, 2008-06-25 at 10:40 +0900, Kan-I Jyo wrote:

> Dear list,
> 
> My original mail on this topic was posted to the alsa-user list, while
> I was informed that this alsa-devel list would be the right place to
> post.
> 
> The problem I had encountered is that the Adi 1986 codec chip on my
> device with Poulsbo(SCH) chipset could not be recognized by the
> snd_hda_intel driver module.
> 
> Tobin has kindly given me an advice on trying an ALSA driver that is
> later than 1.0.16.final. For a cross-test pupose, I have tried both
> the following 1.0.16 and the latest 1.0.17-rc2.
> 
> [1.0.16]
> ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.16.tar.bz2
> 
> [1.0.17-rc2]
> ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.17rc2.tar.bz2
> 
> By following the guide described in the INSTALL text file in both the
> above two packages, I have done make and make install without a
> problem.
> 
> Unfortunately, both these two version of ALSA driver does not
> recognized the Adi 1986 codec and in the dmesg output claiming that
> "no codecs found!".
> 
> <dmesg>
> -- snip --
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> ALSA /root/alsa-driver-1.0.16/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1887:
> hda-intel: no codecs found!
> ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> ALSA /root/alsa-driver-1.0.17rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2142:
> hda-intel: no codecs found!
> ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> -- snip --
> 
> I have also tried applying some module parameters like probe_mask and
> position_fix but with no luck.
> 
> Actually, we have two machines with Poulsbo(SCH) chipset inside. The
> ALSA driver works fine in one(with a chipset's revision of "04") while
> it does not work on the other (with a chipset's revision of "06").
> 
> Here I attach the "lspci -nnvvvxxxx" result from both two machines.
> 
> Any comment would be greatly appericiated. If anyone needs more
> information, please let me know.
> 
> 
> 
> ---------- Forwarded message ----------
> 
> 
> 2008/6/24 stan <ghjeold_i_mwee@cox.net>:
> > This is a response from the alsa-devel list.  I forwarded your message there
> > as that was the more appropriate list.
> >
> >
> > Not sure what version of alsa driver you are using, but the driver for that
> > chipset was added prior to 1.0.16 final.  Anything after that should work.
> >
> > Tobin
> >
> > On Mon, 2008-06-23 at 06:20 -0700, stan wrote:
> >
> > Sent to wrong list.
> >
> > email message attachment ([Alsa-user] Intel Poulsbo(SCH) chipset does not
> > recognize Adi 1986 codec under linux.eml)
> >
> > -------- Forwarded Message --------
> > From: Kan-I Jyo <cecilhsujp@gmail.com>
> > To: alsa-user@lists.sourceforge.net
> > Subject: [Alsa-user] Intel Poulsbo(SCH) chipset does not recognize Adi 1986
> > codec under linux
> > Date: Mon, 23 Jun 2008 20:53:42 +0900
> >
> > Dear list,
> >
> > I have recently got a device with Intel's Poulsbo chipset and Adi 1986
> > codec attatched.
> >
> > The Adi 1986 codec along with the Poulsbo chipset could been
> > recognized by installing the SoundMAX driver under Windows XP.
> >
> > While switching to Linux, the snd_intel_hda is loaded but the Adi 1986
> > codec could not been seen and there is no "codec#0" entry under
> > /proc/asound/card0.
> >
> > >From what I can see from dmesg, the hda_intel module had complained
> > about "no codecs found!".
> >
> > <dmesg.txt>
> > -- snip --
> > [   93.463277] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> > [   93.463286] Do fixup for Poulsbo <6>D0 or newer stepping
> > [   93.463439] HDA snoop disabled, try to enable ... OK
> > [   93.491624] hda-intel: no codecs found!
> > -- snip --
> >
> > I have attached both output of dmesg command the "lspci -nnvvvxxx"
> > result along with this mail. Any comment would be greatly appreciated.
> >
> > -------------------------------------------------------------------------
> > Check out the new SourceForge.net Marketplace.
> > It's the best place to buy or sell services for
> > just about anything Open Source.
> > http://sourceforge.net/services/buy/index.php
> > _______________________________________________ Alsa-user mailing list
> > Alsa-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-user
> >
> > _______________________________________________ Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > -- Tobin Davis
> >
> > 22. The only copy of Norton Utilities was on THAT disk???
> >
> >       --Top 100 things you don't want the sysadmin to say
> >
> >
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


"Well, social relevance is a schtick, like mysteries, social relevance, 
science fiction..."
-- Art Spiegelman
