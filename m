From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: [PATCH] ALSA: line6: Claim POD X3 USB data
	interface
Date: Mon, 21 Nov 2016 12:52:47 +0100
Message-ID: <CAFnc+wUnDm1dWV75TvxNvfjXAdu5MF+eJRez54HAxEFou145UA@mail.gmail.com>
References: <1479556889-17601-1-git-send-email-dev@andree.sk>
 <s5hy40dt8ib.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A765A2669AD
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 12:53:10 +0100 (CET)
Received: by mail-qk0-f196.google.com with SMTP id n204so46090448qke.2
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 03:53:10 -0800 (PST)
In-Reply-To: <s5hy40dt8ib.wl-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, grabner@icg.tugraz.at
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2016 at 11:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 19 Nov 2016 13:01:29 +0100,
> Andrej Krutak wrote:
>>
>> Deny userspace from using the interface concurrently.
>
> Could you clarify more what's wrong and what you're changing?
>
>

Userspace apps have to claim USB interfaces before using endpoints in
them (drivers/usb/core/devio.c:checkintf()). It's a lock mechanism so
that two "drivers"
don't steal data from each other. Kernel drivers don't necessarily
have to claim interfaces (obviously, because it worked so far) - but
they should, to lock out userspace...

Do you want that info in a v2 patch?

>>
>> Signed-off-by: Andrej Krutak <dev@andree.sk>
>> ---
>>  sound/usb/line6/driver.h |  1 +
>>  sound/usb/line6/podhd.c  | 24 ++++++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
>> index 7e3a3aa..5d18957 100644
>> --- a/sound/usb/line6/driver.h
>> +++ b/sound/usb/line6/driver.h
>> @@ -98,6 +98,7 @@ struct line6_properties {
>>
>>       int altsetting;
>>
>> +     unsigned ctrl_if;
>>       unsigned ep_ctrl_r;
>>       unsigned ep_ctrl_w;
>>       unsigned ep_audio_r;
>> diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
>> index 49cd4a6..6c53b87 100644
>> --- a/sound/usb/line6/podhd.c
>> +++ b/sound/usb/line6/podhd.c
>> @@ -153,6 +153,7 @@ struct usb_line6_podhd {
>>                           .rats = &podhd_ratden},
>>       .bytes_per_channel = 3 /* SNDRV_PCM_FMTBIT_S24_3LE */
>>  };
>> +static struct usb_driver podhd_driver;
>>
>>  static void podhd_startup_start_workqueue(unsigned long data);
>>  static void podhd_startup_workqueue(struct work_struct *work);
>> @@ -291,8 +292,13 @@ static void podhd_disconnect(struct usb_line6 *line6)
>>       struct usb_line6_podhd *pod = (struct usb_line6_podhd *)line6;
>>
>>       if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
>> +             struct usb_interface *intf;
>> +
>>               del_timer_sync(&pod->startup_timer);
>>               cancel_work_sync(&pod->startup_work);
>> +
>> +             intf = usb_ifnum_to_if(line6->usbdev, pod->line6.properties->ctrl_if);
>> +             usb_driver_release_interface(&podhd_driver, intf);
>>       }
>>  }
>>
>> @@ -304,10 +310,26 @@ static int podhd_init(struct usb_line6 *line6,
>>  {
>>       int err;
>>       struct usb_line6_podhd *pod = (struct usb_line6_podhd *) line6;
>> +     struct usb_interface *intf;
>>
>>       line6->disconnect = podhd_disconnect;
>>
>>       if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
>> +             /* claim the data interface */
>> +             intf = usb_ifnum_to_if(line6->usbdev, pod->line6.properties->ctrl_if);
>> +             if (!intf) {
>> +                     dev_err(pod->line6.ifcdev, "interface %d not found\n",
>> +                             pod->line6.properties->ctrl_if);
>> +                     return -ENODEV;
>> +             }
>> +
>> +             err = usb_driver_claim_interface(&podhd_driver, intf, NULL);
>> +             if (err != 0) {
>> +                     dev_err(pod->line6.ifcdev, "can't claim interface %d, error %d\n",
>> +                             pod->line6.properties->ctrl_if, err);
>> +                     return err;
>> +             }
>> +
>>               /* create sysfs entries: */
>>               err = snd_card_add_dev_attr(line6->card, &podhd_dev_attr_group);
>>               if (err < 0)
>> @@ -406,6 +428,7 @@ static int podhd_init(struct usb_line6 *line6,
>>               .altsetting = 1,
>>               .ep_ctrl_r = 0x81,
>>               .ep_ctrl_w = 0x01,
>> +             .ctrl_if = 1,
>>               .ep_audio_r = 0x86,
>>               .ep_audio_w = 0x02,
>>       },
>> @@ -417,6 +440,7 @@ static int podhd_init(struct usb_line6 *line6,
>>               .altsetting = 1,
>>               .ep_ctrl_r = 0x81,
>>               .ep_ctrl_w = 0x01,
>> +             .ctrl_if = 1,
>>               .ep_audio_r = 0x86,
>>               .ep_audio_w = 0x02,
>>       },
>> --
>> 1.9.1
>>
>>
