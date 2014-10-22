From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Wed, 22 Oct 2014 15:43:29 +0800
Message-ID: <CAN8ccibCWqwrWEPZ-mG6YuA8ZQyidvO5fn_w6jbizSyu-Bz_bw@mail.gmail.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
 <543FDFDE.7040800@canonical.com>
 <CAN8cciaUo7BOxSMBtiysYi9MsW=ZAWn0s3tHTc5-YmpWWvEJNg@mail.gmail.com>
 <s5hlhodteq7.wl-tiwai@suse.de>
 <CAN8ccib4fhvvtYW7sjDZXA9QETgOTL+wA=u6iSv0yRHtwWPfwQ@mail.gmail.com>
 <5444ABDA.7070207@canonical.com>
 <CAN8cciYCSd8QqHNZ=7ip_-YnG1ru9jJ3rjW8S_YjyrhRLGBFzA@mail.gmail.com>
 <s5hlhob3vvj.wl-tiwai@suse.de>
 <CAN8cciZ05e49cpBbDSLLz+mte5Zx4v4VNAJMH5BA77+0vKQKRw@mail.gmail.com>
 <s5hwq7vklmm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0AF261B28
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 09:43:29 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id x3so2180146qcv.24
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 00:43:29 -0700 (PDT)
In-Reply-To: <s5hwq7vklmm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, ruedi@battle-eggs.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > > >
> > > > >>
> > > > >>
> > > > >>  > >
> > > > >>  > > >> >
> > > > >>  > > >> > In the scenario where there is one "Line Out", one
> > "Speaker"
> > > > >> and one
> > > > >>  > > >> > "Headphone", and there are only two DACs, two outputs
will
> > > > >> share a DAC.
> > > > >>  > > >> > Currently any mixer on such a DAC will get the "PCM"
name,
> > > > >> which is
> > > > >>  > > >> > misleading. Instead use "Headphone+LO" or "Speaker+LO"
to
> > > > better
> > > > >>  > > >> > specify what the volume actually controls.
> > > > >>  > > >>
> > > > >>  > > >> Are there any examples ?
> > > > >>  > > >>
> > > > >>  > > >
> > > > >>  > > > I used "hda-emu
> > > > >>  > >
> > codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i
> > > > >> 1" when
> > > > >>  > > developing the patches.
> > > > >>  > > >
> > > > >>  > > > I don't have any hardware available myself that exposes
this
> > > > >> behavior,
> > > > >>  > > but I can maybe fake one with hdajackretask, if that
counts...
> > > > >>  > > >
> > > > >>  > >
> > > > >>  > > How about adding these names to slaves of virtual master
> > > > >> volume/switch ?
> > > > >>  > >
> > > > >>  > > hdajackretask won't help if the topology of the codecs are
> > > > different
> > > > >>  > >
> > > > >>  > > Seem the badness still prevent the driver to support
surround
> > 5.1
> > > > with
> > > > >>  > > three rear panel jacks, internal speaker and front panel
> > headphone
> > > > for
> > > > >>  > > Thinkcenter A58 using alc662
> > > > >>  > >
> > > > >>  > >
> > > > >>
> > > >
> >
https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29203.html
> > > > >>  > >
> > > > >>  > > Why 3stack desktops with 6 channels codecs not using
> > > > >> "Headphone+LO"  or
> > > > >>  > > "Speaker+LO" ?
> > > > >>  >
> > > > >>  > The problem is just the lack of DACs, so it cannot cover all
three
> > > > >>  > outputs, no matter how the pins are chosen.  That is, it's no
6
> > > > >>  > channels at all but 4 channels at most.
> > > > >>  >
> > > > >>  >
> > > > >>
> > > > >> http://shop.lenovo.com/us/en/desktops/thinkcentre/a-series/a58/
> > > > >>
> > > > >> The technical specification of a58
> > > > >>
> > > > >> 2 pin internal speaker connector
> > > > >> Alc662 5.1
> > > > >>
> > > > >> https://bbs.archlinux.org/viewtopic.php?id=156433
> > > > >>
> > > > >> Seem windows support surround 5.1
> > > > >
> > > > >
> > > > > Raymond, there can certainly be cases which this patch does not
cover
> > -
> > > > after all, it's mostly a band aid given the lack of topology
> > information -
> > > > but do you see cases where this patch actually causes a
*regression*? If
> > > > so, could you point me to alsa-info for the machine where this patch
> > causes
> > > > a regression?
> > > > >
> > > >
> > > >
> >
www.realtek.com.tw/products/productsView.aspx?Langid=1&PNid=24&PFid=27&Level=5&Conn=4
> > > >
> > > > I expect those desktop with 2+2 HD Audio codec support independent
> > headphone
> > > >
> > > > This mean the driver should not create "Lineout+HP" Playback volume
> > > >
> > > > Line out and headphone cannot share same DAC
> > >
> > > Do you have a pincfg representing this?  Then we can check it easily
> > > via hda-emu.
> > >
> >
> >
http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/canonical/alc221--hp-prodesk-400-g1-sff-ccert-201408-15383?id=HEAD
>
> Both HP (0x21) and LO (0x14) can share the same DAC (0x03) over mixer
> (0x0d).  So the statement above "Line out and headphone cannot share
> same DAC" isn't correct.
>
> > Refer to user manual
> >
> > Multi-streaming can be enabled in the Realtek control panel to allow
> > independent audio streams to be sent to/from the front and rear jacks
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_via.c?id=2525050518496dfd6905abfa8d6d34288eed36d7

Do it mean that the volume control should be named as "Headphone+Side" ?
