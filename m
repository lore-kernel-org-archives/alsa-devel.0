From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Mon, 20 Oct 2014 09:10:05 +0800
Message-ID: <CAN8cciaY_+_XZh2UkPGvewr6Ccp+UM0Dg-67hyg5L_wFW-NpFQ@mail.gmail.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
 <543FDFDE.7040800@canonical.com>
 <CAN8cciaUo7BOxSMBtiysYi9MsW=ZAWn0s3tHTc5-YmpWWvEJNg@mail.gmail.com>
 <s5hlhodteq7.wl-tiwai@suse.de>
 <CAN8ccib4fhvvtYW7sjDZXA9QETgOTL+wA=u6iSv0yRHtwWPfwQ@mail.gmail.com>
 <s5hh9z0totl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B21260494
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 03:17:37 +0200 (CEST)
Received: by mail-qa0-f43.google.com with SMTP id s7so2756124qap.30
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 18:17:36 -0700 (PDT)
In-Reply-To: <s5hh9z0totl.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, vdjkelly@gmail.com
Cc: alsa-devel@alsa-project.org, ruedi@battle-eggs.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > > >
> > > > >> >
> > > > >> > In the scenario where there is one "Line Out", one "Speaker"
and
> > one
> > > > >> > "Headphone", and there are only two DACs, two outputs will
share a
> > DAC.
> > > > >> > Currently any mixer on such a DAC will get the "PCM" name,
which is
> > > > >> > misleading. Instead use "Headphone+LO" or "Speaker+LO" to
better
> > > > >> > specify what the volume actually controls.
> > > > >>
> > > > >> Are there any examples ?
> > > > >>
> > > > >
> > > > > I used "hda-emu
> > > > codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i
1"
> > when
> > > > developing the patches.
> > > > >
> > > > > I don't have any hardware available myself that exposes this
behavior,
> > > > but I can maybe fake one with hdajackretask, if that counts...
> > > > >
> > > >
> > > > How about adding these names to slaves of virtual master
volume/switch ?
> > > >
> > > > hdajackretask won't help if the topology of the codecs are
different
> > > >
> > > > Seem the badness still prevent the driver to support surround 5.1
with
> > > > three rear panel jacks, internal speaker and front panel headphone
for
> > > > Thinkcenter A58 using alc662
> > > >
> > > >
> >
https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29203.html
> > > >
> > > > Why 3stack desktops with 6 channels codecs not using
"Headphone+LO"  or
> > > > "Speaker+LO" ?
> > >
> > > The problem is just the lack of DACs, so it cannot cover all three
> > > outputs, no matter how the pins are chosen.  That is, it's no 6
> > > channels at all but 4 channels at most.
> > >
> > >
> >
> >http://shop.lenovo.com/us/en/desktops/thinkcentre/a-series/a58/
> >
> > The technical specification of a58
> >
> > 2 pin internal speaker connector
> > Alc662 5.1
> >
> >https://bbs.archlinux.org/viewtopic.php?id=156433
> >
> > Seem windows support surround 5.1
>
> ALC662 has three DACs, so it's a different problem, if any.
> ALC269 and its variants have only two DACs.
>
>

These two patches not only affect those four channels hda codecs notebook
with dock station or desktop with internal speaker, it also affect some
codecs in hda-emu/codecs

1) two channels hda codec such as stac9200 (e.g Dell precision 490
workstation)
2) 8 channels codecs such as stac9228, cmi9880 (e.g. lg-lw60 and dell xps)

The proposed patches still not able to handle the case when line out ,
headphone and speaker share the same volume control

Refer to hardware mainteance manual of a58, there is only one internal
speaker , it is most likely a mono speaker if it use a two pin internal
speaker connector

http://www.desktopreview.com/default.asp?newsID=760&Review+Lenovo+ThinkCentre+A58

Here you can see the built-in speaker in the lower right

It is unlikely for  stereo speaker to use two pin connector

Other Thinkcenter with 6 channels ad1986a has enough volume controls for
line out, headphone and speaker

https://answers.launchpad.net/ubuntu/+source/alsa-driver/+question/146830
