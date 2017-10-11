From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 4/9] ALSA: line6: Add a sanity check for
	invalid EPs
Date: Wed, 11 Oct 2017 16:28:37 +0200
Message-ID: <20171011142837.GZ4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A75266CA1
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 16:28:35 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id j73so805830lfg.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 07:28:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171011103646.11879-5-tiwai@suse.de>
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
Cc: Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 12:36:41PM +0200, Takashi Iwai wrote:
> As syzkaller spotted, currently line6 drivers submit a URB with the
> fixed EP without checking whether it's actually available, which may
> result in a kernel warning like:
>   usb 1-1: BOGUS urb xfer, pipe 3 != type 1
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:449
>   usb_submit_urb+0xf8a/0x11d0
>   Modules linked in:
>   CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42613-g1488251d1a98 #238
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    line6_start_listen+0x55f/0x9e0 sound/usb/line6/driver.c:82
>    line6_init_cap_control sound/usb/line6/driver.c:690
>    line6_probe+0x7c9/0x1310 sound/usb/line6/driver.c:764
>    podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
>    usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>    ....
> 
> This patch adds a sanity check of validity of EPs at the device
> initialization phase for avoiding the call with an invalid EP.
> 
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/line6/driver.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 0ff5a7d2e19f..0da6f68761e3 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -78,6 +78,13 @@ static int line6_start_listen(struct usb_line6 *line6)
>  			line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
>  			line6_data_received, line6);
>  	}
> +
> +	/* sanity checks of EP before actually submitting */
> +	if (usb_urb_ep_type_check(line6->urb_listen)) {
> +		dev_err(line6->ifcdev, "invalid control EP\n");
> +		return -EINVAL;
> +	}

You're now doing this check twice (here and in usb_submit_urb) every
time this URB is submitted rather just checking it once in probe.

Seems like a quick band-aid to me.

> +
>  	line6->urb_listen->actual_length = 0;
>  	err = usb_submit_urb(line6->urb_listen, GFP_ATOMIC);
>  	return err;

Johan
