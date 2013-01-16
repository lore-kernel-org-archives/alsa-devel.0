From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Wed, 16 Jan 2013 10:04:32 +0800
Message-ID: <CAN8ccibNXXJ8-jksY4d735Ub2QeNA8nyqUbaMvJp_o1W1yOLpA@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <s5hk3rgc9hb.wl%tiwai@suse.de>
 <CAN8ccia3tfcU6XkRBKhKjY-f_HjkkphXo_UEntVOns4sXZk2+A@mail.gmail.com>
 <s5htxqjc0gs.wl%tiwai@suse.de> <s5hobgqj2qm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id B9FDE2616B2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 03:04:33 +0100 (CET)
Received: by mail-ie0-f172.google.com with SMTP id c13so1560478ieb.3
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 18:04:33 -0800 (PST)
In-Reply-To: <s5hobgqj2qm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, diaz.manolo@gmail.com, r.kreis@uni-bremen.de, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > >
> > > > Yes, testing the latest code with real machines is highly
> > > > appreciated.  Try sound-unstable git tree, either master or
> > > > test/hda-migrate branch.
> > > >   git://
git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
> > > >
> > > > Alternatively you can build the external alsa-driver modules from
> > > > alsa-driver-unstable snapshot tarball, too
> > > >
> > >
ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> > > >
> > > > Note that only the behavior of model=auto has been changed in the
tree
> > > > above.  The other model behaviors of AD codecs are unchanged at all.

>
> Never mind, I patched by myself now.  It's found in
> test/hda-gen-parser branch of sound-unstable git tree.
>

http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=blob_plain;f=codecs/ad1988b-asus-p5b-deluxe-wifi;hb=HEAD

https://launchpadlibrarian.net/73038045/Card0.Codecs.codec.0.txt

How about this node of Asus P5B [1043:81ec] and P5B DELUXE WIFI ? Two
line-in in input source

Node 0x1a [Pin Complex] wcaps 0x400000: Mono Pincap 0x00000020: IN Pin
Default 0x918711f0: [Fixed] Line In at Int Rear Conn = Analog, Color =
Black DefAssociation = 0xf, Sequence = 0x0 Misc = NO_PRESENCE Pin-ctls:
0x20: IN

http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=blob_plain;f=codecs/ad1988a;hb=HEAD

Node 0x1a [Pin Complex] wcaps 0x400000: Mono Pincap 0x0820: IN Pin Default
0x99f301f0: [Fixed] Other at Int ATAPI Conn = ATAPI, Color = Unknown
Pin-ctls: 0x20: IN
