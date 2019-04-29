From: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH] ALSA: usx2y: fix a memory leak bug
Date: Mon, 29 Apr 2019 00:50:11 -0500
Message-ID: <CAAa=b7f7MMJ=2PBxz8yYM6u2SX7T2-YnC37gbapc1f9HOPQdeA@mail.gmail.com>
References: <1556433754-3291-1-git-send-email-wang6495@umn.edu>
 <s5hd0l6mwbz.wl-tiwai@suse.de> <s5ha7g9l6ea.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha7g9l6ea.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Jaroslav Kysela <perex@perex.cz>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 29, 2019 at 12:36 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 28 Apr 2019 09:18:40 +0200,
> Takashi Iwai wrote:
> >
> > On Sun, 28 Apr 2019 08:42:32 +0200,
> > Wenwen Wang wrote:
> > >
> > > In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
> > > and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
> > > kmalloc() and saved to 'usX2Y->In04Buf'. After the urb is initialized, a
> > > sanity check is performed for the endpoint in the urb by invoking
> > > usb_urb_ep_type_check(). If the check fails, the error code EINVAL will be
> > > returned. In that case, however, the created urb and the allocated buffer
> > > are not freed, leading to memory leaks.
> > >
> > > To fix the above issue, free the urb and the buffer if the check fails.
> > >
> > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> >
> > Applied now, thanks.
>
> ... and looking at the code again, this patch turned out to be wrong.
> The in04 urb and transfer buffer are freed at card->private_free
> callback (snd_usX2Y_card_private_free()) later, so this patch would
> lead to double-free.

Thanks for your comment! Does that mean we should remove
usb_free_urb() in the if statement of allocating 'usX2Y->In04Buf',
because it may also lead to double free?

Wenwen
