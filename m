From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 01/17] ALSA: line6: Split to each driver
Date: Mon, 19 Jan 2015 12:00:01 -0600
Message-ID: <CAEUsAPaw922VsU-00--auMaxW+RZYJKnKFB40jZGNFxkT8PEgg@mail.gmail.com>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
 <1421682891-11594-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B681626063A
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 19:00:02 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id v10so24964265qac.2
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 10:00:01 -0800 (PST)
In-Reply-To: <1421682891-11594-2-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2015 at 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> -static int line6_probe(struct usb_interface *interface,
> -                      const struct usb_device_id *id)
> +int line6_probe(struct usb_interface *interface,
> +               struct usb_line6 *line6,
> +               const struct line6_properties *properties,
> +               int (*private_init)(struct usb_interface *, struct usb_line6 *))
>  {
> -       enum line6_device_type devtype;
>         struct usb_device *usbdev;
> -       struct usb_line6 *line6;
> -       const struct line6_properties *properties;
>         int interface_number;
> -       int size = 0;
>         int ret;
>
> -       if (interface == NULL)
> -               return -ENODEV;
> +       if (!interface) {
> +               ret = -ENODEV;
> +               goto err_put;
> +       }
>         usbdev = interface_to_usbdev(interface);
> -       if (usbdev == NULL)
> -               return -ENODEV;
> +       if (!usbdev) {
> +               ret = -ENODEV;
> +               goto err_put;
> +       }

These NULL checks are unnecessary, right?  We could just assign `usbdev'
at declaration and be done with it.  But maybe that should be another
patch.

Chris
