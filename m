From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: [PATCH 09/15] ALSA: line6: Add hwdep interface to
 access the POD control messages
Date: Fri, 12 Aug 2016 13:10:37 +0200
Message-ID: <CAFnc+wWRFjyJmY0=hJDAOZQvZJP46Kp+HqbCZMGRLvsdLN8gVQ@mail.gmail.com>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1470942147-19848-10-git-send-email-dev@andree.sk>
 <s5h8tw2fkbe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3B1265CBB
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 13:10:58 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id i5so2235436wmg.2
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 04:10:58 -0700 (PDT)
In-Reply-To: <s5h8tw2fkbe.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2016 at 10:44 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 11 Aug 2016 21:02:21 +0200,
> Andrej Krutak wrote:
> >
> > We must do it this way, because e.g. POD X3 won't play any sound unless
> > the host listens on the bulk EP, so we cannot export it only via libusb.
> >
> > The driver currently doesn't use the bulk EP messages in other way,
> > in future it could e.g. sense/modify volume(s).
> >
> > Signed-off-by: Andrej Krutak <dev@andree.sk>
> > ---
> >  include/uapi/sound/asound.h |   3 +-
> >  sound/usb/line6/driver.c    | 167 ++++++++++++++++++++++++++++++++++++++++++++
> >  sound/usb/line6/driver.h    |  12 ++++
> >  3 files changed, 181 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> > index 609cadb..be353a7 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -106,9 +106,10 @@ enum {
> >       SNDRV_HWDEP_IFACE_FW_OXFW,      /* Oxford OXFW970/971 based device */
> >       SNDRV_HWDEP_IFACE_FW_DIGI00X,   /* Digidesign Digi 002/003 family */
> >       SNDRV_HWDEP_IFACE_FW_TASCAM,    /* TASCAM FireWire series */
> > +     SNDRV_HWDEP_IFACE_LINE6,        /* Line6 USB processors */
> >
> >       /* Don't forget to change the following: */
> > -     SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
> > +     SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_LINE6
> >  };
> >
> >  struct snd_hwdep_info {
> > diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> > index 8a71d45..0a0e324 100644
> > --- a/sound/usb/line6/driver.c
> > +++ b/sound/usb/line6/driver.c
> > @@ -14,9 +14,11 @@
> >  #include <linux/export.h>
> >  #include <linux/slab.h>
> >  #include <linux/usb.h>
> > +#include <linux/circ_buf.h>
> >
> >  #include <sound/core.h>
> >  #include <sound/initval.h>
> > +#include <sound/hwdep.h>
> >
> >  #include "capture.h"
> >  #include "driver.h"
> > @@ -315,8 +317,11 @@ static void line6_data_received(struct urb *urb)
> >                               line6->process_message(line6);
> >               }
> >       } else {
> > +             line6->buffer_message = urb->transfer_buffer;
> > +             line6->message_length = urb->actual_length;
> >               if (line6->process_message)
> >                       line6->process_message(line6);
> > +             line6->buffer_message = NULL;
> >       }
> >
> >       line6_start_listen(line6);
> > @@ -522,6 +527,163 @@ static void line6_get_interval(struct usb_line6 *line6)
> >       }
> >  }
> >
> > +
> > +/* Enable buffering of incoming messages, flush the buffer */
> > +static int line6_hwdep_open(struct snd_hwdep *hw, struct file *file)
> > +{
> > +     struct usb_line6 *line6 = hw->private_data;
> > +
> > +     /* NOTE: hwdep already provides atomicity (exclusive == true), but for
> > +      * sure... */
> > +     if (test_and_set_bit(0, &line6->buffer_circular.active))
> > +             return -EBUSY;
> > +
> > +     line6->buffer_circular.head = 0;
> > +     line6->buffer_circular.tail = 0;
> > +     sema_init(&line6->buffer_circular.sem, 0);
>
> Why do you use semaphore, not mutex?  And initializing at this
> point...?  It looks racy.
>

I can move it to hwdep_init, but here it should be fine too, since
hwdep_open() is serialized by hwdep layer.

Semaphore is used because it also uses as counter for hwdep_read,
which otherwise I'd have to do manually. I could rewrite this to use
waitqueues, but when the counter is added to that, I end up basically
with semaphore reimplementation... Do you see this as a big issue?


>
>
> > +     line6->buffer_circular.active = 1;
>
> Looks superfluous, done in the above?
>

This is here to just drop the USB packets if there's no active reader.
To save some CPU time basically...

>
>
> > +     line6->buffer_circular.data =
> > +             kmalloc(LINE6_MESSAGE_MAXLEN * LINE6_MESSAGE_MAXCOUNT, GFP_KERNEL);
> > +     if (!line6->buffer_circular.data) {
> > +             return -ENOMEM;
> > +     }
> > +     line6->buffer_circular.data_len =
> > +             kmalloc(sizeof(*line6->buffer_circular.data_len) *
> > +                     LINE6_MESSAGE_MAXCOUNT, GFP_KERNEL);
> > +     if (!line6->buffer_circular.data_len) {
> > +             kfree(line6->buffer_circular.data);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Stop buffering */
> > +static int line6_hwdep_release(struct snd_hwdep *hw, struct file *file)
> > +{
> > +     struct usb_line6 *line6 = hw->private_data;
> > +
> > +     /* By this time, no readers are waiting, we can safely recreate the
> > +      * semaphore at next open. */
> > +     line6->buffer_circular.active = 0;
> > +
> > +     kfree(line6->buffer_circular.data);
> > +     kfree(line6->buffer_circular.data_len);
> > +     return 0;
> > +}
> > +
> > +/* Read from circular buffer, return to user */
> > +static long
> > +line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
> > +                                     loff_t *offset)
> > +{
> > +     struct usb_line6 *line6 = hwdep->private_data;
> > +     unsigned long tail;
>
> No need to use long for FIFO index.
>

See below.


>
> > +     if (down_interruptible(&line6->buffer_circular.sem)) {
> > +             return -ERESTARTSYS;
> > +     }
> > +     /* There must an item now in the buffer... */
> > +
> > +     tail = line6->buffer_circular.tail;
> > +
> > +     if (line6->buffer_circular.data_len[tail] > count) {
> > +             /* Buffer too small; allow re-read of the current item... */
> > +             up(&line6->buffer_circular.sem);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (copy_to_user(buf,
> > +             &line6->buffer_circular.data[tail * LINE6_MESSAGE_MAXLEN],
> > +             line6->buffer_circular.data_len[tail])
> > +     ) {
> > +             rv = -EFAULT;
> > +             goto end;
> > +     } else {
> > +             rv = line6->buffer_circular.data_len[tail];
> > +     }
> > +
> > +     smp_store_release(&line6->buffer_circular.tail,
> > +                             (tail + 1) & (LINE6_MESSAGE_MAXCOUNT - 1));
> > +
> > +     return 0;
> > +}
> > +
> > +/* Write directly (no buffering) to device by user*/
> > +static long
> > +line6_hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
> > +                                     loff_t *offset)
> > +{
> > +     struct usb_line6 *line6 = hwdep->private_data;
> > +     int rv;
> > +     char *data_copy;
> > +
> > +     data_copy = kmalloc(count, GFP_ATOMIC);
>
> No need to use GFP_ATOMIC in this context.
> Also, you should add the sanity check of the given size.  User may
> pass any size of the write.
>
> > +     if (!data_copy)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(data_copy, data, count))
> > +             rv = -EFAULT;
>
> Maybe easier to use memdup_user() helper.
>
> > +     else
> > +             rv = line6_send_raw_message(line6, data_copy, count);
> > +
> > +     kfree(data_copy);
> > +     return rv;
> > +}
> > +
> > +static const struct snd_hwdep_ops hwdep_ops = {
> > +     .open    = line6_hwdep_open,
> > +     .release = line6_hwdep_release,
> > +     .read    = line6_hwdep_read,
> > +     .write   = line6_hwdep_write,
> > +};
> > +
> > +/* Insert into circular buffer */
> > +static void line6_hwdep_push_message(struct usb_line6 *line6)
> > +{
> > +     unsigned long head = line6->buffer_circular.head;
> > +     /* The spin_unlock() and next spin_lock() provide needed ordering. */
> > +     unsigned long tail = ACCESS_ONCE(line6->buffer_circular.tail);
> > +
> > +     if (!line6->buffer_circular.active)
> > +             return;
> > +
> > +     if (CIRC_SPACE(head, tail, LINE6_MESSAGE_MAXCOUNT) >= 1) {
> > +             unsigned char *item = &line6->buffer_circular.data[
> > +                     head * LINE6_MESSAGE_MAXLEN];
> > +             memcpy(item, line6->buffer_message, line6->message_length);
> > +             line6->buffer_circular.data_len[head] = line6->message_length;
> > +
> > +             smp_store_release(&line6->buffer_circular.head,
> > +                               (head + 1) & (LINE6_MESSAGE_MAXCOUNT - 1));
> > +             up(&line6->buffer_circular.sem);
> > +     }
>
> Hmm...  this kind of a simple FIFO can be seen in anywhere in the
> kernel code, and I'm sure that you can find an easier way to implement
> it.  The whole code looks a bit scary as it being home-brewed.
>

This code is based on Documentation/circular-buffers.txt, except for
the semaphore magic.


> Also, the blocking read/write control isn't usually done by a
> semaphore.  Then you can handle the interrupt there.
>
>

I actually wonder why, semaphores seemed perfect for this... Do you
have some hints?

-- 
Andrej
