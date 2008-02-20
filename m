From: "=?ISO-8859-1?Q?Anders_R=F8nningen?=" <andersronningen@gmail.com>
Subject: Re: Alsa-devel Digest, Vol 12, Issue 70
Date: Wed, 20 Feb 2008 13:30:06 +0100
Message-ID: <194b8d500802200430j2be27899vf5ae8a2ddaca7389@mail.gmail.com>
References: <mailman.1.1203505202.15472.alsa-devel@alsa-project.org>
Reply-To: anders.ronningen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C983103860
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 13:30:08 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so4194281wag.8
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 04:30:06 -0800 (PST)
In-Reply-To: <mailman.1.1203505202.15472.alsa-devel@alsa-project.org>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'll do the tests when I get home from work. Just wanted to check that I
understood the instructions.

The problem is like you said. The left HP and the internal speakers never
give any sound, regardless of whether the right HP is connected.

You want me to:
1. remove the mentioned line from alsa-kernel/pci/hda/patch_sigmatel.c.
2. configure and build the driver with full debug
3. reboot, run alsa-info.sh and upload the output

Is that right?

> No difference in the output but there must be a difference in the codec
setting.
You mean before and after I remove the line from patch_sigmatel.c?

>What is the original configuration of pin 0xf?
How can I know/find out this?

- Anders






On Feb 20, 2008 12:00 PM, <alsa-devel-request@alsa-project.org> wrote:

> Send Alsa-devel mailing list submissions to
>        alsa-devel@alsa-project.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> or, via email, send a message with subject or body 'help' to
>        alsa-devel-request@alsa-project.org
>
> You can reach the person managing the list at
>        alsa-devel-owner@alsa-project.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Alsa-devel digest..."
>
>
> Today's Topics:
>
>   1. Re: Problem with DELL XPS M1530 (Jiang zhe)
>   2. Re: Problem with DELL XPS M1530 (Takashi Iwai)
>   3. Re: Problem with DELL XPS M1530 (Takashi Iwai)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 20 Feb 2008 17:49:00 +0800
> From: Jiang zhe <zhe.jiang@intel.com>
> Subject: Re: [alsa-devel] Problem with DELL XPS M1530
> To: Anders R?nningen <andersronningen@gmail.com>
> Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
> Message-ID: <1203500940.3006.4.camel@localhost.localdomain>
> Content-Type: text/plain; charset=utf-8
>
> On Wed, 2008-02-20 at 02:25 +0800, Anders R?nningen wrote:
> > Hi Takashi.
> >
> > Some dmesg output:
> >
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2994:
> > autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2998:
> > speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3002:
> > hp_outs=1 (0xa/0xf/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3003:
> > mono: mono_out=0x0
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3011:
> > inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
> > [   14.196000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2224:
> > dac_nids=2 (0x5/0x4/0x0/0x0/0x0)
> >
> > Unmuted and adjusted Surround volume, but it made no difference.
> >
> > - Anders
> >
> It's weird that 0xf is in both the line_outs and hp_outs.
> And the hp_outs=1 when there are two items.
>
> What is the original configuration of pin 0xf?
> Please try to get rid of this line from the
> alsa-kernel/pci/hda/patch_sigmatel.c.
>
> SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS),
>
> Rebuild and install the driver.
> Please give the output of "cat /proc/asound/card0/codec#0".
>
> Thanks!
>
> > Takashi Iwai wrote:
> > > At Tue, 19 Feb 2008 17:24:04 +0100,
> > > Anders R?nningen wrote:
> > >
> > >> Hi. I am the mentioned user with this problem. Just thought I'd
> > give you
> > >> a little more info on this problem.
> > >>
> > >> What wishie described was correct, except it's the internal
> > speakers and
> > >> the /left/ hp-jack that stopped working, while the right one is
> > still
> > >> ok. Like he wrote, the reason we started this debugging was to get
> > mic
> > >> sound on my system. The thing I think is worth mentioning is that
> > with
> > >> alsa 1.0.14 on an out-of-the box Ubuntu Gutsy, both hp-jacks and
> > the
> > >> internal speakers worked for me. People in #alsa told me that the
> > module
> > >> was not loaded correctly, but whatever was loaded _almost_ worked
> > well :-)
> > >>
> > >
> > > OK, please build the driver with --with-debug=full option and show
> > the
> > > kernel messages such as "autoconfig: ..."  and "dac_nids...", etc.
> > > This contains the information that the pin configuration parser
> > uses.
> > >
> > > Also, unmute and adjust "Surround" volume.
> > >
> > >
> > > Takashi
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> >
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 20 Feb 2008 11:50:44 +0100
> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] Problem with DELL XPS M1530
> To: Jiang zhe <zhe.jiang@intel.com>
> Cc: alsa-devel@alsa-project.org, Anders R?nningen
>        <andersronningen@gmail.com>
> Message-ID: <s5hy79fsxyz.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=ISO-8859-1
>
> At Wed, 20 Feb 2008 17:49:00 +0800,
> Jiang zhe wrote:
> >
> > On Wed, 2008-02-20 at 02:25 +0800, Anders R?nningen wrote:
> > > Hi Takashi.
> > >
> > > Some dmesg output:
> > >
> > > [   14.192000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2994:
> > > autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
> > > [   14.192000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2998:
> > > speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
> > > [   14.192000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3002:
> > > hp_outs=1 (0xa/0xf/0x0/0x0/0x0)
> > > [   14.192000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3003:
> > > mono: mono_out=0x0
> > > [   14.192000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3011:
> > > inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
> > > [   14.196000] ALSA
> > >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2224:
> > > dac_nids=2 (0x5/0x4/0x0/0x0/0x0)
> > >
> > > Unmuted and adjusted Surround volume, but it made no difference.
> > >
> > > - Anders
> > >
> > It's weird that 0xf is in both the line_outs and hp_outs.
> > And the hp_outs=1 when there are two items.
>
> It's due to a fix for an ALC268 laptop that has also two HPs but one
> is actually a line-out.  Note that hp_outs=1 in the print above.  The
> 0x0f in hp_outs is simply a garbage.  Maybe that patch broke the
> double HPs with STAC9228...
>
>
> Takashi
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 20 Feb 2008 11:52:43 +0100
> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] Problem with DELL XPS M1530
> To: Anders R?nningen <andersronningen@gmail.com>
> Cc: alsa-devel@alsa-project.org
> Message-ID: <s5hwsozsxvo.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=ISO-8859-1
>
> At Tue, 19 Feb 2008 19:25:24 +0100,
> Anders R?nningen wrote:
> >
> > Hi Takashi.
> >
> > Some dmesg output:
> >
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2994:
> > autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2998:
> > speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3002:
> > hp_outs=1 (0xa/0xf/0x0/0x0/0x0)
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3003:
> > mono: mono_out=0x0
> > [   14.192000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3011:
> > inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
> > [   14.196000] ALSA
> >
> /mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2224:
> > dac_nids=2 (0x5/0x4/0x0/0x0/0x0)
> >
> > Unmuted and adjusted Surround volume, but it made no difference.
>
> Please upload the alsa-info.sh output again.  No difference in the
> output but there must be a difference in the codec setting.
>
> Also, just to make the situation clear:
> the problem is that the speaker and the rear HP don't give sound
> output even if you *don't* plug in the front HP, right?
>
>
> Takashi
>
>
> ------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
> End of Alsa-devel Digest, Vol 12, Issue 70
> ******************************************
>



-- 
Mvh,
Anders
