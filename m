From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: no analog playback device for HDA STAC9221 inside
 VirtualBox 4.2.14
Date: Tue, 2 Jul 2013 20:47:21 +0800
Message-ID: <CAN8cciYm9v5Ey3VsOaJLB8SzQgOvnmuNYjQRhjY_exAURfj_kg@mail.gmail.com>
References: <CAN8ccib1qrJ5jNXYeo45KBX5wDKNeFp59dU0_ecXs16kBEgxsA@mail.gmail.com>
 <s5hip0ty1hq.wl%tiwai@suse.de>
 <CAN8ccibgA3NFouZVJZd6tuFEEP51ZYtY=F-0YQ59zpUt5UDr1g@mail.gmail.com>
 <s5hehbhxzpx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id DCAA726545C
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 14:47:22 +0200 (CEST)
Received: by mail-ie0-f173.google.com with SMTP id k13so11831043iea.4
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2013 05:47:22 -0700 (PDT)
In-Reply-To: <s5hehbhxzpx.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > >
> > > > HDA STAC9221 audio work for (64bit) Fedora 16, Ubuntu 11.10 and
> Opensuse
> > > > 11.4 Live CD inside virtualbox 4.2.14
> > > >
> > > > no sound for this emulated HDA sound card since Ubuntu 12.04 Live CD
> > > >
> > > > No analog playback device  for Saucy or Fedora 19 Live CD
> > >
> > > It looks strange that VirtualBox sets up the pins for 5.1 speaker +
> > > headphone.  Is this really the wanted setup as a virtual machine?
> > >
> > > Some truncated control names found in alsa-info.sh output should have
> > > been fixed in sound git tree now.
> > >
> > >
> > it work with opensuse 11.4 for both HDA and AC97 , but no sound card
> > modules loaded in opensuse 12.3 Live CD
>
> Well, it doesn't clarify whether the culprit is VirtualBox's change or
> HD-audio driver's change at all...  How did 11.4 work?  Did it work
> with 5.1 + headphone setup in VME?
>

it only support stereo in 11.4

analog playback device still appear in Ubuntu 13.04 (before sigmtel use
auto generic parser)

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_sigmatel.c?id=0a4278464eba4bf98c0d6304c62a1116553125d3

https://www.virtualbox.org/browser/vbox/trunk/src/VBox/Devices/Audio/DevIchHdaCodec.cpp

https://www.virtualbox.org/browser/vbox/trunk/src/VBox/Devices/Audio/DevIchHda.cpp
