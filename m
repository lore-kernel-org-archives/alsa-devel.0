From: "Greg Zornetzer" <gzornetzer.lists@gmail.com>
Subject: Re: help with idt 92hd206 codec for intel hda?
Date: Fri, 2 May 2008 00:24:16 -0700
Message-ID: <95ce66d80805020024i3e97cfaawf4f89120f99f1002@mail.gmail.com>
References: <95ce66d80804262338k536d763bweca4e7d6ff39e06d@mail.gmail.com>
	<s5h1w4oy84a.wl%tiwai@suse.de> <s5hod7swquv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 4809D249F6
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 09:24:18 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 28so1520002wfa.23
	for <alsa-devel@alsa-project.org>; Fri, 02 May 2008 00:24:17 -0700 (PDT)
In-Reply-To: <s5hod7swquv.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Tellman, Steven" <Steven.Tellman@idt.com>, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Steven, et al,
My apologies for not getting back to you earlier.
I applied the short patch to the hg-20080502 snapshot.  That seems to have
done the trick.  All of the different analog output channels are now
available, as well as a bunch of input channels.  I only tested output, but
that seemed to work. I will hopefully be able to test the inputs this
weekend.  Given the discussion that I saw, it looks like I won't bother with
the digital output.
Thanks very much for your help on this.
-Greg

On Tue, Apr 29, 2008 at 9:47 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 29 Apr 2008 17:48:53 +0200,
> I wrote:
> >
> > At Sun, 27 Apr 2008 01:38:19 -0500,
> > Greg Zornetzer wrote:
> > >
> > > Hi all,
> > > I recently acquired an ECS GF7100PVT-M3 motherboard, which appears to
> use
> > > the IDT 92HD206 codec for HDA.  Unfortunately, it doesn't appear to
> have
> > > full support under ALSA.  It gets detected as another Sigmatel chip.
>  Analog
> > > stereo output appears to work, but the mixer doesn't find any of the
> normal
> > > inputs.
> > >
> > > I found the tech specs for the chip at
> > > http://www.idt.com/products/getDoc.cfm?docID=13461840
> > > I've attached an lspci output and the codec file to this email.  I'm
> not
> > > much of an driver hacker, but if someone could give me an idea of what
> needs
> > > to go into the patch_sigmatel.c file to make this thing work, I'd be
> willing
> > > to try.  I'm also more than willing to test out patches on my setup.
> >
> > The below is an entirely untested patch quickly made from the codec
> > information you posted.  Could you give it a try with the latest ALSA
> > HG version?
>
> Steven informed that this codec is compatible with STAC927x.
> So the revised patch below is dramatically shorter.  Try this one
> instead of the previous one.
>
>
> thanks,
>
> Takashi
>
> ---
>
> diff -r 19b486f73bd8 pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c  Fri Apr 25 14:25:04 2008 +0200
> +++ b/pci/hda/patch_sigmatel.c  Tue Apr 29 20:43:43 2008 +0200
> @@ -4289,6 +4289,8 @@
>         { .id = 0x83847635, .name = "STAC9250D", .patch = patch_stac925x
> },
>        { .id = 0x83847636, .name = "STAC9251", .patch = patch_stac925x },
>        { .id = 0x83847637, .name = "STAC9250D", .patch = patch_stac925x },
> +       { .id = 0x83847645, .name = "92HD206X", .patch = patch_stac927x },
> +       { .id = 0x83847646, .name = "92HD206D", .patch = patch_stac927x },
>         /* The following does not take into account .id=0x83847661 when
> subsys =
>         * 104D0C00 which is STAC9225s. Because of this, some SZ Notebooks
> are
>         * currently not fully supported.
>
