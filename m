From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 1/2] snd-usb-audio: Add mixer control for
 Digidesign Mbox 1 clock source
Date: Sun, 09 Nov 2014 00:30:48 +1100
Message-ID: <545E1B08.2020102@gmail.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
 <1415059597-18344-2-git-send-email-damien@zamaudio.com>
 <s5hbnok2zbf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F706260455
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 14:30:58 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id y10so5001006pdj.28
 for <alsa-devel@alsa-project.org>; Sat, 08 Nov 2014 05:30:56 -0800 (PST)
In-Reply-To: <s5hbnok2zbf.wl-tiwai@suse.de>
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

Hi Takashi,

On 07/11/14 01:12, Takashi Iwai wrote:
> At Tue,  4 Nov 2014 11:06:36 +1100,
> Damien Zammit wrote:
>> +		down_read(&mixer->chip->shutdown_rwsem);
I dont know what down_read and up_read does.

>> +		if (mixer->chip->shutdown) {
>> +			err = -ENODEV;
>> +		} else {
>> +			err = snd_usb_ctl_msg(mixer->chip->dev,
>> +				usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
>> +				USB_DIR_IN |
>> +				USB_TYPE_CLASS |
>> +				USB_RECIP_INTERFACE, 0x00, 0x500, buff, 1);
>> +			if (err < 0)
>> +				return err;
>> +			err = snd_usb_ctl_msg(mixer->chip->dev,
>> +				usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
>> +				USB_DIR_IN |
>> +				USB_TYPE_CLASS |
>> +				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
>> +			if (err < 0)
>> +				return err;
> 
> What do these two messages and why needed?

These two messages are the first half of the SPDIF mode selection.
The device does not respond to standard mixer commands.
I snooped the bus in Windows and replayed the packets when selecting
SPDIF mode.  Basically it appears that this command sets the mode of the
device to receive the SPDIF clock source setting.

>> +			if (new_val == 0) {
>> +				buff[0] = 0x80;
>> +				buff[1] = 0xbb;
>> +				buff[2] = 0x00;
>> +			} else {
>> +				buff[0] = buff[1] = buff[2] = 0;
>> +			}
If the mixer control is cleared to internal clock mode, the device
expects the next command to have the sample rate fed in.  Otherwise if
the mixer control is set to spdif mode, the buffer is fed 3 zero bytes
instead.  It does not work as expected if the sample rate is allowed to
be changed by the user, therefore I locked the sample rate to 48kHz.

>> +			err = snd_usb_ctl_msg(mixer->chip->dev,
>> +				usb_sndctrlpipe(mixer->chip->dev, 0), 0x1,
>> +				USB_TYPE_CLASS |
>> +				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
>> +			if (err < 0)
>> +				return err;
>> +			err = snd_usb_ctl_msg(mixer->chip->dev,
>> +				usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
>> +				USB_DIR_IN |
>> +				USB_TYPE_CLASS |
>> +				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
>> +			if (err < 0)
>> +				return err;
>> +			err = snd_usb_ctl_msg(mixer->chip->dev,
>> +				usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
>> +				USB_DIR_IN |
>> +				USB_TYPE_CLASS |
>> +				USB_RECIP_ENDPOINT, 0x100, 0x2, buff, 3);
>> +			if (err < 0)
>> +				return err;
This is where the magic happens...

>> +		}
>> +		up_read(&mixer->chip->shutdown_rwsem);
No idea what up_read is for.

Thanks for the review, and I will post a new patch soon.
How do I tell git send-email to reply to this thread?

Thanks,

Damien
