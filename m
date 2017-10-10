From: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/9] ALSA: bcd2000: Add a sanity check for invalid EPs
Date: Tue, 10 Oct 2017 16:00:25 +0200
Message-ID: <CAAeHK+wM6JtoNFsaXWUWmrFgcRQj9b8RaH-+1VF4mO=YiijH1g@mail.gmail.com>
References: <20171010133819.10567-1-tiwai@suse.de> <20171010133819.10567-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171010133819.10567-3-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 3:38 PM, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org> wrote:
> As syzkaller spotted, currently bcd2000 driver submits a URB with the
> fixed EP without checking whether it's actually available, which may
> result in a kernel warning like:
>   usb 1-1: BOGUS urb xfer, pipe 1 != type 3
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1846 at drivers/usb/core/urb.c:449
>   usb_submit_urb+0xf8a/0x11d0
>   Modules linked in:
>   CPU: 0 PID: 1846 Comm: kworker/0:2 Not tainted
>   4.14.0-rc2-42613-g1488251d1a98 #238
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    bcd2000_init_device sound/usb/bcd2000/bcd2000.c:289
>    bcd2000_init_midi sound/usb/bcd2000/bcd2000.c:345
>    bcd2000_probe+0xe64/0x19e0 sound/usb/bcd2000/bcd2000.c:406
>    usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>    ....
>
> This patch adds a sanity check of validity of EPs at the device
> initialization phase for avoiding the call with an invalid EP.
>
> Reported-by: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>

Hi Takashi,

I've applied patches #1 and #2 and for some reason get this when I try
to build the kernel:

  LD      vmlinux.o
  MODPOST vmlinux.o
sound/usb/bcd2000/bcd2000.o: In function `bcd2000_init_midi':
.../sound/usb/bcd2000/bcd2000.c:346: undefined reference to
`usb_urb_ep_type_check'
.../sound/usb/bcd2000/bcd2000.c:347: undefined reference to
`usb_urb_ep_type_check'
make: *** [vmlinux] Error 1

What could be wrong?

Thanks!

> ---
>  sound/usb/bcd2000/bcd2000.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
> index 7371e5b06035..a6408209d7f1 100644
> --- a/sound/usb/bcd2000/bcd2000.c
> +++ b/sound/usb/bcd2000/bcd2000.c
> @@ -342,6 +342,13 @@ static int bcd2000_init_midi(struct bcd2000 *bcd2k)
>                                 bcd2k->midi_out_buf, BUFSIZE,
>                                 bcd2000_output_complete, bcd2k, 1);
>
> +       /* sanity checks of EPs before actually submitting */
> +       if (usb_urb_ep_type_check(bcd2k->midi_in_urb) ||
> +           usb_urb_ep_type_check(bcd2k->midi_out_urb)) {
> +               dev_err(&bcd2k->dev->dev, "invalid MIDI EP\n");
> +               return -EINVAL;
> +       }
> +
>         bcd2000_init_device(bcd2k);
>
>         return 0;
> --
> 2.14.2
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
