From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 3/3] ALSA: firewire-motu: constify snd_rawmidi_ops
 structures
Date: Tue, 15 Aug 2017 11:00:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708151058560.3849@hadrien>
References: <1502784594-14670-3-git-send-email-Julia.Lawall@lip6.fr> <s5ho9rhi519.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ho9rhi519.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, bhumirks@gmail.com, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Tue, 15 Aug 2017, Takashi Iwai wrote:

> On Tue, 15 Aug 2017 10:09:54 +0200,
> Julia Lawall wrote:
> >
> > These snd_rawmidi_ops structures are only passed as the third
> > argument of snd_rawmidi_set_ops.  This argument is const, so the
> > snd_rawmidi_ops structures can be const too.
> >
> > Done with the help of Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> What are other two patches?  Since I haven't received a cover letter,
> no idea whether I overlooked them or not relevant with my tree...

Oops, I forgot to make a cover letter for this.  The others are:

drivers/hid/hid-prodikeys.c
drivers/usb/gadget/function/f_midi.c

julia
