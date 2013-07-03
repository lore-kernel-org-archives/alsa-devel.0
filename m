From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: no analog playback device for HDA STAC9221 inside
 VirtualBox 4.2.14
Date: Wed, 3 Jul 2013 16:13:26 +0800
Message-ID: <CAN8cciZ8encGDRTSPFkjrkQHzGvRmLTn=h8-Hwt50+xxVp7zgg@mail.gmail.com>
References: <CAN8ccib1qrJ5jNXYeo45KBX5wDKNeFp59dU0_ecXs16kBEgxsA@mail.gmail.com>
 <s5hip0ty1hq.wl%tiwai@suse.de>
 <CAN8ccibgA3NFouZVJZd6tuFEEP51ZYtY=F-0YQ59zpUt5UDr1g@mail.gmail.com>
 <s5hehbhxzpx.wl%tiwai@suse.de>
 <CAN8cciYm9v5Ey3VsOaJLB8SzQgOvnmuNYjQRhjY_exAURfj_kg@mail.gmail.com>
 <s5htxkdf6ok.wl%tiwai@suse.de> <s5hr4fhf4rh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id CA75E26552D
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 10:13:27 +0200 (CEST)
Received: by mail-ie0-f171.google.com with SMTP id qd12so15065886ieb.30
 for <alsa-devel@alsa-project.org>; Wed, 03 Jul 2013 01:13:27 -0700 (PDT)
In-Reply-To: <s5hr4fhf4rh.wl%tiwai@suse.de>
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

> > > > > > >
> > > > > > > HDA STAC9221 audio work for (64bit) Fedora 16, Ubuntu 11.10 and
> > > > Opensuse
> > > > > > > 11.4 Live CD inside virtualbox 4.2.14
> > > > > > >
> > > > > > > no sound for this emulated HDA sound card since Ubuntu 12.04
> Live CD
> > > > > > >
> > > > > > > No analog playback device  for Saucy or Fedora 19 Live CD
> > > > > >
> > > > > > It looks strange that VirtualBox sets up the pins for 5.1
> speaker +
> > > > > > headphone.  Is this really the wanted setup as a virtual machine?
> > > > > >
> > > > > > Some truncated control names found in alsa-info.sh output should
> have
> > > > > > been fixed in sound git tree now.
> > > > > >
> > > > > >
> > > > > it work with opensuse 11.4 for both HDA and AC97 , but no sound
> card
> > > > > modules loaded in opensuse 12.3 Live CD
> > > >
> > > > Well, it doesn't clarify whether the culprit is VirtualBox's change
> or
> > > > HD-audio driver's change at all...  How did 11.4 work?  Did it work
> > > > with 5.1 + headphone setup in VME?
> > > >
> > >
> > > it only support stereo in 11.4
> > >
> > > analog playback device still appear in Ubuntu 13.04 (before sigmtel use
> > > auto generic parser)
> >
> > Are you really sure that it's due to the generic parser?
> > Judging from alsa-info.sh output, the pin default config values are
> > different between working and non-working cases.  This has nothing to
> > do with which parse to use.
> >
> > Try the later kernel with the working environment.
>
> Looking at the alsa-info output from openSUSE 11.4 again, this seems
> to be the case where the old parser did handle wrongly.  Namely, it
> took the pin config for STAC_INTEL_MAC_V3 as fallback since it has the
> same PCI SSID although it has no proper codec SSID for Apple.  Thus on
> old kernels, it overrides the pin config for Intel-Mac, eventually
> worked more or less better than the default pin config VirtualBox
> provides.
>
> That being said, this is highly likely a bug in VirtualBox BIOS.
>
> You can try to load snd-hda-intel with model=intel-mac-v3.  This sets
> the pin config the old kernel used.
>
>
>
Thanks, analog playback device appear after specify model=intel-mac-v3

Audio still work with opensuse 12.1 Live CD

speaker-test hang and no sound with opensuse 12.2 Live CD

Only headphone playback volume and master playback volume of the emulated
STAC9221 affect the volume in 11.4 and 12.1 , the speaker playback have no
effect

And the emulated codec alway report headphone jack present

seem change in hda-intel.c (between opensuse 12.1 and 12.2)  cause the hang
problem
