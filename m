From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 12:09:46 +0200
Message-ID: <20100414100946.GS30807@buzzloop.caiaq.de>
References: <20100412162947.GQ18855@one.firstfloor.org>
	<Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org>
	<20100413182233.GR30807@buzzloop.caiaq.de>
	<k2o74fd948d1004131646k1e0e1897z7594f77a580c6b9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B3C11038B9
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 12:09:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <k2o74fd948d1004131646k1e0e1897z7594f77a580c6b9f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 14, 2010 at 12:46:42AM +0100, Pedro Ribeiro wrote:
> On 13 April 2010 19:22, Daniel Mack <daniel@caiaq.de> wrote:
> > Some more ideas to nail this down would be to boot the machine with
> > mem=3D4096M and mem=3D2048M to see whether this makes any difference. A=
lso,
> > I think it would be interesting to know whether the patch below helps.
> >
> > As the real reason seems entirely obfuscated, there's unfortunately need
> > for some trial error approach. Pedro, as you're the only one who can
> > actually reproduce the problem, do you see any chance to do that?
> >
> > Thanks,
> > Daniel
> >
> >
> > diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
> > index 4328cad..26013be 100644
> > --- a/sound/usb/caiaq/audio.c
> > +++ b/sound/usb/caiaq/audio.c
> > @@ -560,7 +560,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaq=
dev *dev, int dir, int *ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urbs[i]->transfer_buffer =3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB * =
BYTES_PER_FRAME, GFP_KERNEL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB * =
BYTES_PER_FRAME, GFP_KERNEL | GFP_DMA);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!urbs[i]->transfer_buffer) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0log("unable to kmalloc()=
 transfer buffer, OOM!?\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ret =3D -ENOMEM;
> >
> >
> =

> Good news, I can't trigger the interference with either:
> - mem=3D2048m
> - mem=3D4096m
> - your patch

Thanks! So the only thing I can do for now is submit exactly this patch.
At least, it helps you and it shouldn't break anything. The question
remains whether this type of memory should be used for all
transfer_buffers.

> Any idea why is mem=3D4096m different than a regular boot since I have 4G=
B anyway?

On Fri, Apr 09, 2010 at 04:11:52PM -0600, Robert Hancock wrote:
> If you have 4GB of RAM then almost certainly you have memory located
> at addresses over 4GB. If you look at the e820 memory map printed at
> the start of dmesg on bootup and see entries with addresses of
> 100000000 or higher reported as usable, then this is the case.

Could you post the these e820 line from your dmesg when booted with
mem=3D4096?

Daniel
