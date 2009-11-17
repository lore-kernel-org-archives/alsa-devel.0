From: Javier Kohen <jkohen@users.sourceforge.net>
Subject: Re: Quirk to disable master volume control in PCM2702
Date: Tue, 17 Nov 2009 15:36:13 +0100
Message-ID: <861213340911170636q291070a2y531d3b5af2c75b82@mail.gmail.com>
References: <861213340911161513n53c8b303i67ac2f07db87cddc@mail.gmail.com>
	<861213340911161517tfb33467i9a4b270c0a548c69@mail.gmail.com>
	<4B02671E.8070306@ladisch.de>
	<861213340911170259q2b810550tf76f50d59fd87ee4@mail.gmail.com>
	<s5hvdh92z1x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 590501037E3
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 15:36:20 +0100 (CET)
Received: by gxk7 with SMTP id 7so54845gxk.12
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 06:36:19 -0800 (PST)
In-Reply-To: <s5hvdh92z1x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

On Tue, Nov 17, 2009 at 12:03, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 17 Nov 2009 11:59:36 +0100,
> Javier Kohen wrote:
>>
>> Clemens,
>>
>> On Tue, Nov 17, 2009 at 10:04, Clemens Ladisch <clemens@ladisch.de> wrote:
>> >
>> > Javier Kohen wrote:
>> > > I've written the attached patch to disable the master volume control
>> > > in this chipset. The datasheet [1] documents two independent channel
>> > > volume controls, one master mute control and one master volume
>> > > control. However, at least on my device (a Fubar USB DAC), the master
>> > > volume control always returns USB stalls when queried for any of its
>> > > parameters (min/max/res/cur).
>> >
>> > I'd guess that Windows ignores the master volume when it finds
>> > channel volume controls, so this function was never actually tested.
>> >
>> > > However, it seems that either the USB specs are wrong,
>> >
>> > They are abominations written by committees.
>> >
>> > > or my USB hub or the card are buggy.
>> >
>> > Your hub is certainly buggy ...
>> >
>> > > the PCM2702 and my motherboard don't interact well. After a while the
>> > > sound is degraded, first into a hiss, then into pure noise.
>> >
>> > ... the card too.
>> >
>> >
>> > Your patch looks good; please provide a log message and a Signed-off-by
>> > tag.
>>
>> Thanks for the prompt review!
>>
> Better to put a prefix like "usbmixer: master volume ..." since
> snd_printk() can be turned to the normal printk() depending on the
> kernel config.

I don't know if the comment was for me or for whoever will submit
this, but here you go just in case:

Disable the master volume control in the PCM2702 chipset.

The datasheet documents two independent channel volume controls, one
master mute control and one master volume control. All controls are
fully functional except for the master volume control, which returns
USB stalls on all GET requests.

Signed-off-by: Javier Kohen <jkohen@users.sourceforge.net>
---
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 9efcfd0..406315e 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -1071,6 +1071,16 @@ static int parse_audio_feature_unit(struct
mixer_build *state, int unitid, unsig
       channels = (ftr[0] - 7) / csize - 1;

       master_bits = snd_usb_combine_bytes(ftr + 6, csize);
+       /* master configuration quirks */
+       switch (state->chip->usb_id) {
+       case USB_ID(0x08bb, 0x2702):
+               snd_printk(KERN_INFO
+                          "usbmixer: master volume quirk for PCM2702 chip\n");
+               /* disable non-functional volume control */
+               master_bits &= ~(1 << (USB_FEATURE_VOLUME - 1));
+               break;
+
+       }
       if (channels > 0)
               first_ch_bits = snd_usb_combine_bytes(ftr + 6 + csize, csize);
       else
