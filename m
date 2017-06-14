From: Hui Wang <hui.wang@canonical.com>
Subject: Re: Dell USB audio driver workaround
Date: Wed, 14 Jun 2017 10:29:13 +0800
Message-ID: <70632d2d-05c9-e6d7-2ba2-b67d0d10e44a@canonical.com>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A32FFC@RTITMBSV09.realtek.com.tw>
 <s5h1t6jxgh5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A33059@RTITMBSV09.realtek.com.tw>
 <s5h37qzm63e.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A330E6@RTITMBSV09.realtek.com.tw>
 <s5h4mbd93c1.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A3313B@RTITMBSV09.realtek.com.tw>
 <s5hvb3t7me0.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A332FD@RTITMBSV09.realtek.com.tw>
 <s5hlh4j18l6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 446642668BF
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 04:29:19 +0200 (CEST)
In-Reply-To: <s5hlh4j18l6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Kailang <kailang@realtek.com>, Tanu Kaskinen <tanuk@iki.fi>, svillar@igalia.com
Cc: "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In this thread, I added tanuk@iki.fi and svillar@igalia.com since they 
reported or discussed similar bugs recently 
(https://www.spinics.net/lists/alsa-devel/msg62460.html and 
https://bugs.freedesktop.org/show_bug.cgi?id=100711).

Right now, we are trying to enable the USB audio for the Dell dock 
stations TB16[1] and WD15[2]. For usb audio part, they have the same 
design, they use realtek alc4020 USB bridge and alc3263 codec, and there 
are one headset jack on the front panel and one speaker output jack on 
the rear panel, but due to some reason (probably it is the firmware's 
problem), the alsa mixers can't reflect there is speaker or headset on 
them, as a result the pulseaudio can't handle the headset or speaker 
correctly.

Right now, the pulseaudio can find a playback device and a record 
device, it is the output and input device for that headset jack, but 
pulseaudio does not think they are headphone and Mic, pulseaudio think 
they are just USB analog output and input devices; for the speaker jack, 
the pulseaudio can't find it at all. so through pulseaudio, we can't 
play any sound to that speaker jack.




This is the output and input devices listed by alsa-utils:

!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
...
card 1: Audio [USB Audio], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: Audio [USB Audio], device 1: USB Audio [USB Audio #1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
...
card 1: Audio [USB Audio], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0




And we can use alsa-utils command to play sound to speaker jack:
$ aplay -D plughw:CARD=1,DEV=1 /usr/share/sounds/speech-dispatcher/test.wav

I don't know how to fix this problem in the kernel driver, if we can let 
driver export standard mixers, this issue will be fixed. But it looks 
like the mixers depend on the firmware, we can't change the firmware, so 
probably we can't fix it in the kernel driver.

Another way to fix it is to add a conf to pulseaudio, in the conf, we 
add one profile for headset(hw:%f,0,0) and one profile for 
speaker(hw:%f,1,0), this is the draft patch I sent to pulseaudio-discuss 
mail list: 
https://lists.freedesktop.org/archives/pulseaudio-discuss/2017-May/028252.html

Do you have any idea to fix this problem? Thanks in advance. And below 
are some logs I collected on the TB16, if you need more logs, just tell 
me, I will collect them for you.






===================================================================
$ amixer -c1 contents > amixser.log
amixer: Control hw:1 element read error: Invalid argument

numid=4,iface=MIXER,name='Mic Capture Switch'
   ; type=BOOLEAN,access=rw------,values=1
   : values=on
numid=5,iface=MIXER,name='Mic Capture Volume'
   ; type=INTEGER,access=rw---R--,values=2,min=0,max=127,step=0
   : values=67,67
   | dBminmax-min=-33.50dB,max=30.00dB
numid=7,iface=MIXER,name='Extension Unit Switch'
   ; type=BOOLEAN,access=rw------,values=1
numid=6,iface=MIXER,name='Loudness'
   ; type=BOOLEAN,access=rw------,values=1
   : values=off
numid=1,iface=PCM,name='Capture Channel Map'
   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
   : values=0,0
   | container
     | chmap-fixed=FL,FR

numid=2,iface=PCM,name='Playback Channel Map'
   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
   : values=0,0
   | container
     | chmap-fixed=FL,FR

numid=3,iface=PCM,name='Playback Channel Map',device=1
   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
   : values=0,0
   | container
     | chmap-fixed=FL,FR
========================================================================
$ cat /proc/asound/card1/usbmixer
USB Mixer: usb_id=0x0bda4014, ctrlif=0, ctlerr=0
Card: Generic USB Audio at usb-0000:0e:00.0-1.5, high speed
   Unit: 3
     Control: name="Loudness", index=0
     Info: id=3, control=10, cmask=0x0, channels=1, type="BOOLEAN"
     Volume: min=0, max=1, dBmin=0, dBmax=0
   Unit: 3
     Control: name="Mic Capture Volume", index=0
     Info: id=3, control=2, cmask=0x3, channels=2, type="S16"
     Volume: min=-8576, max=7680, dBmin=-3350, dBmax=3000
   Unit: 3
     Control: name="Mic Capture Switch", index=0
     Info: id=3, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
     Volume: min=0, max=1, dBmin=0, dBmax=0
   Unit: 4
     Control: name="Extension Unit Switch", index=0
     Info: id=4, control=1, cmask=0x0, channels=1, type="BOOLEAN"
     Volume: min=0, max=1, dBmin=0, dBmax=0
===========================================================================
$ usb-devices
...
T:  Bus=03 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=4014 Rev=00.01
S:  Manufacturer=Generic
S:  Product=USB Audio
S:  SerialNumber=200901010001
C:  #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
....
=================================================================================


With these mixers, the pulseaudio supports this USB sound card as below:

$pactl list cards
Card #0
     Name: alsa_card.usb-Generic_USB_Audio_200901010001-00
     Driver: module-alsa-card.c
     Owner Module: 6
     Properties:
         alsa.card = "1"
         alsa.card_name = "USB Audio"
         alsa.long_card_name = "Generic USB Audio at 
usb-0000:09:00.0-1.5, high speed"
         alsa.driver_name = "snd_usb_audio"
         device.bus_path = "pci-0000:09:00.0-usb-0:1.5:1.0"
         sysfs.path = 
"/devices/pci0000:00/0000:00:1d.6/0000:05:00.0/0000:06:02.0/0000:09:00.0/usb3/3-1/3-1.5/3-1.5:1.0/sound/card1"
         udev.id = "usb-Generic_USB_Audio_200901010001-00"
         device.bus = "usb"
         device.vendor.id = "0bda"
         device.vendor.name = "Realtek Semiconductor Corp."
         device.product.id = "4014"
         device.product.name = "USB Audio"
         device.serial = "Generic_USB_Audio_200901010001"
         device.string = "1"
         device.description = "USB Audio"
         module-udev-detect.discovered = "1"
         device.icon_name = "audio-card-usb"
     Profiles:
         input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, 
priority: 60, available: yes)
         input:iec958-stereo: Digital Stereo (IEC958) Input (sinks: 0, 
sources: 1, priority: 55, available: yes)
         output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 
0, priority: 6000, available: yes)
         output:analog-stereo+input:analog-stereo: Analog Stereo Duplex 
(sinks: 1, sources: 1, priority: 6060, available: yes)
         output:analog-stereo+input:iec958-stereo: Analog Stereo Output 
+ Digital Stereo (IEC958) Input (sinks: 1, sources: 1, priority: 6055, 
available: yes)
         output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, 
sources: 0, priority: 5500, available: yes)
         output:iec958-stereo+input:analog-stereo: Digital Stereo 
(IEC958) Output + Analog Stereo Input (sinks: 1, sources: 1, priority: 
5560, available: yes)
         output:iec958-stereo+input:iec958-stereo: Digital Stereo Duplex 
(IEC958) (sinks: 1, sources: 1, priority: 5555, available: yes)
         off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
     Active Profile: output:analog-stereo+input:analog-stereo





[1] 
http://www.dell.com/support/article/us/en/19/SLN301105/dell-thunderbolt-dock--tb16--information--specifications--frequently-asked-questions?lang=EN
[2] 
http://www.dell.com/support/article/us/en/19/SLN304627/dell-dock-wd15--usb-type-c---information--capability-and-specifications?lang=EN









On 04/12/2016 05:26 PM, Takashi Iwai wrote:
> On Tue, 12 Apr 2016 05:02:08 +0200,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> Attach is new patch witch follow your method.
>> Many Thanks for you. ^^
> OK, I applied it with a few modification / correction in the comments
> and the changelog.  Also added Cc to stable.
>
>
> thanks,
>
> Takashi
>
>
>> BR,
>> Kailang
>>
>>> -----Original Message-----
>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>> Sent: Thursday, April 07, 2016 6:18 PM
>>> To: Kailang
>>> Cc: (alsa-devel@alsa-project.org)
>>> Subject: Re: Dell USB audio driver workaround
>>>
>>> On Thu, 07 Apr 2016 12:07:25 +0200,
>>> Kailang wrote:
>>>>   
>>>>
>>>>> -----Original Message-----
>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>> Sent: Thursday, April 07, 2016 5:27 PM
>>>>> To: Kailang
>>>>> Cc: (alsa-devel@alsa-project.org)
>>>>> Subject: Re: Dell USB audio driver workaround
>>>>>
>>>>> On Thu, 07 Apr 2016 09:05:52 +0200,
>>>>> Kailang wrote:
>>>>>>   
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>>>> Sent: Wednesday, April 06, 2016 5:37 PM
>>>>>>> To: Kailang
>>>>>>> Cc: (alsa-devel@alsa-project.org)
>>>>>>> Subject: Re: Dell USB audio driver workaround
>>>>>>>
>>>>>>> On Wed, 06 Apr 2016 11:22:43 +0200, Kailang wrote:
>>>>>>>>   
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>>>>>> Sent: Wednesday, April 06, 2016 4:57 PM
>>>>>>>>> To: Kailang
>>>>>>>>> Cc: (alsa-devel@alsa-project.org)
>>>>>>>>> Subject: Re: Dell USB audio driver workaround
>>>>>>>>>
>>>>>>>>> On Wed, 06 Apr 2016 08:29:12 +0200, Kailang wrote:
>>>>>>>>>> Hi Takashi,
>>>>>>>>>>
>>>>>>>>>> Dell had USB dock.
>>>>>>>>>> Maybe firmware issue, the master volume always
>>> keep at 0x57.
>>>>>>>>>> Attach patch will fix it to keep at Max volume.
>>>>>>>>>>
>>>>>>>>>> Could you help us to update it?
>>>>>>>>> Well, I don't get how this patch works..
>>>>>>>>>
>>>>>>>>>> diff --git a/sound/usb/mixer.c
>>> b/sound/usb/mixer.c index
>>>>>>>>>> 4f85757..84d9a4e 100644
>>>>>>>>>> --- a/sound/usb/mixer.c
>>>>>>>>>> +++ b/sound/usb/mixer.c
>>>>>>>>>> @@ -846,6 +846,12 @@ static void
>>>>> volume_control_quirks(struct
>>>>>>>>>> usb_mixer_elem_info *cval,  {
>>>>>>>>>>   	struct snd_usb_audio *chip =
>>> cval->head.mixer->chip;
>>>>>>>>>>   	switch (chip->usb_id) {
>>>>>>>>>> +	case USB_ID(0x0bda, 0x4014): /* Dell
>>> workaround */
>>>>>>>>>> +		if (strstr(kctl->id.name, "Playback
>>>>>>> Volume") != NULL) {
>>>>>>>>>> +			cval->min = 0x0000;
>>>>>>>>>> +			cval->max = 0x0000;
>>>>>>>>>> +		}
>>>>>>>>>> +		break;
>>>>>>>>> So, this means that this value has to be fixed to 0?
>>>>>>>>> If yes, can't we simply remove this volume instead?
>>>>>>>> Yes, but it need to set Max volume to 0. This is test
>>>>> on my site.
>>>>>>>> Because it will rewrite 0x57 value to codec register when
>>>>>>> driver is loaded.
>>>>>>>> And keep 0x57 volume value all the time. So, Master volume
>>>>>>> will lower than windows machine.
>>>>>>>> This case which driver fail to build the alsa mixer(This is
>>>>>>> firmware cause it). So, no hardware volume control on this.
>>>>>>>> If the Max volume value is 0,  system will not set default
>>>>>>> value 0x57 for first time loading driver.
>>>>>>>
>>>>>>> Which values (min/max) does this FU take and which values
>>>>> are buggy?
>>>>>> Max value.
>>>>> Sorry, my question wasn't clear.  "What" min and max are they?
>>>>> min=0 and max=0x57?
>>>> Oh! Sorry. It's my wrong. I forgot.
>>>>
>>>> Unit: 16
>>>>      Control: name="PCM Playback Volume", index=0
>>>>      Info: id=16, control=2, cmask=0x3, channels=2, type="S16"
>>>>      Volume: min=-16256, max=0, dBmin=-6350, dBmax=0
>>>>
>>>> 0x0 (codec reg)  = (-16256) (USB vloume level) 0x57(codec reg) =
>>>> 0xEC00(USB vloume level) 0x7F(codec reg) = 0x0000 (USB vloume level)
>>>>
>>>>> And, your patch changes both min and max to be 0.  That is, it
>>>>> accepts only 0.  Does it mean that this FU isn't any
>>> proper volume
>>>>> control?
>>>> cval->max original is 0.
>>>> cval->min => I set it to 0. It will be not rewrite 0x57
>>> value to codec.
>>>
>>> OK, now it's clear, thanks.
>>>
>>> Though, I still don't like to set min = max.  It basically
>>> makes this control useless, and then there is no reason to
>>> keep this exposed.
>>>
>>> Can we just skip parsing this control, then?  You can create
>>> an own usbmix_name_map[] to indicate the ID to skip building
>>> a control by passing NULL to its name.  That is, a patch like
>>> below.  (You need to fill the right ID number in the patch,
>>> of course.)
>>>
>>>
>>> Takashi
>>>
>>> ---
>>> diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
>>> --- a/sound/usb/mixer_maps.c
>>> +++ b/sound/usb/mixer_maps.c
>>> @@ -349,6 +349,16 @@ static struct usbmix_name_map
>>> bose_companion5_map[] = {  };
>>>   
>>>   /*
>>> + * Dell XXX with ALC4020 codec had a firmware problem where it got
>>> + * screwed up when zero volume is passed; just skip it as a
>>> workaround
>>> +*/ static const struct usbmix_name_map dell_alc4020_map[] = {
>>> +	{ 10 /* XXX fill this right ID XXX */, NULL },
>>> +	{ 0 }
>>> +};
>>> +
>>> +
>>> +/*
>>>    * Control map entries
>>>    */
>>>   
>>> @@ -423,6 +433,10 @@ static struct usbmix_ctl_map
>>> usbmix_ctl_maps[] = {
>>>   		.map = maya44_map,
>>>   	},
>>>   	{
>>> +		.id = USB_ID(0x0bda, 0x4014),
>>> +		.map = dell_alc4020_map,
>>> +	},
>>> +	{
>>>   		.id = USB_ID(0x0c45, 0x1158),
>>>   		.map = justlink_map,
>>>   	},
>>>
>>> ------Please consider the environment before printing this e-mail.
>>>
>> [2 0001-Dell-usb-dock-vloume-issue.patch <application/octet-stream (base64)>]
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
