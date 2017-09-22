From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/sounds: slab-out-of-bounds read in
	snd_usb_create_streams
Date: Fri, 22 Sep 2017 15:55:17 +0200
Message-ID: <CAAeHK+w1_8ZVJAJ5DWbD9jhvNxR-_vN2hLPwWMnkZsVjMofYDQ@mail.gmail.com>
References: <CAAeHK+zNjunETPXqN5kYH3mzxoaKJjeYj8+LESKs0cFuQGs4ew@mail.gmail.com>
 <s5htvzudg64.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id F0333266DD4
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 15:55:19 +0200 (CEST)
Received: by mail-io0-f182.google.com with SMTP id m103so3178574iod.13
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 06:55:19 -0700 (PDT)
In-Reply-To: <s5htvzudg64.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, 2017 at 3:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 22 Sep 2017 14:56:06 +0200,
> Andrey Konovalov wrote:
>>
>> Hi!
>>
>> I've got the following report while fuzzing the kernel with syzkaller.
>>
>> On commit ebb2c2437d8008d46796902ff390653822af6cc4 (Sep 18).
>>
>> It seems that there's no check that control_header has enough space
>> for uac1_ac_header_descriptor in snd_usb_create_streams().
>
> Indeed, this might be an issue.
> Does the patch below fix the problem?

I believe it does. It does fix the crash with my reproducer.

I'm not sure if the (rest_bytes <= 0) check is actually needed though.
It seems that if snd_usb_find_csint_desc() returns a non-null value,
it'll always be within the buffer.

Tested-by: Andrey Konovalov <andreyknvl@google.com>

>
>
> Takashi
>
> ---
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 3dc36d913550..fc969efbb37c 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -221,6 +221,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
>         struct usb_interface_descriptor *altsd;
>         void *control_header;
>         int i, protocol;
> +       int rest_bytes;
>
>         /* find audiocontrol interface */
>         host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
> @@ -235,6 +236,13 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
>                 return -EINVAL;
>         }
>
> +       rest_bytes = (void *)(host_iface->extra + host_iface->extralen) -
> +               control_header;
> +       if (rest_bytes <= 0) {
> +               dev_err(&dev->dev, "invalid control header\n");
> +               return -EINVAL;
> +       }
> +
>         switch (protocol) {
>         default:
>                 dev_warn(&dev->dev,
> @@ -245,11 +253,21 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
>         case UAC_VERSION_1: {
>                 struct uac1_ac_header_descriptor *h1 = control_header;
>
> +               if (rest_bytes < sizeof(*h1)) {
> +                       dev_err(&dev->dev, "too short v1 buffer descriptor\n");
> +                       return -EINVAL;
> +               }
> +
>                 if (!h1->bInCollection) {
>                         dev_info(&dev->dev, "skipping empty audio interface (v1)\n");
>                         return -EINVAL;
>                 }
>
> +               if (rest_bytes < h1->bLength) {
> +                       dev_err(&dev->dev, "invalid buffer length (v1)\n");
> +                       return -EINVAL;
> +               }
> +
>                 if (h1->bLength < sizeof(*h1) + h1->bInCollection) {
>                         dev_err(&dev->dev, "invalid UAC_HEADER (v1)\n");
>                         return -EINVAL;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
