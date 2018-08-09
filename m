From: Joseph Spencer <joespenceris@gmail.com>
Subject: Re: : Possible issue with udev rules: Help with TASCAM
	US-122
Date: Thu, 9 Aug 2018 11:49:31 -0700
Message-ID: <CAMvaF70xN-GjYqO4PzwYwTTaTye7RLJ7yA5VCLRET_j+gEtzBg@mail.gmail.com>
References: <CAMvaF73QrtaSAUNFJW7Dy-=EdaaS=F+H-mECdbfvbaC8ZTqzvA@mail.gmail.com>
 <s5h4lg8u4hl.wl-tiwai@suse.de>
 <CAMvaF70_2Y5C-1J2e3ucj-zStU2NG2ehZJ02=Ztt7oicjOAEag@mail.gmail.com>
 <s5hbmachfjv.wl-tiwai@suse.de>
 <CAMvaF72MJG-y-O76uZhaO4pWSBW_LY7f5GGH41wygNhLNsLQzg@mail.gmail.com>
 <CAMvaF70UJwzVzQOe60_+hEz+FKAWv_8HXPrNLvxRg_Pb6wuePw@mail.gmail.com>
 <CAMvaF71Eiy4pgABGLLJ1Z_QXeMvWdRvw5_5hBj8JbiXt=EjdYw@mail.gmail.com>
 <CAMvaF72WEnXRm-ovR3TbH89jywhcbNE32=9O73w6hG-iWryX8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 668A6267920
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 20:49:43 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id a4-v6so4846927lff.5
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2018 11:49:43 -0700 (PDT)
In-Reply-To: <CAMvaF72WEnXRm-ovR3TbH89jywhcbNE32=9O73w6hG-iWryX8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I commented out the rule for the fpga loader, and now I'm seeing this, is
this expected?

Aug 09 11:47:59 localhost.localdomain kernel: usb 3-1: new full-speed USB
device number 22 using xhci_hcd
Aug 09 11:47:59 localhost.localdomain kernel: usb 3-1: New USB device
found, idVendor=1604, idProduct=8006, bcdDevice= 1.00
Aug 09 11:47:59 localhost.localdomain kernel: usb 3-1: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Aug 09 11:47:59 localhost.localdomain /lib/udev/tascam_fw[10800]: load
/usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
/dev/bus/usb/003/022
Aug 09 11:47:59 localhost.localdomain upowerd[3378]: unhandled action
'bind' on /sys/devices/pci0000:00/0000:00:14.0/usb3/3-1
Aug 09 11:47:59 localhost.localdomain kernel: usb 3-1: USB disconnect,
device number 22
Aug 09 11:47:59 localhost.localdomain upowerd[3378]: unhandled action
'unbind' on /sys/devices/pci0000:00/0000:00:14.0/usb3/3-1
Aug 09 11:48:01 localhost.localdomain kernel: usb 3-1: new full-speed USB
device number 23 using xhci_hcd
Aug 09 11:48:01 localhost.localdomain kernel: usb 3-1: New USB device
found, idVendor=1604, idProduct=8007, bcdDevice= 0.01
Aug 09 11:48:01 localhost.localdomain kernel: usb 3-1: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Aug 09 11:48:01 localhost.localdomain upowerd[3378]: unhandled action
'bind' on /sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0
Aug 09 11:48:01 localhost.localdomain upowerd[3378]: unhandled action
'bind' on /sys/devices/pci0000:00/0000:00:14.0/usb3/3-1
Aug 09 11:48:01 localhost.localdomain pulseaudio[2191]: E: [pulseaudio]
module-alsa-card.c: Failed to find a working profile.
Aug 09 11:48:01 localhost.localdomain pulseaudio[2191]: E: [pulseaudio]
module.c: Failed to load module "module-alsa-card" (argument:
"device_id="1" name="usb-1604_8007-00"
card_name="alsa_card.usb-1604_8007-00" namereg_fail=false tsched=yes
fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1""): initialization failed.


Joe Spencer
602.777.2307


On Thu, Aug 9, 2018 at 11:41 AM Joseph Spencer <joespenceris@gmail.com>
wrote:

> So, after pouring through the udev docs, I noticed that the
> 90-alsa-tools-firmware.rules file was matching on any usb device or that
> with an ancestor having a vendor id of 1604 (due to the match
> via ATTRS{idVendor}=="1604").  I changed the match
> to ENV{ID_VENDOR_ID}=="1604", and now I'm only seeing 1 tascam_fw call in
> journcalctl and DEVNAME is set.
>
> More to come...
> Joe Spencer
> 602.777.2307
>
>
> On Thu, Aug 9, 2018 at 11:28 AM Joseph Spencer <joespenceris@gmail.com>
> wrote:
>
>> I ran udevadm, here are the environment variables passed to the tascam_fw
>> script.  Looks like 3 events are triggered and the script is sometimes
>> called without DEVNAME set:
>>
>> sudo udevadm monitor --environment --udev
>> calling: monitor
>> monitor will print the received events for:
>> UDEV - the event which udev sends out after rule processing
>>
>> UDEV  [5993.106245] add      /devices/pci0000:00/0000:00:14.0/usb3/3-1
>> (usb)
>> ACTION=add
>> BUSNUM=003
>> DEVNAME=/dev/bus/usb/003/007
>> DEVNUM=007
>> DEVPATH=/devices/pci0000:00/0000:00:14.0/usb3/3-1
>> DEVTYPE=usb_device
>> DRIVER=usb
>> ID_BUS=usb
>> ID_MODEL=8006
>> ID_MODEL_ENC=8006
>> ID_MODEL_FROM_DATABASE=US-122 Audio/Midi Interface (without fw)
>> ID_MODEL_ID=8006
>> ID_REVISION=0100
>> ID_SERIAL=1604_8006
>> ID_USB_INTERFACES=:ffffff:
>> ID_VENDOR=1604
>> ID_VENDOR_ENC=1604
>> ID_VENDOR_FROM_DATABASE=Tascam
>> ID_VENDOR_ID=1604
>> MAJOR=189
>> MINOR=262
>> PRODUCT=1604/8006/100
>> SEQNUM=3509
>> SUBSYSTEM=usb
>> TYPE=255/255/255
>> USEC_INITIALIZED=5993072486
>>
>> UDEV  [5993.118743] add
>> /devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0 (usb)
>> .MM_USBIFNUM=00
>> ACTION=add
>> DEVPATH=/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0
>> DEVTYPE=usb_interface
>> ID_MODEL_FROM_DATABASE=US-122 Audio/Midi Interface (without fw)
>> ID_USB_CLASS_FROM_DATABASE=Vendor Specific Class
>> ID_USB_PROTOCOL_FROM_DATABASE=Vendor Specific Protocol
>> ID_USB_SUBCLASS_FROM_DATABASE=Vendor Specific Subclass
>> ID_VENDOR_FROM_DATABASE=Tascam
>> INTERFACE=255/255/255
>> MODALIAS=usb:v1604p8006d0100dcFFdscFFdpFFicFFiscFFipFFin00
>> PRODUCT=1604/8006/100
>> SEQNUM=3510
>> SUBSYSTEM=usb
>> TYPE=255/255/255
>> USEC_INITIALIZED=5993108279
>>
>> UDEV  [5993.120779] bind     /devices/pci0000:00/0000:00:14.0/usb3/3-1
>> (usb)
>> ACTION=bind
>> BUSNUM=003
>> DEVNAME=/dev/bus/usb/003/007
>> DEVNUM=007
>> DEVPATH=/devices/pci0000:00/0000:00:14.0/usb3/3-1
>> DEVTYPE=usb_device
>> DRIVER=usb
>> ID_BUS=usb
>> ID_MODEL=8006
>> ID_MODEL_ENC=8006
>> ID_MODEL_FROM_DATABASE=US-122 Audio/Midi Interface (without fw)
>> ID_MODEL_ID=8006
>> ID_REVISION=0100
>> ID_SERIAL=1604_8006
>> ID_USB_INTERFACES=:ffffff:
>> ID_VENDOR=1604
>> ID_VENDOR_ENC=1604
>> ID_VENDOR_FROM_DATABASE=Tascam
>> ID_VENDOR_ID=1604
>> MAJOR=189
>> MINOR=262
>> PRODUCT=1604/8006/100
>> SEQNUM=3511
>> SUBSYSTEM=usb
>> TYPE=255/255/255
>> USEC_INITIALIZED=5993072486
>>
>>
>> Joe Spencer
>> 602.777.2307
>>
>>
>> On Wed, Aug 8, 2018 at 11:38 PM Joseph Spencer <joespenceris@gmail.com>
>> wrote:
>>
>>> OK,
>>>
>>> I booted with nomodeset in the kernel options.  This time I was able to
>>> plug the tascam us-122 in to usb and the UI didn't freeze; however, pulse
>>> audio never came up.  I'm attaching the journalctl logs.  You can see that
>>> it never gets past "task pulseaudio:1750 blocked for more than 120 seconds".
>>>
>>> Joe Spencer
>>> 602.777.2307
>>>
>>>
>>> On Wed, Aug 8, 2018 at 11:49 AM Joseph Spencer <joespenceris@gmail.com>
>>> wrote:
>>>
>>>> I'll give that a shot!
>>>>
>>>> Also, I thought the following lines in journalctl were a bit odd:
>>>>
>>>> first:
>>>>
>>>> Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2834]: load
>>>> /usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
>>>> /dev/bus/usb/003/002
>>>> Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2837]: load
>>>> /usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
>>>>
>>>>
>>>> second:
>>>>
>>>> Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2859]:
>>>> calling /usr/bin/usx2yloader for
>>>> Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2861]:
>>>> leaving
>>>> Aug 04 03:13:52 localhost.localdomain kernel: usbcore: registered new
>>>> interface driver snd-usb-usx2y
>>>> Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2864]:
>>>> calling /usr/bin/usx2yloader for
>>>> Aug 04 03:13:54 localhost.localdomain /lib/udev/tascam_fpga[2867]:
>>>> leaving
>>>>
>>>>
>>>> I thought it was stranged that "to" and "for" had missing values after
>>>> them.
>>>>
>>>> So in the respective /lib/udev/tascam_f* scripts I added some debug
>>>> output...
>>>>
>>>> In /lib/udev/tascam_fpga I added:
>>>>
>>>> debug_date=$(date +%S%N)
>>>>
>>>> env > "/fpga-${debug_date}.env"
>>>>
>>>>
>>>> In /lib/udev/tascam_fw I added:
>>>>
>>>> debug_date=$(date +%S%N)
>>>> env > "/fw-${debug_date}.env"
>>>>
>>>> Plugged my device in and sure enough, DEVNAME wasn't set in tascam_fw
>>>> on the 2nd run, and DEVICE is never set in tascam_fpga.
>>>>
>>>> Could it be that I don't have udev configured properly?
>>>>
>>>>
>>>> Joe Spencer
>>>> 602.777.2307
>>>>
>>>>
>>>> On Wed, Aug 8, 2018 at 11:35 AM Takashi Iwai <tiwai@suse.de> wrote:
>>>>
>>>>> On Wed, 08 Aug 2018 18:46:13 +0200,
>>>>> Joseph Spencer wrote:
>>>>> >
>>>>> > I installed the kernal-debug package along with debug info (Linux
>>>>> > localhost.localdomain 4.17.11-200.fc28.x86_64+debug #1 SMP Mon Jul 30
>>>>> > 14:53:06 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux).
>>>>> >
>>>>> > I looked in /boot/config-4.17.11-200.fc28.x86_64+debug and I see
>>>>> that the
>>>>> > debug options are now enabled (attaching this file in case there are
>>>>> more
>>>>> > options I can enable).
>>>>> >
>>>>> > I repeated another failure.  The output in journalctl -f appears to
>>>>> me to
>>>>> > be about the same (see attached)
>>>>> >
>>>>> > Any pointers on what I could enable or do to debug this further?
>>>>>
>>>>> If so, then try to disable i915 KMS. e.g. boot with nomodeset option,
>>>>> and check whether the crash still happens.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>
