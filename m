From: "j t" <mark473@gmail.com>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools ->
	usx2yloader
Date: Fri, 14 Sep 2007 10:32:58 +0100
Message-ID: <b88f52540709140232k84a2b50vf0b2efa55996d31b@mail.gmail.com>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
	<20070912205256.GR4125@frodo.home.lxtec.de>
	<8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
	<20070913093252.GA7645@aragorn.home.lxtec.de>
	<8e4fc8270709140145u2dc5a2cbq2f9fba4c77f2c692@mail.gmail.com>
	<b88f52540709140229q73df2dedmf9ba464160456e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C28722447A
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 11:32:59 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so944470wag
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 02:32:58 -0700 (PDT)
In-Reply-To: <b88f52540709140229q73df2dedmf9ba464160456e5b@mail.gmail.com>
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
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>, 436502@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

On 9/14/07, j t <mark473@gmail.com> wrote:
> On 9/14/07, Michael Bourgeous <sts.nitrogen@gmail.com> wrote:
> > I just spent the last three hours trying to fix this problem, and I
> > can only come to the conclusion that udev is horribly broken.  For
> > example, my firmware load rule gets called not only when the USB
> > device comes on, but each time ALSA adds a new device from the usx2y
> > (i.e. control, mixer, PCM, etc.), resulting in a lot of wasted time,
> > and many erroneous calls to usx2yloader.  Moreover, the rule gets
> > called once for every device /removed/, even though it says
> > ACTION="add".  Finally, it seems that every now and then, udev tries
> > the whole process over again, even though the firmware is loaded and
> > us428control is running.  Why do we have to keep breaking things that
> > work?
>
> I'm not sure whether it will help you, but I had similar problems when
> I converted over to udev - I ended up using the following as the rule:
>
> ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idProduct}=="8006",
> SYSFS{idVendor}=="1604", RUN+="/lib/udev/tascam"
>
> If I didn't do this, then udev called /lib/udev/tascam too many times
> (more than once!).
>
> I can't help right now, but I will have a look at this over this
> weekend to see if it still works.
>
> HTH, Jaime
>

Ooops, sorry - my bad... :-( I included the wrong line. Try this:

ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idProduct}=="8007",
SYSFS{idVendor}=="1604", RUN+="/usr/bin/usx2yloader"

That's better :-)
