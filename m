From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev-/tK0A0Qp8GRaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] ALSA: line6: Always setup isochronous transfer properties
Date: Mon, 6 Feb 2017 22:54:59 +0100
Message-ID: <CAFnc+wVk4=BkArMAHGkkbq241tnueYVrVx3jZBZhcJj-Vk5MRg@mail.gmail.com>
References: <s5h1svb7ewb.wl-tiwai@suse.de> <1486409698-32147-1-git-send-email-dev@andree.sk>
 <s5hpoivf25t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hpoivf25t.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Igor Zinovev <zinigor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 6, 2017 at 10:19 PM, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org> wrote:
> On Mon, 06 Feb 2017 20:34:58 +0100,
> Andrej Krutak wrote:
>>
>> While not all line6 devices currently support PCM, it causes no
>> harm to 'have it prepared'.
>>
>> This also fixes toneport, which only has PCM - in which case
>> we previously skipped the USB transfer properties detection completely.
>>
>> Signed-off-by: Andrej Krutak <dev-/tK0A0Qp8GRaa/9Udqfwiw@public.gmane.org>
>
> Well, this looks too complex and vague as a regression fix.  If it
> were 4.10-rc1, I could take it.  But now it's already rc7 and the next
> might be final, so I prefer a shorter and easier solution.
>

In the end, the patch is just "careful", so that the endpoint
structures are not read if the devices is not "marked" as having them.


> That said, we can revert the commit as a clear fix at first for 4.10
> (with Cc to stable), then take this on top as an enhancement for
> 4.11.
>
> Still it's important to know whether this works on Igor's system, so
> Igor, please give this one try.
>

Thanks to zero-init of toneport_properties_table, the proposed simple
revert should be enough for toneport, and shouldn't break other
devices (perhaps HD300-HD500 may start showing the dev_err from
line6_get_interval()).

So do as you like - e.g. simple revert for 4.10 and apply this patch
for 4.11. But I don't mind if you won't.... :-)


-- 
Andrej

>
>> ---
>>  sound/usb/line6/driver.c | 49 ++++++++++++++++++++++++++----------------------
>>  1 file changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
>> index 90009c0..0ff5a7d 100644
>> --- a/sound/usb/line6/driver.c
>> +++ b/sound/usb/line6/driver.c
>> @@ -492,42 +492,46 @@ static void line6_destruct(struct snd_card *card)
>>       usb_put_dev(usbdev);
>>  }
>>
>> -/* get data from endpoint descriptor (see usb_maxpacket): */
>> -static void line6_get_interval(struct usb_line6 *line6)
>> +static void line6_get_usb_properties(struct usb_line6 *line6)
>>  {
>>       struct usb_device *usbdev = line6->usbdev;
>>       const struct line6_properties *properties = line6->properties;
>>       int pipe;
>> -     struct usb_host_endpoint *ep;
>> +     struct usb_host_endpoint *ep = NULL;
>>
>> -     if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
>> -             pipe =
>> -                     usb_rcvintpipe(line6->usbdev, line6->properties->ep_ctrl_r);
>> -     } else {
>> -             pipe =
>> -                     usb_rcvbulkpipe(line6->usbdev, line6->properties->ep_ctrl_r);
>> +     if (properties->capabilities & LINE6_CAP_CONTROL) {
>> +             if (properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
>> +                     pipe = usb_rcvintpipe(line6->usbdev,
>> +                             line6->properties->ep_ctrl_r);
>> +             } else {
>> +                     pipe = usb_rcvbulkpipe(line6->usbdev,
>> +                             line6->properties->ep_ctrl_r);
>> +             }
>> +             ep = usbdev->ep_in[usb_pipeendpoint(pipe)];
>>       }
>> -     ep = usbdev->ep_in[usb_pipeendpoint(pipe)];
>>
>> +     /* Control data transfer properties */
>>       if (ep) {
>>               line6->interval = ep->desc.bInterval;
>> -             if (usbdev->speed == USB_SPEED_LOW) {
>> -                     line6->intervals_per_second = USB_LOW_INTERVALS_PER_SECOND;
>> -                     line6->iso_buffers = USB_LOW_ISO_BUFFERS;
>> -             } else {
>> -                     line6->intervals_per_second = USB_HIGH_INTERVALS_PER_SECOND;
>> -                     line6->iso_buffers = USB_HIGH_ISO_BUFFERS;
>> -             }
>> -
>>               line6->max_packet_size = le16_to_cpu(ep->desc.wMaxPacketSize);
>>       } else {
>> -             dev_err(line6->ifcdev,
>> -                     "endpoint not available, using fallback values");
>> +             if (properties->capabilities & LINE6_CAP_CONTROL) {
>> +                     dev_err(line6->ifcdev,
>> +                             "endpoint not available, using fallback values");
>> +             }
>>               line6->interval = LINE6_FALLBACK_INTERVAL;
>>               line6->max_packet_size = LINE6_FALLBACK_MAXPACKETSIZE;
>>       }
>> -}
>>
>> +     /* Isochronous transfer properties */
>> +     if (usbdev->speed == USB_SPEED_LOW) {
>> +             line6->intervals_per_second = USB_LOW_INTERVALS_PER_SECOND;
>> +             line6->iso_buffers = USB_LOW_ISO_BUFFERS;
>> +     } else {
>> +             line6->intervals_per_second = USB_HIGH_INTERVALS_PER_SECOND;
>> +             line6->iso_buffers = USB_HIGH_ISO_BUFFERS;
>> +     }
>> +}
>>
>>  /* Enable buffering of incoming messages, flush the buffer */
>>  static int line6_hwdep_open(struct snd_hwdep *hw, struct file *file)
>> @@ -754,8 +758,9 @@ int line6_probe(struct usb_interface *interface,
>>               goto error;
>>       }
>>
>> +     line6_get_usb_properties(line6);
>> +
>>       if (properties->capabilities & LINE6_CAP_CONTROL) {
>> -             line6_get_interval(line6);
>>               ret = line6_init_cap_control(line6);
>>               if (ret < 0)
>>                       goto error;
>> --
>> 2.7.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
