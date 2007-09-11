From: "James Pearson" <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
	and snd-ioctl32
Date: Tue, 11 Sep 2007 22:56:16 +0100
Message-ID: <a92ebfd90709111456w6b02fb42l665e806b7ba898e2@mail.gmail.com>
References: <46DE8EB0.90208@moving-picture.com> <s5hd4wx8ec0.wl%tiwai@suse.de>
	<46DEBF69.6070307@moving-picture.com>
	<s5hodgh6sqf.wl%tiwai@suse.de>
	<46DECCEA.4060306@moving-picture.com> <s5hk5r56qin.wl%tiwai@suse.de>
	<46DEDF4B.7050108@moving-picture.com>
Reply-To: james-p@moving-picture.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CF3310381D
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 23:56:17 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so5128nzf
	for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2007 14:56:16 -0700 (PDT)
In-Reply-To: <46DEDF4B.7050108@moving-picture.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/09/2007, James Pearson <james-p@moving-picture.com> wrote:
> Takashi Iwai wrote:
> >
> > Does the patch (to alsa-driver tree) fix the problem?
> >
> >
> > Takashi
> >
> > diff -r adfe4179d670 misc/ac97_bus.c
> > --- a/misc/ac97_bus.c Fri Aug 31 12:22:35 2007 +0200
> > +++ b/misc/ac97_bus.c Wed Sep 05 18:09:42 2007 +0200
> > @@ -1,1 +1,3 @@
> > +#include <sound/driver.h>
> > +#include <sound/core.h>
> >  #include "../alsa-kernel/ac97_bus.c"
>
> Yes ... I did something similar - copied in ../alsa-kernel/ac97_bus.c
> and patched with alsa-driver-1.0.13/pci/ac97/ac97_bus.patch - which
> makes it compile

Just to follow up on this, your patch that just adds:

#include <sound/driver.h>
#include <sound/core.h>

to misc/ac97_bus.c is not enough for it to compile on RHEL4/CentOS4
... however, copying in ../alsa-kernel/ac97_bus.c and patching with
alsa-driver-1.0.13/pci/ac97/ac97_bus.patch does work. It still needs
the #ifdef CONFIG_SND_OLD_DRIVER_SUSPEND stuff

James Pearson
