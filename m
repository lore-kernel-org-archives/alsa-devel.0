From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Wed, 29 Jul 2009 12:44:37 +0200
Message-ID: <4A702815.6060701@powercraft.nl>
References: <4916FAB7.7050206@powercraft.nl>
	<s5hhc6ezo3g.wl%tiwai@suse.de>	<491953A4.8070509@powercraft.nl>
	<s5hljvqr1jr.wl%tiwai@suse.de>	<Pine.LNX.4.61.0811111151260.13649@tm8103.perex-int.cz>	<4919C148.3060706@powercraft.nl>
	<Pine.LNX.4.61.0811111845330.13649@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050702050305010801040809"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay01.cambriumhosting.nl (relay01.cambriumhosting.nl
	[217.19.16.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A043103867
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 12:44:40 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0811111845330.13649@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050702050305010801040809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/08 18:55, Jaroslav Kysela wrote:
> On Tue, 11 Nov 2008, Jelle de Jong wrote:
>
>> Jaroslav Kysela wrote:
>>> On Tue, 11 Nov 2008, Takashi Iwai wrote:
>>>
>>>>> Almost all devices can be managed with udev rules, that is where the
>>>>> system is designed for, there are also alsa rules in there, if they
>>>>> don't work what is wrong then? is it an alsa issue, or udev, what are
>>>>> the dependencies when alsa uses hardware. How are the /dev/snd/* devices
>>>>> used and what is the /proc/asound/* for ?
>>>> The card index mechanism in ALSA was introduced much before udev
>>>> was born.  It's just a legacy mechanism, but it's hard to kill without
>>>> breaking the running system, unfortunately.
>>>
>>> Note that you can identify your card via the text identification (check
>>> /proc/asound/cards to get it in []). You can set this identification in
>>> the module insert time and use for example 'hw:Intel' in your apps without
>>> bothering with indexes.
>>>
>>> The missing part is the modification of this text identification using
>>> sysfs at runtime for udev. Some time ago, I was trying to add this setup
>>> to /sys/class/sound, but the sysfs core code was not prepared for this
>>> change. I'll try to check the situation again.
>>>
>>
>> As response to:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012366.html
>>
>> I am not sure if it is good practice to repose to an RFC if so please
>> tell me then we will continue the discussion in the RFC thread.
>>
>> Thank you Jaroslav for creating the patch this is really appreciated, if
>> all things work I will send you some dutch stroopwafels :-D
>>
>> I am just curious how you patch can be used with udev? What did you have
>> in mind?
>>
>> Would something like this be possible:
>>
>> SUBSYSTEM=="sound", ACTION="add" KERNELS=="3-1",
>> NAME="snd/by-id/audiodevice0"
>> SUBSYSTEM=="sound", ACTION="add" KERNELS=="3-2",
>> NAME="snd/by-id/audiodevice1"
>
> No, something like this:
>
> SUBSYSTEM=="sound", ACTION=="add", KERNEL=="controlC*", KERNELS=="3-2", \
>    ATTR{device/id}="audiodevice1"
>
>> pcm.!default {
>>     type plug
>>     slave.pcm dmixer
>> }
>> pcm.dmixer {
>>     type dmix
>>     ipc_key 1024
>>     slave.pcm hw:audiodevice0
>> }
>
> This looks OK.
>
> 					Jaroslav
>

Hello everybody,

It has been a while and I have been waiting until the patch made it into 
Debian and now it finally has, so I started testing and it seems to work 
that the patch works and I am very grateful for it.

I still have list of issues, but I will make new treads for them now.

Thanks again,

Best regards,

Jelle de Jong

--------------050702050305010801040809
Content-Type: text/x-log;
 name="alsa-debug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-debug.log"

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012366.html

------------------------------------------------------------------------

echo 'SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.1", KERNEL=="controlC[0-9]", NAME="snd/controlC4"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.2", KERNEL=="controlC[0-9]", NAME="snd/controlC5"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.3", KERNEL=="controlC[0-9]", NAME="snd/controlC6"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.4", KERNEL=="controlC[0-9]", NAME="snd/controlC7"

SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.1", KERNEL=="pcmC[0-9]D0c", NAME="snd/pcmC4D0c"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.2", KERNEL=="pcmC[0-9]D0c", NAME="snd/pcmC5D0c"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.3", KERNEL=="pcmC[0-9]D0c", NAME="snd/pcmC6D0c"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.4", KERNEL=="pcmC[0-9]D0c", NAME="snd/pcmC7D0c"

SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.1", KERNEL=="pcmC[0-9]D0p", NAME="snd/pcmC4D0p"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.2", KERNEL=="pcmC[0-9]D0p", NAME="snd/pcmC5D0p"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.3", KERNEL=="pcmC[0-9]D0p", NAME="snd/pcmC6D0p"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.4", KERNEL=="pcmC[0-9]D0p", NAME="snd/pcmC7D0p"

SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.1", KERNEL=="controlC[0-9]", ATTR{device/id}="audiodevice1"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.2", KERNEL=="controlC[0-9]", ATTR{device/id}="audiodevice2"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.3", KERNEL=="controlC[0-9]", ATTR{device/id}="audiodevice3"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.4", KERNEL=="controlC[0-9]", ATTR{device/id}="audiodevice4"' | sudo tee /etc/udev/rules.d/10-persistent-sound.rules
sudo chmod 600 /etc/udev/rules.d/10-persistent-sound.rules
sudo cat /etc/udev/rules.d/10-persistent-sound.rules

------------------------------------------------------------------------

echo 'SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.1", MODE="0660", OWNER="root", GROUP="jelle"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.2", MODE="0660", OWNER="root", GROUP="jelle"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.3", MODE="0660", OWNER="root", GROUP="jelle"
SUBSYSTEM=="sound", ACTION=="add", KERNELS=="1-2.4", MODE="0660", OWNER="root", GROUP="jelle"' | sudo tee /etc/udev/rules.d/92-persistent-sound.rules
sudo chmod 600 /etc/udev/rules.d/92-persistent-sound.rules
sudo cat /etc/udev/rules.d/92-persistent-sound.rules

------------------------------------------------------------------------

sudo udevadm control --reload-rules
tail -n 1000 /var/log/syslog

Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid rule '/etc/udev/rules.d/10-persistent-sound.rules:16'
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid ATTRS operation
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid rule '/etc/udev/rules.d/10-persistent-sound.rules:17'
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid ATTRS operation
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid rule '/etc/udev/rules.d/10-persistent-sound.rules:18'
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid ATTRS operation
Jul 27 12:48:38 debian-eeepc udevd[1001]: invalid rule '/etc/udev/rules.d/10-persistent-sound.rules:19'
------------------------------------------------------------------------

$ ls -hal /dev/snd/
total 0
drwxr-xr-x   2 root root       400 2009-07-27 12:29 .
drwxr-xr-x  14 root root      4.2K 2009-07-27 12:29 ..
crw-rw----+  1 root audio 116,   0 2009-07-27 12:18 controlC0
crw-rw----+  1 root jelle 116,  32 2009-07-27 12:29 controlC1
crw-rw----+  1 root jelle 116,  64 2009-07-27 12:29 controlC2
crw-rw----+  1 root jelle 116,  96 2009-07-27 12:29 controlC3
crw-rw----+  1 root jelle 116, 128 2009-07-27 12:29 controlC4
crw-rw----+  1 root audio 116,   4 2009-07-27 12:18 hwC0D0
crw-rw----+  1 root audio 116,  24 2009-07-27 12:18 pcmC0D0c
crw-rw----+  1 root audio 116,  16 2009-07-27 12:18 pcmC0D0p
crw-rw----+  1 root jelle 116,  56 2009-07-27 12:29 pcmC1D0c
crw-rw----+  1 root jelle 116,  48 2009-07-27 12:29 pcmC1D0p
crw-rw----+  1 root jelle 116,  88 2009-07-27 12:29 pcmC2D0c
crw-rw----+  1 root jelle 116,  80 2009-07-27 12:29 pcmC2D0p
crw-rw----   1 root jelle 116, 120 2009-07-27 12:29 pcmC3D0c
crw-rw----+  1 root jelle 116, 112 2009-07-27 12:29 pcmC3D0p
crw-rw----+  1 root jelle 116, 152 2009-07-27 12:29 pcmC4D0c
crw-rw----+  1 root jelle 116, 144 2009-07-27 12:29 pcmC4D0p
crw-rw----+  1 root audio 116,   1 2009-07-27 12:18 seq
crw-rw----+  1 root audio 116,  33 2009-07-27 12:18 timer

$ cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf7eb8000 irq 16
 1 [default        ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-2.1, full speed
 2 [default_1      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-2.2, full speed
 3 [default_2      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-2.3, full speed
 4 [default_3      ]: USB-Audio - USB  AUDIO
                      USB  AUDIO   at usb-0000:00:1d.7-2.4, full speed

------------------------------------------------------------------------

$ udevinfo info --attribute-walk --name=/dev/snd/controlC2
the program '/bin/bash' called 'udevinfo', it should use 'udevadm info <options>', this will stop working in a future release

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2/1-2.2:1.0/sound/card2/controlC2':
    KERNEL=="controlC2"
    SUBSYSTEM=="sound"
    DRIVER==""

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2/1-2.2:1.0/sound/card2':
    KERNELS=="card2"
    SUBSYSTEMS=="sound"
    DRIVERS==""
    ATTRS{id}=="default_1"
    ATTRS{number}=="2"

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2/1-2.2:1.0':
    KERNELS=="1-2.2:1.0"
    SUBSYSTEMS=="usb"
    DRIVERS=="snd-usb-audio"
    ATTRS{bInterfaceNumber}=="00"
    ATTRS{bAlternateSetting}==" 0"
    ATTRS{bNumEndpoints}=="00"
    ATTRS{bInterfaceClass}=="01"
    ATTRS{bInterfaceSubClass}=="01"
    ATTRS{bInterfaceProtocol}=="00"
    ATTRS{modalias}=="usb:v1130pF211d010Bdc00dsc00dp00ic01isc01ip00"
    ATTRS{supports_autosuspend}=="0"

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.2':
    KERNELS=="1-2.2"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{configuration}==""
    ATTRS{bNumInterfaces}==" 5"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bmAttributes}=="80"
    ATTRS{bMaxPower}=="500mA"
    ATTRS{urbnum}=="11825"
    ATTRS{idVendor}=="1130"
    ATTRS{idProduct}=="f211"
    ATTRS{bcdDevice}=="010b"
    ATTRS{bDeviceClass}=="00"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bDeviceProtocol}=="00"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{bMaxPacketSize0}=="8"
    ATTRS{speed}=="12"
    ATTRS{busnum}=="1"
    ATTRS{devnum}=="21"
    ATTRS{version}==" 1.10"
    ATTRS{maxchild}=="0"
    ATTRS{quirks}=="0x0"
    ATTRS{authorized}=="1"
    ATTRS{product}=="USB  AUDIO  "

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-2':
    KERNELS=="1-2"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{configuration}==""
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bmAttributes}=="e0"
    ATTRS{bMaxPower}=="100mA"
    ATTRS{urbnum}=="65"
    ATTRS{idVendor}=="058f"
    ATTRS{idProduct}=="6254"
    ATTRS{bcdDevice}=="0100"
    ATTRS{bDeviceClass}=="09"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{speed}=="480"
    ATTRS{busnum}=="1"
    ATTRS{devnum}=="19"
    ATTRS{version}==" 2.00"
    ATTRS{maxchild}=="4"
    ATTRS{quirks}=="0x0"
    ATTRS{authorized}=="1"

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1':
    KERNELS=="usb1"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{configuration}==""
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bmAttributes}=="e0"
    ATTRS{bMaxPower}=="  0mA"
    ATTRS{urbnum}=="108"
    ATTRS{idVendor}=="1d6b"
    ATTRS{idProduct}=="0002"
    ATTRS{bcdDevice}=="0206"
    ATTRS{bDeviceClass}=="09"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bDeviceProtocol}=="00"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{speed}=="480"
    ATTRS{busnum}=="1"
    ATTRS{devnum}=="1"
    ATTRS{version}==" 2.00"
    ATTRS{maxchild}=="8"
    ATTRS{quirks}=="0x0"
    ATTRS{authorized}=="1"
    ATTRS{manufacturer}=="Linux 2.6.30-1-686 ehci_hcd"
    ATTRS{product}=="EHCI Host Controller"
    ATTRS{serial}=="0000:00:1d.7"
    ATTRS{authorized_default}=="1"

  looking at parent device '/devices/pci0000:00/0000:00:1d.7':
    KERNELS=="0000:00:1d.7"
    SUBSYSTEMS=="pci"
    DRIVERS=="ehci_hcd"
    ATTRS{vendor}=="0x8086"
    ATTRS{device}=="0x27cc"
    ATTRS{subsystem_vendor}=="0x1043"
    ATTRS{subsystem_device}=="0x830f"
    ATTRS{class}=="0x0c0320"
    ATTRS{irq}=="23"
    ATTRS{local_cpus}=="ffffffff"
    ATTRS{local_cpulist}=="0-31"
    ATTRS{modalias}=="pci:v00008086d000027CCsv00001043sd0000830Fbc0Csc03i20"
    ATTRS{broken_parity_status}=="0"
    ATTRS{msi_bus}==""

  looking at parent device '/devices/pci0000:00':
    KERNELS=="pci0000:00"
    SUBSYSTEMS==""
    DRIVERS==""


--------------050702050305010801040809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050702050305010801040809--
