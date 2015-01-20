From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 01/17] ALSA: line6: Split to each driver
Date: Mon, 19 Jan 2015 23:59:05 -0600
Message-ID: <CAEUsAPZsOhCXOB5uhOAn2c2qCGm=x_F8oPu+PPsOG5gxOpmKww@mail.gmail.com>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
 <1421682891-11594-2-git-send-email-tiwai@suse.de>
 <CAEUsAPaw922VsU-00--auMaxW+RZYJKnKFB40jZGNFxkT8PEgg@mail.gmail.com>
 <s5hvbk2wohr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 193A1260687
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 06:59:06 +0100 (CET)
Received: by mail-qa0-f50.google.com with SMTP id k15so27067153qaq.9
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 21:59:05 -0800 (PST)
In-Reply-To: <s5hvbk2wohr.wl-tiwai@suse.de>
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

Sounds good.  I like the approach.  I was futzing around with how to do
this, though I didn't spend too much time on it because I was antici-
pating more patches from you that would be difficult to merge.  Using
the private_init callback is a nice idea and makes a necessarily large
change pretty easy to understand.

Chris

On Mon, Jan 19, 2015 at 1:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 19 Jan 2015 12:00:01 -0600,
> Chris Rorvick wrote:
>>
>> On Mon, Jan 19, 2015 at 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > -static int line6_probe(struct usb_interface *interface,
>> > -                      const struct usb_device_id *id)
>> > +int line6_probe(struct usb_interface *interface,
>> > +               struct usb_line6 *line6,
>> > +               const struct line6_properties *properties,
>> > +               int (*private_init)(struct usb_interface *, struct usb_line6 *))
>> >  {
>> > -       enum line6_device_type devtype;
>> >         struct usb_device *usbdev;
>> > -       struct usb_line6 *line6;
>> > -       const struct line6_properties *properties;
>> >         int interface_number;
>> > -       int size = 0;
>> >         int ret;
>> >
>> > -       if (interface == NULL)
>> > -               return -ENODEV;
>> > +       if (!interface) {
>> > +               ret = -ENODEV;
>> > +               goto err_put;
>> > +       }
>> >         usbdev = interface_to_usbdev(interface);
>> > -       if (usbdev == NULL)
>> > -               return -ENODEV;
>> > +       if (!usbdev) {
>> > +               ret = -ENODEV;
>> > +               goto err_put;
>> > +       }
>>
>> These NULL checks are unnecessary, right?  We could just assign `usbdev'
>> at declaration and be done with it.  But maybe that should be another
>> patch.
>
> Right, the cleanup can be done later, as this patch is merely a
> transition.
>
>
> Takashi
