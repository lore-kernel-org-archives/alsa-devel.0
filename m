From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] (alsa-lib)pcm_hw.c:
 SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
Date: Wed, 10 Jun 2015 10:37:46 +0800
Message-ID: <CAN8cciZaiz+_J=1uHRXE6Wo5b4xUcVb8QouurC80eK9QeA-M_Q@mail.gmail.com>
References: <CAN8ccib1mKvT+yYczAmsDZTsK7JY3h+J1u0X3qvHYy=31J=6pQ@mail.gmail.com>
 <CAN8ccib=4Jix+FiAg7TihxGZvgM=bYVHctTV=rEpR-jFn1arCw@mail.gmail.com>
 <5571ABCD.1020909@mokrynskyi.com>
 <CAN8cciaPqLYOT3GiGPvD=Vg2J8uujvYNeUVj0ebv2vOcqKHkVw@mail.gmail.com>
 <55773DCF.9010007@mokrynskyi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 08F59265846
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 04:37:48 +0200 (CEST)
Received: by oiha141 with SMTP id a141so23566423oih.0
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 19:37:47 -0700 (PDT)
In-Reply-To: <55773DCF.9010007@mokrynskyi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> Some error messages can be reproduced by set default-sample-format to
s24le
>>
>> But cannot reproduce  SNDRV_PCM_IOCTL_HW_PARAMS
>>
>> Any error meesage in system log , it seem snd_usb_pcm_hw_params return
error with your usb sound car
>>
> The only thing related to sound card found in log, last 3 lines are
multiple times repeated afterwards:
>
> [ 1306.010420] usb 1-6: new full-speed USB device number 23 using xhci_hcd
> [ 1306.177219] usb 1-6: New USB device found, idVendor=041e,
idProduct=322c
> [ 1306.177222] usb 1-6: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
> [ 1306.177223] usb 1-6: Product: SB Omni Surround 5.1
> [ 1306.177225] usb 1-6: Manufacturer: Creative Technology Ltd
> [ 1306.177226] usb 1-6: SerialNumber: 000000Q6
> [ 1306.177381] usb 1-6: ep 0x83 - rounding interval to 64 microframes, ep
desc says 80 microframes
> [ 1306.208636] input: Creative Technology Ltd SB Omni Surround 5.1 as
/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.4/0003:041E:322C.0013/input/input42
> [ 1306.259885] hid-generic 0003:041E:322C.0013: input,hidraw0: USB HID
v1.11 Keyboard [Creative Technology Ltd SB Omni Surround 5.1] on
usb-0000:00:14.0-6/input4
> [ 1306.292463] usb 1-6: Not enough bandwidth for new device state.
> [ 1306.292470] usb 1-6: Not enough bandwidth for altsetting 2
> [ 1306.292472] usb 1-6: 3:2: usb_set_interface failed (-28)
>
> I have no idea why is that the case, device is USB 2.0, even disabling
all other external USB devices and pluggin it into USB 3.0 doesn't help.
> Nothing more in log.
>

Can "not enough bandwidth" or "usb_set_interface failed (-28)" message
repoduced by using aplay or  arecord with s24le/s16le at different rate
instead of using pulseaudio ?
