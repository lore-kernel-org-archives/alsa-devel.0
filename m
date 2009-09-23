From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#547994: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 20:08:42 +0200
Message-ID: <20090923180842.GE4488@aragorn.home.lxtec.de>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de>
	<20090923170635.GD4488@aragorn.home.lxtec.de>
	<604760770909231011t1b05c01dn79d94f8a021a1884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250])
	by alsa0.perex.cz (Postfix) with ESMTP id AC420103874
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 20:08:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <604760770909231011t1b05c01dn79d94f8a021a1884@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>, 547994@bugs.debian.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

* Daniel Chen [090923 13:11 -0400]
> On Wed, Sep 23, 2009 at 1:06 PM, Elimar Riesebieter <riesebie@lxtec.de> w=
rote:
> >> > There are
> >> > users with chips like an
> >> >
> >> > 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audi=
o Controller (rev 03)
> >> > =A0 =A0 =A0 =A0 Subsystem: Hewlett-Packard Company Device 30f7
> ...
> > Which QUIRK Table. What informations from the soundcard ist needed
> > and how to get it?
> =

> Elimar,
> =

> See http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Db=
lob;f=3Dsound/pci/hda/hda_intel.c;h=3D20a66f85f0a4247b317d8bbd9e68dafe107e8=
92e;hb=3DHEAD#l2305
> =

> Use the SSID for an entry, e.g.,
> =

> SND_PCI_QUIRK(0x103c, 0x30f7, "HP", 1),

Does an easy QUIRK entry enables msi?

Elimar


-- =

  We all know Linux is great... it does infinite loops in 5 seconds.
        -- Linus Torvalds
