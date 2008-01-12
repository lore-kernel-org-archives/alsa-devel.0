From: De Fuuss <fuuss@hotmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Sat, 12 Jan 2008 15:13:04 +0000
Message-ID: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_6c2f4b92-0a7d-47c5-8738-37e4caa29222_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s13.bay0.hotmail.com (bay0-omc3-s13.bay0.hotmail.com
	[65.54.246.213]) by alsa0.perex.cz (Postfix) with ESMTP id C6DCD247B0
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 16:13:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

I reopened my shuttle case, closely inspected the motherboard and I think I=
 found the issue. The onboard sound was factory set off (jumper), something=
 which I must admit I did not check. However, I find it hard to imagine tha=
t XPC would sell their barebones with onboard sound off as a default. Even =
more weird, the headphones work when the onboard sound is "off".
I get the uneasy feeling that something is messed up with this board. Anywa=
y, for completeness' sake, I attached the results of amixer contents, cat /=
proc/asound/card0/codec#0 and dmesg for the module loaded as 6stack-dig. I =
have to try 6stack-hp again to confirm if I get something there.

Patrick

> From: zhe.jiang@intel.com
> To: fuuss@hotmail.com
> Date: Fri, 11 Jan 2008 12:58:07 +0800
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>
> On Thu, 2008-01-10 at 16:09 +0000, De Fuuss wrote:
>> Hi,
>>
>> 6stack-dig, 6stack-hp: I tested all channels, and indeed I get sound but=
 only from the headphone jack on the front. All other channels remain silen=
t (front, center,rear,...)
>>
> Hi,
>
> It's a little weird that the sound only come from headphone.
> Seems that the 0x1b is the hp pin and 0x14 is the Front line out pin.
> Both of them are connected to 0x0c widget.
> If there is sound on hp, there should be sound on Front line out.
>
> May you rebuild the alsa-driver with debug option to get some info?
> ./configure --with-debug=3Ddetect;
> make;make install;
>
> After reload the driver,
> please show the result of "amixer contents",
> "cat /proc/asound/card0/codec#0" and "dmesg".
>
> Thanks!
>> Regards,
>>
>> Patrick
>>
>>> From: zhe.jiang@intel.com
>>> To: fuuss@hotmail.com
>>> Date: Thu, 10 Jan 2008 13:46:42 +0800
>>> CC: alsa-devel@alsa-project.org
>>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>>>
>>> On Fri, 2007-12-28 at 19:09 +0800, De Fuuss wrote:
>>>>
>>>> Hi,
>>>>
>>>> Here's the pastebin information http://pastebin.ca/834640
>>>>
>>>> That was using 3stack-6ch-dig
>>> The 3stack-6ch-dig won't work because it use 0x18 and 0x1a as
>>> the effective pins, which is different from your pins layout.
>>>>
>>>> For experimentation's sake:
>>>>
>>>> If I use 6stack-dig I get the following http://pastebin.ca/834644
>>>> If I use 6stack-hp I get the following http://pastebin.ca/834646
>>>>
>>> Did you do any testing with those two configures?
>>> After analyzing your information,
>>> I guess that you can get voice from the output jacks with those
>>> configurations.
>>>
>>>
>>>> Thanks for helping me out. It would be nice if it worked :-)
>>>>
>>>> Patrick
>>>>
>>>>> From: tdavis@dsl-only.net
>>>>> To: fuuss@hotmail.com
>>>>> Date: Thu, 27 Dec 2007 20:22:57 -0800
>>>>> CC: alsa-devel@alsa-project.org
>>>>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>>>>>
>>>>> Ok, need to step back in the thread a bit. Now that we've
>>>> established
>>>>> that this is not an Intel manufactured motherboard (not that they
>>>> make
>>>>> their own anymore), I need more detailed information on what the OS
>>>>> see's. Please run
>>>>> http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh and post
>>>> the
>>>>> link that it generates. This will give me a detailed snapshot of
>>>> your
>>>>> hardware that I can use for debugging.
>>>>>
>>>>> I will begin working on this as soon as I get this info. I hope to
>>>> get
>>>>> you enabled this weekend if possible, this year at the latest. :)
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Tobin
>>>> ----------------------------------------
>>>>> From: tdavis@dsl-only.net
>>>>> To: fuuss@hotmail.com
>>>>> Date: Thu, 27 Dec 2007 20:22:57 -0800
>>>>> CC: alsa-devel@alsa-project.org
>>>>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>>>>>
>>>>> Ok, need to step back in the thread a bit. Now that we've
>>>> established
>>>>> that this is not an Intel manufactured motherboard (not that they
>>>> make
>>>>> their own anymore), I need more detailed information on what the OS
>>>>> see's. Please run
>>>>> http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh and post
>>>> the
>>>>> link that it generates. This will give me a detailed snapshot of
>>>> your
>>>>> hardware that I can use for debugging.
>>>>>
>>>>> I will begin working on this as soon as I get this info. I hope to
>>>> get
>>>>> you enabled this weekend if possible, this year at the latest. :)
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Tobin
>>>>>
>>>>>
>>>>> On Thu, 2007-12-27 at 00:33 +0000, De Fuuss wrote:
>>>>>
>>>>>> Hi Tobin,
>>>>>>
>>>>>> Thanks for you quick reply.
>>>>>>
>>>>>> I tried both 3stack-6ch and 3stack-6ch-dig (the card has a spdif
>>>> out). I found out that when putting on headphones on a separate
>>>> headphone jack I get some sound with both settings. Hoever, the front
>>>> out l/r, center/bass sourround back l/r and side sourround l/r port
>>>> remain silent.
>>>>>>
>>>>>> I set all channels to 80-100% in alsamixer.
>>>>>>
>>>>>> A few more details from my setup:
>>>>>> Shuttle XPC SG33G5M
>>>>>> Intel G33 Express + ICH9DH
>>>>>>
>>>>>> Interestingly, when I run alsamixer, it identifies the Chip as
>>>> "Generic 1095 ID 1392", in other words in points to codec#1. I thought
>>>> it should point to codec#0, e.g. RealTek ALC888
>>>>>>
>>>>>> I have the strong impression that the channels are not truly set by
>>>> alsamixer as they point to the wrong codec. I'm only a layman in ALSA,
>>>> and I have no idea how to tell alsamixer to consider codec#0 instead
>>>> codec#1.
>>>>>>
>>>>>> Do you have any idea on how to crack this nut?
>>>>>>
>>>>>> Below is the output of both codecs:
>>>>>>
>>>>>> Thank you.
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> Patrick
>>>>>>
>>>>>> ____________________
>>>>>> #cat /proc/asound/cards
>>>>>>
>>>>>> 0 [Intel ]: HDA-Intel - HDA Intel
>>>>>> HDA Intel at 0xfdff8000 irq 22
>>>>>>
>>>>>> # cat /proc/asound/Intel/codec#0
>>>>>> Codec: Realtek ALC888
>>>>>> Address: 0
>>>>>> Vendor Id: 0x10ec0888
>>>>>> Subsystem Id: 0x12970888
>>>>>> Revision Id: 0x100001
>>>>>> No Modem Function Group found
>>>>>> Default PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Default Amp-In caps: N/A
>>>>>> Default Amp-Out caps: N/A
>>>>>> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x04 [Audio Output] wcaps 0x11: Stereo
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x05 [Audio Output] wcaps 0x11: Stereo
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>>>>>> PCM:
>>>>>> rates [0x5e0]: 44100 48000 88200 96000 192000
>>>>>> bits [0x1e]: 16 20 24 32
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>>>>> Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
>>>>>> Amp-In vals: [0x9f 0x9f]
>>>>>> PCM:
>>>>>> rates [0x160]: 44100 48000 96000
>>>>>> bits [0x6]: 16 20
>>>>>> formats [0x1]: PCM
>>>>>> Connection: 1
>>>>>> 0x23
>>>>>> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>>>>>> Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
>>>>>> Amp-In vals: [0x9f 0x9f]
>>>>>> PCM:
>>>>>> rates [0x160]: 44100 48000 96000
>>>>>> bits [0x6]: 16 20
>>>>>> formats [0x1]: PCM
>>>>>> Connection: 1
>>>>>> 0x22
>>>>>> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0x1e]: 16 20 24 32
>>>>>> formats [0x1]: PCM
>>>>>> Connection: 1
>>>>>> 0x1f
>>>>>> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>>>>> Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
>>>>>> Amp-In vals: [0x80 0x80] [0x80 0x80] [0x9d 0x9d] [0x80 0x80]
>>>> [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
>>>> 0x80]
>>>>>> Connection: 10
>>>>>> 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
>>>>>> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
>>>>>> Amp-Out vals: [0x1d 0x1d]
>>>>>> Connection: 2
>>>>>> 0x02 0x0b
>>>>>> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
>>>>>> Amp-Out vals: [0x1f 0x1f]
>>>>>> Connection: 2
>>>>>> 0x03 0x0b
>>>>>> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
>>>>>> Amp-Out vals: [0x1f 0x1f]
>>>>>> Connection: 2
>>>>>> 0x04 0x0b
>>>>>> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x80 0x80] [0x80 0x80]
>>>>>> Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Connection: 2
>>>>>> 0x05 0x0b
>>>>>> Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x083e: IN OUT HP Detect
>>>>>> Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Green
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c* 0x0d 0x0e 0x0f 0x26
>>>>>> Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x083e: IN OUT HP Detect
>>>>>> Pin Default 0x01011012: [Jack] Line Out at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Black
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c 0x0d* 0x0e 0x0f 0x26
>>>>>> Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x0836: IN OUT Detect
>>>>>> Pin Default 0x01016011: [Jack] Line Out at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Orange
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c 0x0d 0x0e* 0x0f 0x26
>>>>>> Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x0836: IN OUT Detect
>>>>>> Pin Default 0x01012014: [Jack] Line Out at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Grey
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c 0x0d 0x0e 0x0f* 0x26
>>>>>> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x08373e: IN OUT HP Detect
>>>>>> Pin Default 0x01813040: [Jack] Line In at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Blue
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c 0x0d 0x0e* 0x0f 0x26
>>>>>> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x80 0x80]
>>>>>> Pincap 0x08373e: IN OUT HP Detect
>>>>>> Pin Default 0x02a19850: [Jack] Mic at Ext Front
>>>>>> Conn =3D 1/8, Color =3D Pink
>>>>>> Pin-ctls: 0x24: IN
>>>>>> Connection: 5
>>>>>> 0x0c* 0x0d 0x0e 0x0f 0x26
>>>>>> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x08373e: IN OUT HP Detect
>>>>>> Pin Default 0x9993014f: [Fixed] Aux at Int ATAPI
>>>>>> Conn =3D ATAPI, Color =3D Unknown
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 5
>>>>>> 0x0c 0x0d* 0x0e 0x0f 0x26
>>>>>> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>>>> [0x00 0x00]
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Pincap 0x08373e: IN OUT HP Detect
>>>>>> Pin Default 0x02214020: [Jack] HP Out at Ext Front
>>>>>> Conn =3D 1/8, Color =3D Green
>>>>>> Pin-ctls: 0xc0: OUT HP
>>>>>> Connection: 5
>>>>>> 0x0c* 0x0d 0x0e 0x0f 0x26
>>>>>> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>>>>>> Pincap 0x0820: IN
>>>>>> Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>>>>>> Conn =3D 1/8, Color =3D Black
>>>>>> Pin-ctls: 0x20: IN
>>>>>> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>>>>>> Pincap 0x0820: IN
>>>>>> Pin Default 0x4005a603: [N/A] Line Out at Ext N/A
>>>>>> Conn =3D Optical, Color =3D UNKNOWN
>>>>>> Pin-ctls: 0x20: IN
>>>>>> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>>>>>> Pincap 0x0810: OUT
>>>>>> Pin Default 0x01451130: [Jack] SPDIF Out at Ext Rear
>>>>>> Conn =3D Optical, Color =3D Black
>>>>>> Pin-ctls: 0x40: OUT
>>>>>> Connection: 1
>>>>>> 0x06
>>>>>> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>>>>>> Pincap 0x0820: IN
>>>>>> Pin Default 0x01c59160: [Jack] SPDIF In at Ext Rear
>>>>>> Conn =3D Optical, Color =3D Pink
>>>>>> Pin-ctls: 0x20: IN
>>>>>> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
>>>>>> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80]
>>>> [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
>>>> 0x80] [0x80 0x80]
>>>>>> Connection: 11
>>>>>> 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
>>>>>> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80]
>>>> [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
>>>> 0x80] [0x80 0x80]
>>>>>> Connection: 11
>>>>>> 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
>>>>>> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>>>>> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>>>>>> PCM:
>>>>>> rates [0x560]: 44100 48000 96000 192000
>>>>>> bits [0xe]: 16 20 24
>>>>>> formats [0x1]: PCM
>>>>>> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>>>>>> Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-In vals: [0x00 0x00] [0x80 0x80]
>>>>>> Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
>>>>>> Amp-Out vals: [0x00 0x00]
>>>>>> Connection: 2
>>>>>> 0x25 0x0b
>>>>>>
>>>>>> A second codec sits at /proc/asound/Intel/codec#0. A cat results
>>>> in:
>>>>>>
>>>>>> Codec: Generic 1095 ID 1392
>>>>>> Address: 1
>>>>>> Vendor Id: 0x10951392
>>>>>> Subsystem Id: 0xffffffff
>>>>>> Revision Id: 0x100000
>>>>>> No Modem Function Group found
>>>>>> Default PCM:
>>>>>> rates [0x0]:
>>>>>> bits [0x0]:
>>>>>> formats [0x0]:
>>>>>> Default Amp-In caps: N/A
>>>>>> Default Amp-Out caps: N/A
>>>>>> Node 0x02 [Audio Output] wcaps 0x6211: Stereo Digital
>>>>>> PCM:
>>>>>> rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>>>>> bits [0x1e]: 16 20 24 32
>>>>>> formats [0x5]: PCM AC3
>>>>>> Node 0x03 [Pin Complex] wcaps 0x40738d: Stereo Digital Amp-Out
>>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>>> Amp-Out vals: [0x80 0x80]
>>>>>> Pincap 0x0894: OUT Detect
>>>>>> Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>>>>> Conn =3D Digital, Color =3D Unknown
>>>>>> Pin-ctls: 0x00:
>>>>>> Connection: 1
>>>>>> 0x02
>>>>>>
>>>>>>
>>>>>>> From: tdavis@dsl-only.net
>>>>>>> To: fuuss@hotmail.com
>>>>>>> Date: Wed, 26 Dec 2007 11:30:28 -0800
>>>>>>> CC: alsa-devel@alsa-project.org
>>>>>>> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>>>>>>>
>>>>>>> Try "model=3D3stack-6ch". Also, if you look in the
>>>>>>>
>>>> alsa-driver-1.0.15/alsa-kernel/Documentation/Alsa-Configuration.txt
>>>>>>> file, there are other models you can select for the alc883/888
>>>> codec.
>>>>>>>
>>>>>>> Let me know if this works and I'll add your system to the driver.
>>>>>>>
>>>>>>> Tobin
>>>>>>>
>>>>>>> On Wed, 2007-12-26 at 18:42 +0000, De Fuuss wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Maybe I'm missing something, but I've failed to get even the
>>>> slightest
>>>>>>>> noise out of the onboard sound card from a Intel G33 motherboard.
>>>> I
>>>>>>>> tried the alsa drivers from the alsa-driver-1.0.15 package as
>>>> well as
>>>>>>>> the the alsa drivers provided by kernel 2.6.23 (built as
>>>> modules), to
>>>>>>>> no avail.
>>>>>>>>
>>>>>>>> The sound chip is identified as a Intel HDA / Realtek ALC888 on
>>>> the Intel G33 ICH9 motherboard.
>>>>>>>>
>>>>>>>> After reading some of the documentation from the ALSA site and
>>>> googling through half the internet I haven't found out yet if this
>>>> specific sound card is supported by ALSA and if some module options
>>>> must be passed (such as options snd-intel-hda model=3D.....).
>>>>>>>>
>>>>>>>> Could somebody be so kind as to point me into the right
>>>> direction?
>>>>>>>>
>>>>>>>> Thank you.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> Patrick
>>>>>>>>
>>>>>>>> _________________________________________________________________
>>>>>>>> Express yourself instantly with MSN Messenger! Download today
>>>> it's FREE!
>>>>>>>> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>>>>>>>> _______________________________________________
>>>>>>>> Alsa-devel mailing list
>>>>>>>> Alsa-devel@alsa-project.org
>>>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>>>>
>>>>>>> --
>>>>>>> Tobin Davis
>>>>>>>
>>>>>>>
>>>>>>> TONY RANDALL! Is YOUR life a PATIO of FUN??
>>>>>>> _______________________________________________
>>>>>>> Alsa-devel mailing list
>>>>>>> Alsa-devel@alsa-project.org
>>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>>>
>>>>>> _________________________________________________________________
>>>>>> Express yourself instantly with MSN Messenger! Download today it's
>>>> FREE!
>>>>>> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>>>>>> _______________________________________________
>>>>>> Alsa-devel mailing list
>>>>>> Alsa-devel@alsa-project.org
>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>>
>>>>> --
>>>>> Tobin Davis
>>>>>
>>>>>
>>>>> Authors are easy to get on with -- if you're fond of children.
>>>>> -- Michael Joseph, "Observer"
>>>>
>>>> _________________________________________________________________
>>>> Express yourself instantly with MSN Messenger! Download today it's
>>>> FREE!
>>>> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>
>>>>
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>> _________________________________________________________________
>> Express yourself instantly with MSN Messenger! Download today it's FREE!
>> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="amixer.txt"

IyBhbWl4ZXIgY29udGVudHMNCm51bWlkPTExLGlmYWNlPU1JWEVSLG5hbWU9J0hlYWRwaG9uZSBQ
bGF5YmFjayBTd2l0Y2gnDQogIDsgdHlwZT1CT09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2YWx1ZXM9
Mg0KICA6IHZhbHVlcz1vbixvbg0KbnVtaWQ9MjAsaWZhY2U9TUlYRVIsbmFtZT0nRnJvbnQgTWlj
IEJvb3N0Jw0KICA7IHR5cGU9SU5URUdFUixhY2Nlc3M9cnctLS1SLS0sdmFsdWVzPTIsbWluPTAs
bWF4PTMsc3RlcD0wDQogIDogdmFsdWVzPTAsMA0KICB8IGRCc2NhbGUtbWluPTAuMDBkQixzdGVw
PTEwLjAwZEIsbXV0ZT0wDQpudW1pZD0yMSxpZmFjZT1NSVhFUixuYW1lPSdGcm9udCBNaWMgUGxh
eWJhY2sgU3dpdGNoJw0KICA7IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTIN
CiAgOiB2YWx1ZXM9b2ZmLG9mZg0KbnVtaWQ9MTksaWZhY2U9TUlYRVIsbmFtZT0nRnJvbnQgTWlj
IFBsYXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlOVEVHRVIsYWNjZXNzPXJ3LS0tUi0tLHZhbHVl
cz0yLG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2YWx1ZXM9MCwwDQogIHwgZEJzY2FsZS1taW49
NDI5NDk2MzguNDZkQixzdGVwPTEuNTBkQixtdXRlPTANCm51bWlkPTIsaWZhY2U9TUlYRVIsbmFt
ZT0nRnJvbnQgUGxheWJhY2sgU3dpdGNoJw0KICA7IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0t
LS0sdmFsdWVzPTINCiAgOiB2YWx1ZXM9b24sb24NCm51bWlkPTEsaWZhY2U9TUlYRVIsbmFtZT0n
RnJvbnQgUGxheWJhY2sgVm9sdW1lJw0KICA7IHR5cGU9SU5URUdFUixhY2Nlc3M9cnctLS1SLS0s
dmFsdWVzPTIsbWluPTAsbWF4PTMxLHN0ZXA9MA0KICA6IHZhbHVlcz0yOSwyOQ0KICB8IGRCc2Nh
bGUtbWluPTQyOTQ5NjI2LjQ2ZEIsc3RlcD0xLjUwZEIsbXV0ZT0wDQpudW1pZD00LGlmYWNlPU1J
WEVSLG5hbWU9J1N1cnJvdW5kIFBsYXliYWNrIFN3aXRjaCcNCiAgOyB0eXBlPUJPT0xFQU4sYWNj
ZXNzPXJ3LS0tLS0tLHZhbHVlcz0yDQogIDogdmFsdWVzPW9uLG9uDQpudW1pZD0zLGlmYWNlPU1J
WEVSLG5hbWU9J1N1cnJvdW5kIFBsYXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlOVEVHRVIsYWNj
ZXNzPXJ3LS0tUi0tLHZhbHVlcz0yLG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2YWx1ZXM9MzEs
MzENCiAgfCBkQnNjYWxlLW1pbj00Mjk0OTYyNi40NmRCLHN0ZXA9MS41MGRCLG11dGU9MA0KbnVt
aWQ9NyxpZmFjZT1NSVhFUixuYW1lPSdDZW50ZXIgUGxheWJhY2sgU3dpdGNoJw0KICA7IHR5cGU9
Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTENCiAgOiB2YWx1ZXM9b24NCm51bWlkPTUs
aWZhY2U9TUlYRVIsbmFtZT0nQ2VudGVyIFBsYXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlOVEVH
RVIsYWNjZXNzPXJ3LS0tUi0tLHZhbHVlcz0xLG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2YWx1
ZXM9MzENCiAgfCBkQnNjYWxlLW1pbj00Mjk0OTYyNi40NmRCLHN0ZXA9MS41MGRCLG11dGU9MA0K
bnVtaWQ9OCxpZmFjZT1NSVhFUixuYW1lPSdMRkUgUGxheWJhY2sgU3dpdGNoJw0KICA7IHR5cGU9
Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTENCiAgOiB2YWx1ZXM9b24NCm51bWlkPTYs
aWZhY2U9TUlYRVIsbmFtZT0nTEZFIFBsYXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlOVEVHRVIs
YWNjZXNzPXJ3LS0tUi0tLHZhbHVlcz0xLG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2YWx1ZXM9
MzENCiAgfCBkQnNjYWxlLW1pbj00Mjk0OTYyNi40NmRCLHN0ZXA9MS41MGRCLG11dGU9MA0KbnVt
aWQ9MTUsaWZhY2U9TUlYRVIsbmFtZT0nTGluZSBQbGF5YmFjayBTd2l0Y2gnDQogIDsgdHlwZT1C
T09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2YWx1ZXM9Mg0KICA6IHZhbHVlcz1vZmYsb2ZmDQpudW1p
ZD0xNCxpZmFjZT1NSVhFUixuYW1lPSdMaW5lIFBsYXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlO
VEVHRVIsYWNjZXNzPXJ3LS0tUi0tLHZhbHVlcz0yLG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2
YWx1ZXM9MzEsMzENCiAgfCBkQnNjYWxlLW1pbj00Mjk0OTYzOC40NmRCLHN0ZXA9MS41MGRCLG11
dGU9MA0KbnVtaWQ9MTMsaWZhY2U9TUlYRVIsbmFtZT0nQ0QgUGxheWJhY2sgU3dpdGNoJw0KICA7
IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTINCiAgOiB2YWx1ZXM9b2ZmLG9m
Zg0KbnVtaWQ9MTIsaWZhY2U9TUlYRVIsbmFtZT0nQ0QgUGxheWJhY2sgVm9sdW1lJw0KICA7IHR5
cGU9SU5URUdFUixhY2Nlc3M9cnctLS1SLS0sdmFsdWVzPTIsbWluPTAsbWF4PTMxLHN0ZXA9MA0K
ICA6IHZhbHVlcz0zMSwzMQ0KICB8IGRCc2NhbGUtbWluPTQyOTQ5NjM4LjQ2ZEIsc3RlcD0xLjUw
ZEIsbXV0ZT0wDQpudW1pZD0xNyxpZmFjZT1NSVhFUixuYW1lPSdNaWMgQm9vc3QnDQogIDsgdHlw
ZT1JTlRFR0VSLGFjY2Vzcz1ydy0tLVItLSx2YWx1ZXM9MixtaW49MCxtYXg9MyxzdGVwPTANCiAg
OiB2YWx1ZXM9MCwwDQogIHwgZEJzY2FsZS1taW49MC4wMGRCLHN0ZXA9MTAuMDBkQixtdXRlPTAN
Cm51bWlkPTE4LGlmYWNlPU1JWEVSLG5hbWU9J01pYyBQbGF5YmFjayBTd2l0Y2gnDQogIDsgdHlw
ZT1CT09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2YWx1ZXM9Mg0KICA6IHZhbHVlcz1vZmYsb2ZmDQpu
dW1pZD0xNixpZmFjZT1NSVhFUixuYW1lPSdNaWMgUGxheWJhY2sgVm9sdW1lJw0KICA7IHR5cGU9
SU5URUdFUixhY2Nlc3M9cnctLS1SLS0sdmFsdWVzPTIsbWluPTAsbWF4PTMxLHN0ZXA9MA0KICA6
IHZhbHVlcz0wLDANCiAgfCBkQnNjYWxlLW1pbj00Mjk0OTYzOC40NmRCLHN0ZXA9MS41MGRCLG11
dGU9MA0KbnVtaWQ9MjMsaWZhY2U9TUlYRVIsbmFtZT0nUEMgU3BlYWtlciBQbGF5YmFjayBTd2l0
Y2gnDQogIDsgdHlwZT1CT09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2YWx1ZXM9Mg0KICA6IHZhbHVl
cz1vZmYsb2ZmDQpudW1pZD0yMixpZmFjZT1NSVhFUixuYW1lPSdQQyBTcGVha2VyIFBsYXliYWNr
IFZvbHVtZScNCiAgOyB0eXBlPUlOVEVHRVIsYWNjZXNzPXJ3LS0tUi0tLHZhbHVlcz0yLG1pbj0w
LG1heD0zMSxzdGVwPTANCiAgOiB2YWx1ZXM9MCwwDQogIHwgZEJzY2FsZS1taW49NDI5NDk2Mzgu
NDZkQixzdGVwPTEuNTBkQixtdXRlPTANCm51bWlkPTI1LGlmYWNlPU1JWEVSLG5hbWU9J0NhcHR1
cmUgU3dpdGNoJw0KICA7IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTINCiAg
OiB2YWx1ZXM9b2ZmLG9mZg0KbnVtaWQ9MjcsaWZhY2U9TUlYRVIsbmFtZT0nQ2FwdHVyZSBTd2l0
Y2gnLGluZGV4PTENCiAgOyB0eXBlPUJPT0xFQU4sYWNjZXNzPXJ3LS0tLS0tLHZhbHVlcz0yDQog
IDogdmFsdWVzPW9mZixvZmYNCm51bWlkPTI0LGlmYWNlPU1JWEVSLG5hbWU9J0NhcHR1cmUgVm9s
dW1lJw0KICA7IHR5cGU9SU5URUdFUixhY2Nlc3M9cnctLS1SLS0sdmFsdWVzPTIsbWluPTAsbWF4
PTMxLHN0ZXA9MA0KICA6IHZhbHVlcz0zMSwzMQ0KICB8IGRCc2NhbGUtbWluPTQyOTQ5NjU2LjQ2
ZEIsc3RlcD0xLjUwZEIsbXV0ZT0wDQpudW1pZD0yNixpZmFjZT1NSVhFUixuYW1lPSdDYXB0dXJl
IFZvbHVtZScsaW5kZXg9MQ0KICA7IHR5cGU9SU5URUdFUixhY2Nlc3M9cnctLS1SLS0sdmFsdWVz
PTIsbWluPTAsbWF4PTMxLHN0ZXA9MA0KICA6IHZhbHVlcz0zMSwzMQ0KICB8IGRCc2NhbGUtbWlu
PTQyOTQ5NjU2LjQ2ZEIsc3RlcD0xLjUwZEIsbXV0ZT0wDQpudW1pZD0zMSxpZmFjZT1NSVhFUixu
YW1lPSdJRUM5NTggUGxheWJhY2sgQ29uIE1hc2snDQogIDsgdHlwZT1JRUM5NTgsYWNjZXNzPXIt
LS0tLS0tLHZhbHVlcz0xDQogIDogdmFsdWVzPVtBRVMwPTB4MGYgQUVTMT0weGZmIEFFUzI9MHgw
MCBBRVMzPTB4MDBdDQpudW1pZD0zMixpZmFjZT1NSVhFUixuYW1lPSdJRUM5NTggUGxheWJhY2sg
UHJvIE1hc2snDQogIDsgdHlwZT1JRUM5NTgsYWNjZXNzPXItLS0tLS0tLHZhbHVlcz0xDQogIDog
dmFsdWVzPVtBRVMwPTB4MGYgQUVTMT0weDAwIEFFUzI9MHgwMCBBRVMzPTB4MDBdDQpudW1pZD0z
MyxpZmFjZT1NSVhFUixuYW1lPSdJRUM5NTggUGxheWJhY2sgRGVmYXVsdCcNCiAgOyB0eXBlPUlF
Qzk1OCxhY2Nlc3M9cnctLS0tLS0sdmFsdWVzPTENCiAgOiB2YWx1ZXM9W0FFUzA9MHgwNCBBRVMx
PTB4MDAgQUVTMj0weDAwIEFFUzM9MHgwMF0NCm51bWlkPTM0LGlmYWNlPU1JWEVSLG5hbWU9J0lF
Qzk1OCBQbGF5YmFjayBTd2l0Y2gnDQogIDsgdHlwZT1CT09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2
YWx1ZXM9MQ0KICA6IHZhbHVlcz1vZmYNCm51bWlkPTM2LGlmYWNlPU1JWEVSLG5hbWU9J0lFQzk1
OCBDYXB0dXJlIERlZmF1bHQnDQogIDsgdHlwZT1JRUM5NTgsYWNjZXNzPXItLS0tLS0tLHZhbHVl
cz0xDQogIDogdmFsdWVzPVtBRVMwPTB4MDQgQUVTMT0weDAwIEFFUzI9MHgwMCBBRVMzPTB4MDBd
DQpudW1pZD0zNSxpZmFjZT1NSVhFUixuYW1lPSdJRUM5NTggQ2FwdHVyZSBTd2l0Y2gnDQogIDsg
dHlwZT1CT09MRUFOLGFjY2Vzcz1ydy0tLS0tLSx2YWx1ZXM9MQ0KICA6IHZhbHVlcz1vZmYNCm51
bWlkPTMwLGlmYWNlPU1JWEVSLG5hbWU9J0NoYW5uZWwgTW9kZScNCiAgOyB0eXBlPUVOVU1FUkFU
RUQsYWNjZXNzPXJ3LS0tLS0tLHZhbHVlcz0xLGl0ZW1zPTINCiAgOyBJdGVtICMwICc2Y2gnDQog
IDsgSXRlbSAjMSAnOGNoJw0KICA6IHZhbHVlcz0wDQpudW1pZD0yOCxpZmFjZT1NSVhFUixuYW1l
PSdJbnB1dCBTb3VyY2UnDQogIDsgdHlwZT1FTlVNRVJBVEVELGFjY2Vzcz1ydy0tLS0tLSx2YWx1
ZXM9MSxpdGVtcz00DQogIDsgSXRlbSAjMCAnTWljJw0KICA7IEl0ZW0gIzEgJ0Zyb250IE1pYycN
CiAgOyBJdGVtICMyICdMaW5lJw0KICA7IEl0ZW0gIzMgJ0NEJw0KICA6IHZhbHVlcz0wDQpudW1p
ZD0yOSxpZmFjZT1NSVhFUixuYW1lPSdJbnB1dCBTb3VyY2UnLGluZGV4PTENCiAgOyB0eXBlPUVO
VU1FUkFURUQsYWNjZXNzPXJ3LS0tLS0tLHZhbHVlcz0xLGl0ZW1zPTQNCiAgOyBJdGVtICMwICdN
aWMnDQogIDsgSXRlbSAjMSAnRnJvbnQgTWljJw0KICA7IEl0ZW0gIzIgJ0xpbmUnDQogIDsgSXRl
bSAjMyAnQ0QnDQogIDogdmFsdWVzPTANCm51bWlkPTEwLGlmYWNlPU1JWEVSLG5hbWU9J1NpZGUg
UGxheWJhY2sgU3dpdGNoJw0KICA7IHR5cGU9Qk9PTEVBTixhY2Nlc3M9cnctLS0tLS0sdmFsdWVz
PTINCiAgOiB2YWx1ZXM9b2ZmLG9mZg0KbnVtaWQ9OSxpZmFjZT1NSVhFUixuYW1lPSdTaWRlIFBs
YXliYWNrIFZvbHVtZScNCiAgOyB0eXBlPUlOVEVHRVIsYWNjZXNzPXJ3LS0tUi0tLHZhbHVlcz0y
LG1pbj0wLG1heD0zMSxzdGVwPTANCiAgOiB2YWx1ZXM9MzEsMzENCiAgfCBkQnNjYWxlLW1pbj00
Mjk0OTYyNi40NmRCLHN0ZXA9MS41MGRCLG11dGU9MA0K

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="codec.txt"

IyBjYXQgL3Byb2MvYXNvdW5kL2NhcmQwL2NvZGVjIzANCkNvZGVjOiBSZWFsdGVrIEFMQzg4OA0K
QWRkcmVzczogMA0KVmVuZG9yIElkOiAweDEwZWMwODg4DQpTdWJzeXN0ZW0gSWQ6IDB4MTI5NzA4
ODgNClJldmlzaW9uIElkOiAweDEwMDAwMQ0KTm8gTW9kZW0gRnVuY3Rpb24gR3JvdXAgZm91bmQN
CkRlZmF1bHQgUENNOg0KICAgIHJhdGVzIFsweDU2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwIDE5MjAw
MA0KICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0DQogICAgZm9ybWF0cyBbMHgxXTogUENNDQpEZWZh
dWx0IEFtcC1JbiBjYXBzOiBOL0ENCkRlZmF1bHQgQW1wLU91dCBjYXBzOiBOL0ENCk5vZGUgMHgw
MiBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDExOiBTdGVyZW8NCiAgUENNOg0KICAgIHJhdGVzIFsw
eDU2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwIDE5MjAwMA0KICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0
DQogICAgZm9ybWF0cyBbMHgxXTogUENNDQpOb2RlIDB4MDMgW0F1ZGlvIE91dHB1dF0gd2NhcHMg
MHgxMTogU3RlcmVvDQogIFBDTToNCiAgICByYXRlcyBbMHg1NjBdOiA0NDEwMCA0ODAwMCA5NjAw
MCAxOTIwMDANCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNA0KICAgIGZvcm1hdHMgWzB4MV06IFBD
TQ0KTm9kZSAweDA0IFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4MTE6IFN0ZXJlbw0KICBQQ006DQog
ICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAgMTkyMDAwDQogICAgYml0cyBbMHhl
XTogMTYgMjAgMjQNCiAgICBmb3JtYXRzIFsweDFdOiBQQ00NCk5vZGUgMHgwNSBbQXVkaW8gT3V0
cHV0XSB3Y2FwcyAweDExOiBTdGVyZW8NCiAgUENNOg0KICAgIHJhdGVzIFsweDU2MF06IDQ0MTAw
IDQ4MDAwIDk2MDAwIDE5MjAwMA0KICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0DQogICAgZm9ybWF0
cyBbMHgxXTogUENNDQpOb2RlIDB4MDYgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHgyMTE6IFN0ZXJl
byBEaWdpdGFsDQogIFBDTToNCiAgICByYXRlcyBbMHg1ZTBdOiA0NDEwMCA0ODAwMCA4ODIwMCA5
NjAwMCAxOTIwMDANCiAgICBiaXRzIFsweDFlXTogMTYgMjAgMjQgMzINCiAgICBmb3JtYXRzIFsw
eDFdOiBQQ00NCk5vZGUgMHgwNyBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAw
MDogTW9ubw0KTm9kZSAweDA4IFtBdWRpbyBJbnB1dF0gd2NhcHMgMHgxMDAxMWI6IFN0ZXJlbyBB
bXAtSW4NCiAgQW1wLUluIGNhcHM6IG9mcz0weDBiLCBuc3RlcHM9MHgxZiwgc3RlcHNpemU9MHgw
NSwgbXV0ZT0xDQogIEFtcC1JbiB2YWxzOiAgWzB4OWYgMHg5Zl0NCiAgUENNOg0KICAgIHJhdGVz
IFsweDE2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwDQogICAgYml0cyBbMHg2XTogMTYgMjANCiAgICBm
b3JtYXRzIFsweDFdOiBQQ00NCiAgQ29ubmVjdGlvbjogMQ0KICAgICAweDIzDQpOb2RlIDB4MDkg
W0F1ZGlvIElucHV0XSB3Y2FwcyAweDEwMDExYjogU3RlcmVvIEFtcC1Jbg0KICBBbXAtSW4gY2Fw
czogb2ZzPTB4MGIsIG5zdGVwcz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTENCiAgQW1wLUlu
IHZhbHM6ICBbMHg5ZiAweDlmXQ0KICBQQ006DQogICAgcmF0ZXMgWzB4MTYwXTogNDQxMDAgNDgw
MDAgOTYwMDANCiAgICBiaXRzIFsweDZdOiAxNiAyMA0KICAgIGZvcm1hdHMgWzB4MV06IFBDTQ0K
ICBDb25uZWN0aW9uOiAxDQogICAgIDB4MjINCk5vZGUgMHgwYSBbQXVkaW8gSW5wdXRdIHdjYXBz
IDB4MTAwMzkxOiBTdGVyZW8gRGlnaXRhbA0KICBQQ006DQogICAgcmF0ZXMgWzB4NTYwXTogNDQx
MDAgNDgwMDAgOTYwMDAgMTkyMDAwDQogICAgYml0cyBbMHgxZV06IDE2IDIwIDI0IDMyDQogICAg
Zm9ybWF0cyBbMHgxXTogUENNDQogIENvbm5lY3Rpb246IDENCiAgICAgMHgxZg0KTm9kZSAweDBi
IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4NCiAgQW1wLUluIGNh
cHM6IG9mcz0weDE3LCBuc3RlcHM9MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0xDQogIEFtcC1J
biB2YWxzOiAgWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4OWYgMHg5Zl0gWzB4ODAgMHg4MF0g
WzB4OWYgMHg5Zl0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4
MF0gWzB4ODAgMHg4MF0NCiAgQ29ubmVjdGlvbjogMTANCiAgICAgMHgxOCAweDE5IDB4MWEgMHgx
YiAweDFjIDB4MWQgMHgxNCAweDE1IDB4MTYgMHgxNw0KTm9kZSAweDBjIFtBdWRpbyBNaXhlcl0g
d2NhcHMgMHgyMDAxMGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0KICBBbXAtSW4gY2Fwczogb2Zz
PTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTENCiAgQW1wLUluIHZhbHM6
ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQ0KICBBbXAtT3V0IGNhcHM6IG9mcz0weDFmLCBuc3Rl
cHM9MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0wDQogIEFtcC1PdXQgdmFsczogIFsweDFkIDB4
MWRdDQogIENvbm5lY3Rpb246IDINCiAgICAgMHgwMiAweDBiDQpOb2RlIDB4MGQgW0F1ZGlvIE1p
eGVyXSB3Y2FwcyAweDIwMDEwZjogU3RlcmVvIEFtcC1JbiBBbXAtT3V0DQogIEFtcC1JbiBjYXBz
OiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0KICBBbXAtSW4g
dmFsczogIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdDQogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MWYs
IG5zdGVwcz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTANCiAgQW1wLU91dCB2YWxzOiAgWzB4
MWYgMHgxZl0NCiAgQ29ubmVjdGlvbjogMg0KICAgICAweDAzIDB4MGINCk5vZGUgMHgwZSBbQXVk
aW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQNCiAgQW1wLUlu
IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xDQogIEFt
cC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1wLU91dCBjYXBzOiBvZnM9
MHgxZiwgbnN0ZXBzPTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11dGU9MA0KICBBbXAtT3V0IHZhbHM6
ICBbMHgxZiAweDFmXQ0KICBDb25uZWN0aW9uOiAyDQogICAgIDB4MDQgMHgwYg0KTm9kZSAweDBm
IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0KICBB
bXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEN
CiAgQW1wLUluIHZhbHM6ICBbMHg4MCAweDgwXSBbMHg4MCAweDgwXQ0KICBBbXAtT3V0IGNhcHM6
IG9mcz0weDFmLCBuc3RlcHM9MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0wDQogIEFtcC1PdXQg
dmFsczogIFsweDFmIDB4MWZdDQogIENvbm5lY3Rpb246IDINCiAgICAgMHgwNSAweDBiDQpOb2Rl
IDB4MTAgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8NCk5vZGUg
MHgxMSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubw0KTm9kZSAw
eDEyIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vDQpOb2RlIDB4
MTMgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8NCk5vZGUgMHgx
NCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQNCiAg
QW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0w
DQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4
MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4
MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0KICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQ0K
ICBQaW5jYXAgMHgwODNlOiBJTiBPVVQgSFAgRGV0ZWN0DQogIFBpbiBEZWZhdWx0IDB4MDEwMTQw
MTA6IFtKYWNrXSBMaW5lIE91dCBhdCBFeHQgUmVhcg0KICAgIENvbm4gPSAxLzgsIENvbG9yID0g
R3JlZW4NCiAgUGluLWN0bHM6IDB4NDA6IE9VVA0KICBDb25uZWN0aW9uOiA1DQogICAgIDB4MGMq
IDB4MGQgMHgwZSAweDBmIDB4MjYNCk5vZGUgMHgxNSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
MThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQNCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3Rl
cHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wDQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgw
MF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1w
LU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0K
ICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQ0KICBQaW5jYXAgMHgwODNlOiBJTiBPVVQgSFAg
RGV0ZWN0DQogIFBpbiBEZWZhdWx0IDB4MDEwMTEwMTI6IFtKYWNrXSBMaW5lIE91dCBhdCBFeHQg
UmVhcg0KICAgIENvbm4gPSAxLzgsIENvbG9yID0gQmxhY2sNCiAgUGluLWN0bHM6IDB4NDA6IE9V
VA0KICBDb25uZWN0aW9uOiA1DQogICAgIDB4MGMgMHgwZCAweDBlKiAweDBmIDB4MjYNCk5vZGUg
MHgxNiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQN
CiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0
ZT0wDQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0g
WzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBz
PTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0KICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAw
XQ0KICBQaW5jYXAgMHgwODM2OiBJTiBPVVQgRGV0ZWN0DQogIFBpbiBEZWZhdWx0IDB4MDEwMTYw
MTE6IFtKYWNrXSBMaW5lIE91dCBhdCBFeHQgUmVhcg0KICAgIENvbm4gPSAxLzgsIENvbG9yID0g
T3JhbmdlDQogIFBpbi1jdGxzOiAweDQwOiBPVVQNCiAgQ29ubmVjdGlvbjogNQ0KICAgICAweDBj
IDB4MGQqIDB4MGUgMHgwZiAweDI2DQpOb2RlIDB4MTcgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQw
MDE4ZjogU3RlcmVvIEFtcC1JbiBBbXAtT3V0DQogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0
ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MA0KICBBbXAtSW4gdmFsczogIFsweDAwIDB4
MDBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdDQogIEFt
cC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEN
CiAgQW1wLU91dCB2YWxzOiAgWzB4MDAgMHgwMF0NCiAgUGluY2FwIDB4MDgzNjogSU4gT1VUIERl
dGVjdA0KICBQaW4gRGVmYXVsdCAweDAxMDEyMDE0OiBbSmFja10gTGluZSBPdXQgYXQgRXh0IFJl
YXINCiAgICBDb25uID0gMS84LCBDb2xvciA9IEdyZXkNCiAgUGluLWN0bHM6IDB4NDA6IE9VVA0K
ICBDb25uZWN0aW9uOiA1DQogICAgIDB4MGMgMHgwZCAweDBlIDB4MGYqIDB4MjYNCk5vZGUgMHgx
OCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQNCiAg
QW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0w
DQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4
MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4
MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0KICBBbXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQ0K
ICBQaW5jYXAgMHgwODM3M2U6IElOIE9VVCBIUCBEZXRlY3QNCiAgUGluIERlZmF1bHQgMHgwMTgx
MzA0MDogW0phY2tdIExpbmUgSW4gYXQgRXh0IFJlYXINCiAgICBDb25uID0gMS84LCBDb2xvciA9
IEJsdWUNCiAgUGluLWN0bHM6IDB4MjQ6IElODQogIENvbm5lY3Rpb246IDUNCiAgICAgMHgwYyog
MHgwZCAweDBlIDB4MGYgMHgyNg0KTm9kZSAweDE5IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDAx
OGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVw
cz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTANCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAw
XSBbMHgwMCAweDAwXSBbMHgwMCAweDAwXSBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQ0KICBBbXAt
T3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xDQog
IEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdDQogIFBpbmNhcCAweDA4MzczZTogSU4gT1VUIEhQ
IERldGVjdA0KICBQaW4gRGVmYXVsdCAweDAyYTE5ODUwOiBbSmFja10gTWljIGF0IEV4dCBGcm9u
dA0KICAgIENvbm4gPSAxLzgsIENvbG9yID0gUGluaw0KICBQaW4tY3RsczogMHgyNDogSU4NCiAg
Q29ubmVjdGlvbjogNQ0KICAgICAweDBjKiAweDBkIDB4MGUgMHgwZiAweDI2DQpOb2RlIDB4MWEg
W1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDE4ZjogU3RlcmVvIEFtcC1JbiBBbXAtT3V0DQogIEFt
cC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MA0K
ICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdIFsweDAwIDB4MDBdIFsweDAw
IDB4MDBdIFsweDAwIDB4MDBdDQogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAw
LCBzdGVwc2l6ZT0weDAwLCBtdXRlPTENCiAgQW1wLU91dCB2YWxzOiAgWzB4ODAgMHg4MF0NCiAg
UGluY2FwIDB4MDgzNzNlOiBJTiBPVVQgSFAgRGV0ZWN0DQogIFBpbiBEZWZhdWx0IDB4OTk5MzAx
NGY6IFtGaXhlZF0gQXV4IGF0IEludCBBVEFQSQ0KICAgIENvbm4gPSBBVEFQSSwgQ29sb3IgPSBV
bmtub3duDQogIFBpbi1jdGxzOiAweDIwOiBJTg0KICBDb25uZWN0aW9uOiA1DQogICAgIDB4MGMq
IDB4MGQgMHgwZSAweDBmIDB4MjYNCk5vZGUgMHgxYiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
MThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQNCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3Rl
cHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wDQogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgw
MF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0NCiAgQW1w
LU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0K
ICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQ0KICBQaW5jYXAgMHgwODM3M2U6IElOIE9VVCBI
UCBEZXRlY3QNCiAgUGluIERlZmF1bHQgMHgwMjIxNDAyMDogW0phY2tdIEhQIE91dCBhdCBFeHQg
RnJvbnQNCiAgICBDb25uID0gMS84LCBDb2xvciA9IEdyZWVuDQogIFBpbi1jdGxzOiAweGMwOiBP
VVQgSFANCiAgQ29ubmVjdGlvbjogNQ0KICAgICAweDBjKiAweDBkIDB4MGUgMHgwZiAweDI2DQpO
b2RlIDB4MWMgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDAwMTogU3RlcmVvDQogIFBpbmNhcCAw
eDA4MjA6IElODQogIFBpbiBEZWZhdWx0IDB4NDExMTExZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0
IFJlYXINCiAgICBDb25uID0gMS84LCBDb2xvciA9IEJsYWNrDQogIFBpbi1jdGxzOiAweDIwOiBJ
Tg0KTm9kZSAweDFkIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDAwMDA6IE1vbm8NCiAgUGluY2Fw
IDB4MDgyMDogSU4NCiAgUGluIERlZmF1bHQgMHg0MDA1YTYwMzogW04vQV0gTGluZSBPdXQgYXQg
RXh0IE4vQQ0KICAgIENvbm4gPSBPcHRpY2FsLCBDb2xvciA9IFVOS05PV04NCiAgUGluLWN0bHM6
IDB4MjA6IElODQpOb2RlIDB4MWUgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDMwMDogTW9ubyBE
aWdpdGFsDQogIFBpbmNhcCAweDA4MTA6IE9VVA0KICBQaW4gRGVmYXVsdCAweDAxNDUxMTMwOiBb
SmFja10gU1BESUYgT3V0IGF0IEV4dCBSZWFyDQogICAgQ29ubiA9IE9wdGljYWwsIENvbG9yID0g
QmxhY2sNCiAgUGluLWN0bHM6IDB4NDA6IE9VVA0KICBDb25uZWN0aW9uOiAxDQogICAgIDB4MDYN
Ck5vZGUgMHgxZiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMjAwOiBNb25vIERpZ2l0YWwNCiAg
UGluY2FwIDB4MDgyMDogSU4NCiAgUGluIERlZmF1bHQgMHgwMWM1OTE2MDogW0phY2tdIFNQRElG
IEluIGF0IEV4dCBSZWFyDQogICAgQ29ubiA9IE9wdGljYWwsIENvbG9yID0gUGluaw0KICBQaW4t
Y3RsczogMHgyMDogSU4NCk5vZGUgMHgyMCBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAw
eGYwMDA0MDogTW9ubw0KTm9kZSAweDIxIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4
ZjAwMDAwOiBNb25vDQpOb2RlIDB4MjIgW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEwYjogU3Rl
cmVvIEFtcC1Jbg0KICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6
ZT0weDAwLCBtdXRlPTENCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXSBb
MHgwMCAweDAwXSBbMHg4MCAweDgwXSBbMHgwMCAweDAwXSBbMHg4MCAweDgwXSBbMHg4MCAweDgw
XSBbMHg4MCAweDgwXSBbMHg4MCAweDgwXSBbMHg4MCAweDgwXSBbMHg4MCAweDgwXQ0KICBDb25u
ZWN0aW9uOiAxMQ0KICAgICAweDE4IDB4MTkgMHgxYSAweDFiIDB4MWMgMHgxZCAweDE0IDB4MTUg
MHgxNiAweDE3IDB4MGINCk5vZGUgMHgyMyBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBT
dGVyZW8gQW1wLUluDQogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBz
aXplPTB4MDAsIG11dGU9MQ0KICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBdIFsweDAwIDB4MDBd
IFsweDAwIDB4MDBdIFsweDgwIDB4ODBdIFsweDAwIDB4MDBdIFsweDgwIDB4ODBdIFsweDgwIDB4
ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdDQogIENv
bm5lY3Rpb246IDExDQogICAgIDB4MTggMHgxOSAweDFhIDB4MWIgMHgxYyAweDFkIDB4MTQgMHgx
NSAweDE2IDB4MTcgMHgwYg0KTm9kZSAweDI0IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBz
IDB4ZjAwMDAwOiBNb25vDQpOb2RlIDB4MjUgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHgxMTogU3Rl
cmVvDQogIFBDTToNCiAgICByYXRlcyBbMHg1NjBdOiA0NDEwMCA0ODAwMCA5NjAwMCAxOTIwMDAN
CiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNA0KICAgIGZvcm1hdHMgWzB4MV06IFBDTQ0KTm9kZSAw
eDI2IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0K
ICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRl
PTENCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHg4MCAweDgwXQ0KICBBbXAtT3V0IGNh
cHM6IG9mcz0weDFmLCBuc3RlcHM9MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0wDQogIEFtcC1P
dXQgdmFsczogIFsweDAwIDB4MDBdDQogIENvbm5lY3Rpb246IDINCiAgICAgMHgyNSAweDBiDQo=

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.txt"

TGludXggdmVyc2lvbiAyLjYuMjMtZ2VudG9vLXIzIChyb290QHdpemFyZGxpbmcpIChnY2MgdmVy
c2lvbiA0LjEuMiAoR2VudG9vIDQuMS4yIHAxLjAuMikpICMyOCBTTVAgUFJFRU1QVCBXZWQgRGVj
IDI2IDE3OjQyOjAyIENFVCAyMDA3DQpDb21tYW5kIGxpbmU6IHJvb3Q9L2Rldi9zZGEzIHVzYmNv
cmUuYXV0b3N1c3BlbmQ9MSBhY3BpX2lycV9iYWxhbmNlPTAgbm1pX3dhdGNoZG9nPTANCkJJT1Mt
cHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoNCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwMDAwMDAg
LSAwMDAwMDAwMDAwMDlmNDAwICh1c2FibGUpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMDlmNDAw
IC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMGYw
MDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMDAw
MTAwMDAwIC0gMDAwMDAwMDA3ZjU5MDAwMCAodXNhYmxlKQ0KIEJJT1MtZTgyMDogMDAwMDAwMDA3
ZjU5MDAwMCAtIDAwMDAwMDAwN2Y1ZTMwMDAgKEFDUEkgTlZTKQ0KIEJJT1MtZTgyMDogMDAwMDAw
MDA3ZjVlMzAwMCAtIDAwMDAwMDAwN2Y1ZjAwMDAgKEFDUEkgZGF0YSkNCiBCSU9TLWU4MjA6IDAw
MDAwMDAwN2Y1ZjAwMDAgLSAwMDAwMDAwMDdmNjAwMDAwIChyZXNlcnZlZCkNCiBCSU9TLWU4MjA6
IDAwMDAwMDAwZTAwMDAwMDAgLSAwMDAwMDAwMGYwMDAwMDAwIChyZXNlcnZlZCkNCiBCSU9TLWU4
MjA6IDAwMDAwMDAwZmVjMDAwMDAgLSAwMDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkNCkVudGVy
aW5nIGFkZF9hY3RpdmVfcmFuZ2UoMCwgMCwgMTU5KSAwIGVudHJpZXMgb2YgMjU2IHVzZWQNCkVu
dGVyaW5nIGFkZF9hY3RpdmVfcmFuZ2UoMCwgMjU2LCA1MjE2MTYpIDEgZW50cmllcyBvZiAyNTYg
dXNlZA0KZW5kX3Bmbl9tYXAgPSAxMDQ4NTc2DQpETUkgMi41IHByZXNlbnQuDQpBQ1BJOiBSU0RQ
IDAwMEY3OUQwLCAwMDE0IChyMCBTaHV0dGwpDQpBQ1BJOiBSU0RUIDdGNUUzMDAwLCAwMDNDIChy
MSBTaHV0dGwgU2h1dHRsZSAgNDIzMDJFMzEgQVdSRCAgICAgICAgMCkNCkFDUEk6IEZBQ1AgN0Y1
RTMwODAsIDAwNzQgKHIxIFNodXR0bCBTaHV0dGxlICA0MjMwMkUzMSBBV1JEICAgICAgICAwKQ0K
QUNQSTogRFNEVCA3RjVFMzEwMCwgNEM5OSAocjEgU0hVVFRMICBTRzMzVjEwICAgICAxMDAwIE1T
RlQgIDMwMDAwMDApDQpBQ1BJOiBGQUNTIDdGNTkwMDAwLCAwMDQwDQpBQ1BJOiBIUEVUIDdGNUU3
RTgwLCAwMDM4IChyMSBTaHV0dGwgU2h1dHRsZSAgNDIzMDJFMzEgQVdSRCAgICAgICA5OCkNCkFD
UEk6IE1DRkcgN0Y1RTdFQzAsIDAwM0MgKHIxIFNodXR0bCBTaHV0dGxlICA0MjMwMkUzMSBBV1JE
ICAgICAgICAwKQ0KQUNQSTogU0xJQyA3RjVFN0YwMCwgMDE3NiAocjEgU2h1dHRsIFNodXR0bGUg
IDQyMzAyRTMxIEFXUkQgICAgICAgIDApDQpBQ1BJOiBBUElDIDdGNUU3REMwLCAwMDg0IChyMSBT
aHV0dGwgU2h1dHRsZSAgNDIzMDJFMzEgQVdSRCAgICAgICAgMCkNCkFDUEk6IFNTRFQgN0Y1RTg2
RTAsIDAzODAgKHIxICBQbVJlZiAgICBDcHVQbSAgICAgMzAwMCBJTlRMIDIwMDQxMjAzKQ0KRW50
ZXJpbmcgYWRkX2FjdGl2ZV9yYW5nZSgwLCAwLCAxNTkpIDAgZW50cmllcyBvZiAyNTYgdXNlZA0K
RW50ZXJpbmcgYWRkX2FjdGl2ZV9yYW5nZSgwLCAyNTYsIDUyMTYxNikgMSBlbnRyaWVzIG9mIDI1
NiB1c2VkDQpab25lIFBGTiByYW5nZXM6DQogIERNQSAgICAgICAgICAgICAwIC0+ICAgICA0MDk2
DQogIERNQTMyICAgICAgICA0MDk2IC0+ICAxMDQ4NTc2DQogIE5vcm1hbCAgICAxMDQ4NTc2IC0+
ICAxMDQ4NTc2DQpNb3ZhYmxlIHpvbmUgc3RhcnQgUEZOIGZvciBlYWNoIG5vZGUNCmVhcmx5X25v
ZGVfbWFwWzJdIGFjdGl2ZSBQRk4gcmFuZ2VzDQogICAgMDogICAgICAgIDAgLT4gICAgICAxNTkN
CiAgICAwOiAgICAgIDI1NiAtPiAgIDUyMTYxNg0KT24gbm9kZSAwIHRvdGFscGFnZXM6IDUyMTUx
OQ0KICBETUEgem9uZTogNTYgcGFnZXMgdXNlZCBmb3IgbWVtbWFwDQogIERNQSB6b25lOiAxMDIx
IHBhZ2VzIHJlc2VydmVkDQogIERNQSB6b25lOiAyOTIyIHBhZ2VzLCBMSUZPIGJhdGNoOjANCiAg
RE1BMzIgem9uZTogNzA3NSBwYWdlcyB1c2VkIGZvciBtZW1tYXANCiAgRE1BMzIgem9uZTogNTEw
NDQ1IHBhZ2VzLCBMSUZPIGJhdGNoOjMxDQogIE5vcm1hbCB6b25lOiAwIHBhZ2VzIHVzZWQgZm9y
IG1lbW1hcA0KICBNb3ZhYmxlIHpvbmU6IDAgcGFnZXMgdXNlZCBmb3IgbWVtbWFwDQpBQ1BJOiBQ
TS1UaW1lciBJTyBQb3J0OiAweDQwOA0KQUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVlMDAw
MDANCkFDUEk6IExBUElDIChhY3BpX2lkWzB4MDBdIGxhcGljX2lkWzB4MDBdIGVuYWJsZWQpDQpQ
cm9jZXNzb3IgIzAgKEJvb3R1cC1DUFUpDQpBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDAxXSBsYXBp
Y19pZFsweDAxXSBlbmFibGVkKQ0KUHJvY2Vzc29yICMxDQpBQ1BJOiBMQVBJQyAoYWNwaV9pZFsw
eDAyXSBsYXBpY19pZFsweDAyXSBkaXNhYmxlZCkNCkFDUEk6IExBUElDIChhY3BpX2lkWzB4MDNd
IGxhcGljX2lkWzB4MDNdIGRpc2FibGVkKQ0KQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDBd
IGhpZ2ggZWRnZSBsaW50WzB4MV0pDQpBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwMV0gaGln
aCBlZGdlIGxpbnRbMHgxXSkNCkFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAyXSBoaWdoIGVk
Z2UgbGludFsweDFdKQ0KQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDNdIGhpZ2ggZWRnZSBs
aW50WzB4MV0pDQpBQ1BJOiBJT0FQSUMgKGlkWzB4MDRdIGFkZHJlc3NbMHhmZWMwMDAwMF0gZ3Np
X2Jhc2VbMF0pDQpJT0FQSUNbMF06IGFwaWNfaWQgNCwgYWRkcmVzcyAweGZlYzAwMDAwLCBHU0kg
MC0yMw0KQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgMCBnbG9iYWxfaXJxIDIgZGZs
IGRmbCkNCkFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5IGhp
Z2ggbGV2ZWwpDQpBQ1BJOiBJUlEwIHVzZWQgYnkgb3ZlcnJpZGUuDQpBQ1BJOiBJUlEyIHVzZWQg
Ynkgb3ZlcnJpZGUuDQpBQ1BJOiBJUlE5IHVzZWQgYnkgb3ZlcnJpZGUuDQpTZXR0aW5nIEFQSUMg
cm91dGluZyB0byBmbGF0DQpBQ1BJOiBIUEVUIGlkOiAweDgwODZhMjAxIGJhc2U6IDB4ZmVkMDAw
MDANClVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbg0K
QWxsb2NhdGluZyBQQ0kgcmVzb3VyY2VzIHN0YXJ0aW5nIGF0IDgwMDAwMDAwIChnYXA6IDdmNjAw
MDAwOjYwYTAwMDAwKQ0KU01QOiBBbGxvd2luZyAyIENQVXMsIDAgaG90cGx1ZyBDUFVzDQpQRVJD
UFU6IEFsbG9jYXRpbmcgMjk2NzIgYnl0ZXMgb2YgcGVyIGNwdSBkYXRhDQpCdWlsdCAxIHpvbmVs
aXN0cyBpbiBab25lIG9yZGVyLiAgVG90YWwgcGFnZXM6IDUxMzM2Nw0KS2VybmVsIGNvbW1hbmQg
bGluZTogcm9vdD0vZGV2L3NkYTMgdXNiY29yZS5hdXRvc3VzcGVuZD0xIGFjcGlfaXJxX2JhbGFu
Y2U9MCBubWlfd2F0Y2hkb2c9MA0KSW5pdGlhbGl6aW5nIENQVSMwDQpQSUQgaGFzaCB0YWJsZSBl
bnRyaWVzOiA0MDk2IChvcmRlcjogMTIsIDMyNzY4IGJ5dGVzKQ0KdGltZS5jOiBEZXRlY3RlZCAy
NDAyLjE1MCBNSHogcHJvY2Vzc29yLg0KQ29uc29sZTogY29sb3VyIFZHQSsgODB4MjUNCmNvbnNv
bGUgW3R0eTBdIGVuYWJsZWQNCkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0
NCAob3JkZXI6IDksIDIwOTcxNTIgYnl0ZXMpDQpJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDEzMTA3MiAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMpDQpDaGVja2luZyBhcGVydHVyZS4u
Lg0KTWVtb3J5OiAyMDQ5OTI0ay8yMDg2NDY0ayBhdmFpbGFibGUgKDI0NDRrIGtlcm5lbCBjb2Rl
LCAzNTg3NmsgcmVzZXJ2ZWQsIDEwNTdrIGRhdGEsIDE4OGsgaW5pdCkNClNMVUI6IEdlbnNsYWJz
PTIyLCBIV2FsaWduPTY0LCBPcmRlcj0wLTEsIE1pbk9iamVjdHM9NCwgQ1BVcz0yLCBOb2Rlcz0x
DQpDYWxpYnJhdGluZyBkZWxheSB1c2luZyB0aW1lciBzcGVjaWZpYyByb3V0aW5lLi4gNDgwNy4y
NiBCb2dvTUlQUyAobHBqPTI0MDM2MzEpDQpNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6
IDI1Ng0KQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwxIEQgY2FjaGU6IDMySw0KQ1BVOiBMMiBjYWNo
ZTogNDA5NksNCnVzaW5nIG13YWl0IGluIGlkbGUgdGhyZWFkcy4NCkNQVTogUGh5c2ljYWwgUHJv
Y2Vzc29yIElEOiAwDQpDUFU6IFByb2Nlc3NvciBDb3JlIElEOiAwDQpDUFUwOiBUaGVybWFsIG1v
bml0b3JpbmcgZW5hYmxlZCAoVE0yKQ0KU01QIGFsdGVybmF0aXZlczogc3dpdGNoaW5nIHRvIFVQ
IGNvZGUNCkFDUEk6IENvcmUgcmV2aXNpb24gMjAwNzAxMjYNClVzaW5nIGxvY2FsIEFQSUMgdGlt
ZXIgaW50ZXJydXB0cy4NCnJlc3VsdCAxNjY4MTU3OQ0KRGV0ZWN0ZWQgMTYuNjgxIE1IeiBBUElD
IHRpbWVyLg0KU01QIGFsdGVybmF0aXZlczogc3dpdGNoaW5nIHRvIFNNUCBjb2RlDQpCb290aW5n
IHByb2Nlc3NvciAxLzIgQVBJQyAweDENCkluaXRpYWxpemluZyBDUFUjMQ0KQ2FsaWJyYXRpbmcg
ZGVsYXkgdXNpbmcgdGltZXIgc3BlY2lmaWMgcm91dGluZS4uIDQ4MDQuNDkgQm9nb01JUFMgKGxw
aj0yNDAyMjQ2KQ0KQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwxIEQgY2FjaGU6IDMySw0KQ1BVOiBM
MiBjYWNoZTogNDA5NksNCkNQVTogUGh5c2ljYWwgUHJvY2Vzc29yIElEOiAwDQpDUFU6IFByb2Nl
c3NvciBDb3JlIElEOiAxDQpDUFUxOiBUaGVybWFsIG1vbml0b3JpbmcgZW5hYmxlZCAoVE0yKQ0K
SW50ZWwoUikgQ29yZShUTSkyIENQVSAgICAgICAgICA2NjAwICBAIDIuNDBHSHogc3RlcHBpbmcg
MDYNCmNoZWNraW5nIFRTQyBzeW5jaHJvbml6YXRpb24gW0NQVSMwIC0+IENQVSMxXTogcGFzc2Vk
Lg0KQnJvdWdodCB1cCAyIENQVXMNCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYN
CkFDUEk6IGJ1cyB0eXBlIHBjaSByZWdpc3RlcmVkDQpQQ0k6IFVzaW5nIE1NQ09ORklHIGF0IGUw
MDAwMDAwIC0gZWZmZmZmZmYNCkFDUEk6IEVDOiBMb29rIHVwIEVDIGluIERTRFQNCkFDUEk6IElu
dGVycHJldGVyIGVuYWJsZWQNCkFDUEk6IChzdXBwb3J0cyBTMCBTMyBTNSkNCkFDUEk6IFVzaW5n
IElPQVBJQyBmb3IgaW50ZXJydXB0IHJvdXRpbmcNCkFDUEk6IFBDSSBSb290IEJyaWRnZSBbUENJ
MF0gKDAwMDA6MDApDQpQQ0k6IFRyYW5zcGFyZW50IGJyaWRnZSAtIDAwMDA6MDA6MWUuMA0KQUNQ
STogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLl9QUlRdDQpBQ1BJOiBQ
Q0kgSW50ZXJydXB0IFJvdXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuUEVYMC5fUFJUXQ0KQUNQSTog
UENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLlBFWDEuX1BSVF0NCkFDUEk6
IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5IVUIwLl9QUlRdDQpBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0FdIChJUlFzIDMgNCA1IDcgOSAqMTAgMTEgMTIgMTQg
MTUpDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0JdIChJUlFzIDMgNCAqNSA3IDkgMTAg
MTEgMTIgMTQgMTUpDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0NdIChJUlFzIDMgKjQg
NSA3IDkgMTAgMTEgMTIgMTQgMTUpDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0RdIChJ
UlFzIDMgNCA1IDcgOSAxMCAqMTEgMTIgMTQgMTUpDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0xOS0VdIChJUlFzIDMgNCA1IDcgOSAxMCAxMSAxMiAxNCAxNSkgKjAsIGRpc2FibGVkLg0KQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtMTktGXSAoSVJRcyAzIDQgNSA3IDkgMTAgKjExIDEyIDE0
IDE1KQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTkswXSAoSVJRcyAqMyA0IDUgNyA5IDEw
IDExIDEyIDE0IDE1KQ0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTksxXSAoSVJRcyAzIDQg
NSA3ICo5IDEwIDExIDEyIDE0IDE1KQ0KTGludXggUGx1ZyBhbmQgUGxheSBTdXBwb3J0IHYwLjk3
IChjKSBBZGFtIEJlbGF5DQpwbnA6IFBuUCBBQ1BJIGluaXQNCkFDUEk6IGJ1cyB0eXBlIHBucCBy
ZWdpc3RlcmVkDQpwbnA6IFBuUCBBQ1BJOiBmb3VuZCAxMyBkZXZpY2VzDQpBQ1BJOiBBQ1BJIGJ1
cyB0eXBlIHBucCB1bnJlZ2lzdGVyZWQNClNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkDQpsaWJh
dGEgdmVyc2lvbiAyLjIxIGxvYWRlZC4NCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgdXNiZnMNCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
aHViDQp1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBkZXZpY2UgZHJpdmVyIHVzYg0KUENJOiBVc2lu
ZyBBQ1BJIGZvciBJUlEgcm91dGluZw0KUENJOiBJZiBhIGRldmljZSBkb2Vzbid0IHdvcmssIHRy
eSAicGNpPXJvdXRlaXJxIi4gIElmIGl0IGhlbHBzLCBwb3N0IGEgcmVwb3J0DQpQQ0ktR0FSVDog
Tm8gQU1EIG5vcnRoYnJpZGdlIGZvdW5kLg0KVGltZTogdHNjIGNsb2Nrc291cmNlIGhhcyBiZWVu
IGluc3RhbGxlZC4NCnBucDogMDA6MDk6IGlvcG9ydCByYW5nZSAweDQwMC0weDRiZiBoYXMgYmVl
biByZXNlcnZlZA0KcG5wOiAwMDowYjogaW9tZW0gcmFuZ2UgMHhlMDAwMDAwMC0weGVmZmZmZmZm
IGNvdWxkIG5vdCBiZSByZXNlcnZlZA0KcG5wOiAwMDowYzogaW9tZW0gcmFuZ2UgMHhmMDAwMC0w
eGZmZmZmIGNvdWxkIG5vdCBiZSByZXNlcnZlZA0KcG5wOiAwMDowYzogaW9tZW0gcmFuZ2UgMHg3
ZjYwMDAwMC0weDdmNmZmZmZmIGhhcyBiZWVuIHJlc2VydmVkDQpwbnA6IDAwOjBjOiBpb21lbSBy
YW5nZSAweGZlZDAwMDAwLTB4ZmVkMDAwZmYgaGFzIGJlZW4gcmVzZXJ2ZWQNCnBucDogMDA6MGM6
IGlvbWVtIHJhbmdlIDB4N2Y1OTAwMDAtMHg3ZjVmZmZmZiBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQN
ClBDSTogQnJpZGdlOiAwMDAwOjAwOjFjLjANCiAgSU8gd2luZG93OiBkMDAwLWRmZmYNCiAgTUVN
IHdpbmRvdzogZmQ4MDAwMDAtZmQ4ZmZmZmYNCiAgUFJFRkVUQ0ggd2luZG93OiBmZDcwMDAwMC1m
ZDdmZmZmZg0KUENJOiBCcmlkZ2U6IDAwMDA6MDA6MWMuMQ0KICBJTyB3aW5kb3c6IGUwMDAtZWZm
Zg0KICBNRU0gd2luZG93OiBmZGQwMDAwMC1mZGRmZmZmZg0KICBQUkVGRVRDSCB3aW5kb3c6IGZk
YzAwMDAwLWZkY2ZmZmZmDQpQQ0k6IEJyaWRnZTogMDAwMDowMDoxZS4wDQogIElPIHdpbmRvdzog
YzAwMC1jZmZmDQogIE1FTSB3aW5kb3c6IGZkYTAwMDAwLWZkYWZmZmZmDQogIFBSRUZFVENIIHdp
bmRvdzogZmQ5MDAwMDAtZmQ5ZmZmZmYNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYy4w
W0FdIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2DQpQQ0k6IFNldHRpbmcgbGF0ZW5j
eSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxYy4wIHRvIDY0DQpBQ1BJOiBQQ0kgSW50ZXJydXB0
IDAwMDA6MDA6MWMuMVtCXSAtPiBHU0kgMTcgKGxldmVsLCBsb3cpIC0+IElSUSAxNw0KUENJOiBT
ZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWMuMSB0byA2NA0KUENJOiBT
ZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWUuMCB0byA2NA0KTkVUOiBS
ZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyDQpJUCByb3V0ZSBjYWNoZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQ0KVENQIGVzdGFibGlzaGVkIGhh
c2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOSwgMzE0NTcyOCBieXRlcykNClRDUCBi
aW5kIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVzKQ0K
VENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAxMzEwNzIgYmluZCA2NTUz
NikNClRDUCByZW5vIHJlZ2lzdGVyZWQNCklBLTMyIE1pY3JvY29kZSBVcGRhdGUgRHJpdmVyOiB2
MS4xNGEgPHRpZ3JhbkBhaXZhemlhbi5mc25ldC5jby51az4NCkluc3RhbGxpbmcga25mc2QgKGNv
cHlyaWdodCAoQykgMTk5NiBva2lyQG1vbmFkLnN3Yi5kZSkuDQpOVEZTIGRyaXZlciAyLjEuMjgg
W0ZsYWdzOiBSL09dLg0KZnVzZSBpbml0IChBUEkgdmVyc2lvbiA3LjgpDQpCbG9jayBsYXllciBT
Q1NJIGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjUzKQ0K
aW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZA0KaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVk
IChkZWZhdWx0KQ0KQm9vdCB2aWRlbyBkZXZpY2UgaXMgMDAwMDowMDowMi4wDQpQQ0k6IFNldHRp
bmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxYy4wIHRvIDY0DQphc3NpZ25faW50
ZXJydXB0X21vZGUgRm91bmQgTVNJIGNhcGFiaWxpdHkNCkFsbG9jYXRlIFBvcnQgU2VydmljZVsw
MDAwOjAwOjFjLjA6cGNpZTAwXQ0KQWxsb2NhdGUgUG9ydCBTZXJ2aWNlWzAwMDA6MDA6MWMuMDpw
Y2llMDJdDQpBbGxvY2F0ZSBQb3J0IFNlcnZpY2VbMDAwMDowMDoxYy4wOnBjaWUwM10NClBDSTog
U2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAwOjFjLjEgdG8gNjQNCmFzc2ln
bl9pbnRlcnJ1cHRfbW9kZSBGb3VuZCBNU0kgY2FwYWJpbGl0eQ0KQWxsb2NhdGUgUG9ydCBTZXJ2
aWNlWzAwMDA6MDA6MWMuMTpwY2llMDBdDQpBbGxvY2F0ZSBQb3J0IFNlcnZpY2VbMDAwMDowMDox
Yy4xOnBjaWUwMl0NCkFsbG9jYXRlIFBvcnQgU2VydmljZVswMDAwOjAwOjFjLjE6cGNpZTAzXQ0K
UmVhbCBUaW1lIENsb2NrIERyaXZlciB2MS4xMmFjDQpMaW51eCBhZ3BnYXJ0IGludGVyZmFjZSB2
MC4xMDINCmFncGdhcnQ6IERldGVjdGVkIGFuIEludGVsIEczMyBDaGlwc2V0Lg0KYWdwZ2FydDog
RGV0ZWN0ZWQgNzE2NEsgc3RvbGVuIG1lbW9yeS4NCmFncGdhcnQ6IEFHUCBhcGVydHVyZSBpcyAy
NTZNIEAgMHhkMDAwMDAwMA0KW2RybV0gSW5pdGlhbGl6ZWQgZHJtIDEuMS4wIDIwMDYwODEwDQpB
Q1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MDIuMFtBXSAtPiBHU0kgMTYgKGxldmVsLCBsb3cp
IC0+IElSUSAxNg0KW2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDA2MDExOSBvbiBtaW5v
ciAwDQppbnB1dDogUG93ZXIgQnV0dG9uIChGRikgYXMgL2RldmljZXMvdmlydHVhbC9pbnB1dC9p
bnB1dDANCkFDUEk6IFBvd2VyIEJ1dHRvbiAoRkYpIFtQV1JGXQ0KaW5wdXQ6IFBvd2VyIEJ1dHRv
biAoQ00pIGFzIC9kZXZpY2VzL3ZpcnR1YWwvaW5wdXQvaW5wdXQxDQpBQ1BJOiBQb3dlciBCdXR0
b24gKENNKSBbUFdSQl0NCkFDUEk6IFNTRFQgN0Y1RTgwQzAsIDAyMkEgKHIxICBQbVJlZiAgQ3B1
MElzdCAgICAgMzAwMCBJTlRMIDIwMDQxMjAzKQ0KQUNQSTogU1NEVCA3RjVFODU4MCwgMDE1MiAo
cjEgIFBtUmVmICBDcHUxSXN0ICAgICAzMDAwIElOVEwgMjAwNDEyMDMpDQpBQ1BJIEV4Y2VwdGlv
biAocHJvY2Vzc29yX2NvcmUtMDgxOCk6IEFFX05PVF9GT1VORCwgUHJvY2Vzc29yIERldmljZSBp
cyBub3QgcHJlc2VudCBbMjAwNzAxMjZdDQpBQ1BJIEV4Y2VwdGlvbiAocHJvY2Vzc29yX2NvcmUt
MDgxOCk6IEFFX05PVF9GT1VORCwgUHJvY2Vzc29yIERldmljZSBpcyBub3QgcHJlc2VudCBbMjAw
NzAxMjZdDQpBQ1BJOiBUaGVybWFsIFpvbmUgW1RIUk1dICg0MCBDKQ0KUkFNRElTSyBkcml2ZXIg
aW5pdGlhbGl6ZWQ6IDE2IFJBTSBkaXNrcyBvZiA0MDk2SyBzaXplIDEwMjQgYmxvY2tzaXplDQps
b29wOiBtb2R1bGUgbG9hZGVkDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDI6MDAuMFtBXSAt
PiBHU0kgMTcgKGxldmVsLCBsb3cpIC0+IElSUSAxNw0KUENJOiBTZXR0aW5nIGxhdGVuY3kgdGlt
ZXIgb2YgZGV2aWNlIDAwMDA6MDI6MDAuMCB0byA2NA0Kc2t5MiAwMDAwOjAyOjAwLjA6IHYxLjE4
IGFkZHIgMHhmZGRmYzAwMCBpcnEgMTcgWXVrb24tRUMgVWx0cmEgKDB4YjQpIHJldiAzDQpza3ky
IGV0aDA6IGFkZHIgMDA6MzA6MWI6YmM6NjM6YmQNCmF0YV9waWl4IDAwMDA6MDA6MWYuMjogdmVy
c2lvbiAyLjEyDQphdGFfcGlpeCAwMDAwOjAwOjFmLjI6IE1BUCBbIFAwIFAyIFAxIFAzIF0NCkFD
UEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxZi4yW0FdIC0+IEdTSSAxOSAobGV2ZWwsIGxvdykg
LT4gSVJRIDE5DQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDox
Zi4yIHRvIDY0DQpzY3NpMCA6IGF0YV9waWl4DQpzY3NpMSA6IGF0YV9waWl4DQphdGExOiBTQVRB
IG1heCBVRE1BLzEzMyBjbWQgMHgwMDAwMDAwMDAwMDEwMWYwIGN0bCAweDAwMDAwMDAwMDAwMTAz
ZjYgYm1kbWEgMHgwMDAwMDAwMDAwMDFmODAwIGlycSAxNA0KYXRhMjogU0FUQSBtYXggVURNQS8x
MzMgY21kIDB4MDAwMDAwMDAwMDAxMDE3MCBjdGwgMHgwMDAwMDAwMDAwMDEwMzc2IGJtZG1hIDB4
MDAwMDAwMDAwMDAxZjgwOCBpcnEgMTUNCmF0YTEuMDA6IEFUQS04OiBTQU1TVU5HIEhENTAxTEos
IENSMTAwLTEyLCBtYXggVURNQTcNCmF0YTEuMDA6IDk3Njc3MzE2OCBzZWN0b3JzLCBtdWx0aSAx
OiBMQkE0OCBOQ1EgKGRlcHRoIDAvMzIpDQphdGExLjAxOiBBVEFQSTogUExFWFRPUiBEVkRSICAg
UFgtODEwU0EsIDEuMDAsIG1heCBVRE1BLzY2DQphdGExLjAwOiBjb25maWd1cmVkIGZvciBVRE1B
LzEzMw0KYXRhMS4wMTogY29uZmlndXJlZCBmb3IgVURNQS82Ng0Kc2NzaSAwOjA6MDowOiBEaXJl
Y3QtQWNjZXNzICAgICBBVEEgICAgICBTQU1TVU5HIEhENTAxTEogIENSMTAgUFE6IDAgQU5TSTog
NQ0Kc2QgMDowOjA6MDogW3NkYV0gOTc2NzczMTY4IDUxMi1ieXRlIGhhcmR3YXJlIHNlY3RvcnMg
KDUwMDEwOCBNQikNCnNkIDA6MDowOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmDQpzZCAw
OjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMA0Kc2QgMDowOjA6MDogW3NkYV0g
V3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9y
dCBEUE8gb3IgRlVBDQpzZCAwOjA6MDowOiBbc2RhXSA5NzY3NzMxNjggNTEyLWJ5dGUgaGFyZHdh
cmUgc2VjdG9ycyAoNTAwMTA4IE1CKQ0Kc2QgMDowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBp
cyBvZmYNCnNkIDA6MDowOjA6IFtzZGFdIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwDQpzZCAwOjA6
MDowOiBbc2RhXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9l
c24ndCBzdXBwb3J0IERQTyBvciBGVUENCiBzZGE6IHNkYTEgc2RhMiBzZGEzDQpzZCAwOjA6MDow
OiBbc2RhXSBBdHRhY2hlZCBTQ1NJIGRpc2sNCnNkIDA6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2Vu
ZXJpYyBzZzAgdHlwZSAwDQpzY3NpIDA6MDoxOjA6IENELVJPTSAgICAgICAgICAgIFBMRVhUT1Ig
IERWRFIgICBQWC04MTBTQSAgMS4wMCBQUTogMCBBTlNJOiA1DQpzcjA6IHNjc2kzLW1tYyBkcml2
ZTogNDB4LzQweCB3cml0ZXIgZHZkLXJhbSBjZC9ydyB4YS9mb3JtMiBjZGRhIHRyYXkNClVuaWZv
cm0gQ0QtUk9NIGRyaXZlciBSZXZpc2lvbjogMy4yMA0Kc3IgMDowOjE6MDogQXR0YWNoZWQgc2Nz
aSBDRC1ST00gc3IwDQpzciAwOjA6MTowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUg
NQ0KYXRhX3BpaXggMDAwMDowMDoxZi41OiBNQVAgWyBQMCBQMiBQMSBQMyBdDQpBQ1BJOiBQQ0kg
SW50ZXJydXB0IDAwMDA6MDA6MWYuNVtBXSAtPiBHU0kgMTkgKGxldmVsLCBsb3cpIC0+IElSUSAx
OQ0KUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWYuNSB0byA2
NA0Kc2NzaTIgOiBhdGFfcGlpeA0Kc2NzaTMgOiBhdGFfcGlpeA0KYXRhMzogU0FUQSBtYXggVURN
QS8xMzMgY21kIDB4MDAwMDAwMDAwMDAxZjUwMCBjdGwgMHgwMDAwMDAwMDAwMDFmNDAyIGJtZG1h
IDB4MDAwMDAwMDAwMDAxZjEwMCBpcnEgMTkNCmF0YTQ6IFNBVEEgbWF4IFVETUEvMTMzIGNtZCAw
eDAwMDAwMDAwMDAwMWYzMDAgY3RsIDB4MDAwMDAwMDAwMDAxZjIwMiBibWRtYSAweDAwMDAwMDAw
MDAwMWYxMDggaXJxIDE5DQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDE6MDAuMFtBXSAtPiBH
U0kgMTYgKGxldmVsLCBsb3cpIC0+IElSUSAxNg0KUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIg
b2YgZGV2aWNlIDAwMDA6MDE6MDAuMCB0byA2NA0Kc2NzaTQgOiBwYXRhX2ptaWNyb24NCnNjc2k1
IDogcGF0YV9qbWljcm9uDQphdGE1OiBQQVRBIG1heCBVRE1BLzEwMCBjbWQgMHgwMDAwMDAwMDAw
MDFkZjAwIGN0bCAweDAwMDAwMDAwMDAwMWRlMDIgYm1kbWEgMHgwMDAwMDAwMDAwMDFkYjAwIGly
cSAxNg0KYXRhNjogUEFUQSBtYXggVURNQS8xMDAgY21kIDB4MDAwMDAwMDAwMDAxZGQwMCBjdGwg
MHgwMDAwMDAwMDAwMDFkYzAyIGJtZG1hIDB4MDAwMDAwMDAwMDAxZGIwOCBpcnEgMTYNCkFDUEk6
IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYS43W0NdIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykgLT4g
SVJRIDE4DQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxYS43
IHRvIDY0DQplaGNpX2hjZCAwMDAwOjAwOjFhLjc6IEVIQ0kgSG9zdCBDb250cm9sbGVyDQplaGNp
X2hjZCAwMDAwOjAwOjFhLjc6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBu
dW1iZXIgMQ0KZWhjaV9oY2QgMDAwMDowMDoxYS43OiBkZWJ1ZyBwb3J0IDENClBDSTogY2FjaGUg
bGluZSBzaXplIG9mIDMyIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZGV2aWNlIDAwMDA6MDA6MWEuNw0K
ZWhjaV9oY2QgMDAwMDowMDoxYS43OiBpcnEgMTgsIGlvIG1lbSAweGZkZmZmMDAwDQplaGNpX2hj
ZCAwMDAwOjAwOjFhLjc6IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwLCBkcml2ZXIgMTAgRGVj
IDIwMDQNCnVzYiB1c2IxOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlDQpo
dWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZA0KaHViIDEtMDoxLjA6IDYgcG9ydHMgZGV0ZWN0ZWQN
CkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxZC43W0FdIC0+IEdTSSAyMyAobGV2ZWwsIGxv
dykgLT4gSVJRIDIzDQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDow
MDoxZC43IHRvIDY0DQplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IEVIQ0kgSG9zdCBDb250cm9sbGVy
DQplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVk
IGJ1cyBudW1iZXIgMg0KZWhjaV9oY2QgMDAwMDowMDoxZC43OiBkZWJ1ZyBwb3J0IDENClBDSTog
Y2FjaGUgbGluZSBzaXplIG9mIDMyIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZGV2aWNlIDAwMDA6MDA6
MWQuNw0KZWhjaV9oY2QgMDAwMDowMDoxZC43OiBpcnEgMjMsIGlvIG1lbSAweGZkZmZlMDAwDQpl
aGNpX2hjZCAwMDAwOjAwOjFkLjc6IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwLCBkcml2ZXIg
MTAgRGVjIDIwMDQNCnVzYiB1c2IyOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hv
aWNlDQpodWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZA0KaHViIDItMDoxLjA6IDYgcG9ydHMgZGV0
ZWN0ZWQNClVTQiBVbml2ZXJzYWwgSG9zdCBDb250cm9sbGVyIEludGVyZmFjZSBkcml2ZXIgdjMu
MA0KQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjFhLjBbQV0gLT4gR1NJIDE2IChsZXZlbCwg
bG93KSAtPiBJUlEgMTYNClBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAw
OjAwOjFhLjAgdG8gNjQNCnVoY2lfaGNkIDAwMDA6MDA6MWEuMDogVUhDSSBIb3N0IENvbnRyb2xs
ZXINCnVoY2lfaGNkIDAwMDA6MDA6MWEuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWdu
ZWQgYnVzIG51bWJlciAzDQp1aGNpX2hjZCAwMDAwOjAwOjFhLjA6IGlycSAxNiwgaW8gYmFzZSAw
eDAwMDBmZTAwDQp1c2IgdXNiMzogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2lj
ZQ0KaHViIDMtMDoxLjA6IFVTQiBodWIgZm91bmQNCmh1YiAzLTA6MS4wOiAyIHBvcnRzIGRldGVj
dGVkDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWEuMVtCXSAtPiBHU0kgMjEgKGxldmVs
LCBsb3cpIC0+IElSUSAyMQ0KUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAw
MDA6MDA6MWEuMSB0byA2NA0KdWhjaV9oY2QgMDAwMDowMDoxYS4xOiBVSENJIEhvc3QgQ29udHJv
bGxlcg0KdWhjaV9oY2QgMDAwMDowMDoxYS4xOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3Np
Z25lZCBidXMgbnVtYmVyIDQNCnVoY2lfaGNkIDAwMDA6MDA6MWEuMTogaXJxIDIxLCBpbyBiYXNl
IDB4MDAwMGZkMDANCnVzYiB1c2I0OiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hv
aWNlDQpodWIgNC0wOjEuMDogVVNCIGh1YiBmb3VuZA0KaHViIDQtMDoxLjA6IDIgcG9ydHMgZGV0
ZWN0ZWQNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYS4yW0RdIC0+IEdTSSAxOSAobGV2
ZWwsIGxvdykgLT4gSVJRIDE5DQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2Ug
MDAwMDowMDoxYS4yIHRvIDY0DQp1aGNpX2hjZCAwMDAwOjAwOjFhLjI6IFVIQ0kgSG9zdCBDb250
cm9sbGVyDQp1aGNpX2hjZCAwMDAwOjAwOjFhLjI6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFz
c2lnbmVkIGJ1cyBudW1iZXIgNQ0KdWhjaV9oY2QgMDAwMDowMDoxYS4yOiBpcnEgMTksIGlvIGJh
c2UgMHgwMDAwZmMwMA0KdXNiIHVzYjU6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBj
aG9pY2UNCmh1YiA1LTA6MS4wOiBVU0IgaHViIGZvdW5kDQpodWIgNS0wOjEuMDogMiBwb3J0cyBk
ZXRlY3RlZA0KQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjFkLjBbQV0gLT4gR1NJIDIzIChs
ZXZlbCwgbG93KSAtPiBJUlEgMjMNClBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmlj
ZSAwMDAwOjAwOjFkLjAgdG8gNjQNCnVoY2lfaGNkIDAwMDA6MDA6MWQuMDogVUhDSSBIb3N0IENv
bnRyb2xsZXINCnVoY2lfaGNkIDAwMDA6MDA6MWQuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwg
YXNzaWduZWQgYnVzIG51bWJlciA2DQp1aGNpX2hjZCAwMDAwOjAwOjFkLjA6IGlycSAyMywgaW8g
YmFzZSAweDAwMDBmYjAwDQp1c2IgdXNiNjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAx
IGNob2ljZQ0KaHViIDYtMDoxLjA6IFVTQiBodWIgZm91bmQNCmh1YiA2LTA6MS4wOiAyIHBvcnRz
IGRldGVjdGVkDQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWQuMVtCXSAtPiBHU0kgMTkg
KGxldmVsLCBsb3cpIC0+IElSUSAxOQ0KUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2
aWNlIDAwMDA6MDA6MWQuMSB0byA2NA0KdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBVSENJIEhvc3Qg
Q29udHJvbGxlcg0KdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVk
LCBhc3NpZ25lZCBidXMgbnVtYmVyIDcNCnVoY2lfaGNkIDAwMDA6MDA6MWQuMTogaXJxIDE5LCBp
byBiYXNlIDB4MDAwMGZhMDANCnVzYiB1c2I3OiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9t
IDEgY2hvaWNlDQpodWIgNy0wOjEuMDogVVNCIGh1YiBmb3VuZA0KaHViIDctMDoxLjA6IDIgcG9y
dHMgZGV0ZWN0ZWQNCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxZC4yW0NdIC0+IEdTSSAx
OCAobGV2ZWwsIGxvdykgLT4gSVJRIDE4DQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBk
ZXZpY2UgMDAwMDowMDoxZC4yIHRvIDY0DQp1aGNpX2hjZCAwMDAwOjAwOjFkLjI6IFVIQ0kgSG9z
dCBDb250cm9sbGVyDQp1aGNpX2hjZCAwMDAwOjAwOjFkLjI6IG5ldyBVU0IgYnVzIHJlZ2lzdGVy
ZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgOA0KdWhjaV9oY2QgMDAwMDowMDoxZC4yOiBpcnEgMTgs
IGlvIGJhc2UgMHgwMDAwZjkwMA0KdXNiIHVzYjg6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZy
b20gMSBjaG9pY2UNCmh1YiA4LTA6MS4wOiBVU0IgaHViIGZvdW5kDQpodWIgOC0wOjEuMDogMiBw
b3J0cyBkZXRlY3RlZA0KdXNiIDQtMTogbmV3IGZ1bGwgc3BlZWQgVVNCIGRldmljZSB1c2luZyB1
aGNpX2hjZCBhbmQgYWRkcmVzcyAyDQp1c2IgNC0xOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBm
cm9tIDEgY2hvaWNlDQp1c2IgNS0yOiBuZXcgbG93IHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgdWhj
aV9oY2QgYW5kIGFkZHJlc3MgMg0KdXNiIDUtMjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJv
bSAxIGNob2ljZQ0KdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Js
cA0KSW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uDQp1c2IgNi0xOiBuZXcg
bG93IHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgdWhjaV9oY2QgYW5kIGFkZHJlc3MgMg0KdXNiIDYt
MTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQ0KdXNiY29yZTogcmVnaXN0
ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Itc3RvcmFnZQ0KVVNCIE1hc3MgU3RvcmFnZSBz
dXBwb3J0IHJlZ2lzdGVyZWQuDQpQTlA6IE5vIFBTLzIgY29udHJvbGxlciBmb3VuZC4gUHJvYmlu
ZyBwb3J0cyBkaXJlY3RseS4NCnNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJx
IDENCnNlcmlvOiBpODA0MiBBVVggcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyDQptaWNlOiBQUy8y
IG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlDQppMmMgL2RldiBlbnRyaWVzIGRyaXZl
cg0KQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjFmLjNbQl0gLT4gR1NJIDE4IChsZXZlbCwg
bG93KSAtPiBJUlEgMTgNCmNvcmV0ZW1wIGNvcmV0ZW1wLjA6IFVzaW5nIHVuZG9jdW1lbnRlZCBm
ZWF0dXJlcywgYWJzb2x1dGUgdGVtcGVyYXR1cmUgbWlnaHQgYmUgd3JvbmchDQpjb3JldGVtcCBj
b3JldGVtcC4xOiBVc2luZyB1bmRvY3VtZW50ZWQgZmVhdHVyZXMsIGFic29sdXRlIHRlbXBlcmF0
dXJlIG1pZ2h0IGJlIHdyb25nIQ0KaW5wdXQ6IFNodXR0bGUgSW5jIFZGRCBNb2R1bGUgYXMgL2Rl
dmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjIvdXNiNS81LTIvNS0yOjEuMC9pbnB1dC9pbnB1
dDINCmlucHV0OiBVU0IgSElEIHYxLjExIEtleWJvYXJkIFtTaHV0dGxlIEluYyBWRkQgTW9kdWxl
XSBvbiB1c2ItMDAwMDowMDoxYS4yLTINCmRyaXZlcnMvaGlkL3VzYmhpZC9oaWQtY29yZS5jOiBj
b3VsZG4ndCBmaW5kIGFuIGlucHV0IGludGVycnVwdCBlbmRwb2ludA0KaW5wdXQ6IFNodXR0bGUg
SW5jIFZGRCBNb2R1bGUgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFhLjIvdXNiNS81
LTIvNS0yOjEuMi9pbnB1dC9pbnB1dDMNCmlucHV0OiBVU0IgSElEIHYxLjExIERldmljZSBbU2h1
dHRsZSBJbmMgVkZEIE1vZHVsZV0gb24gdXNiLTAwMDA6MDA6MWEuMi0yDQppbnB1dDogTWljcm9z
b2Z0IE1pY3Jvc29mdCAzLUJ1dHRvbiBNb3VzZSB3aXRoIEludGVsbGlFeWU/IGFzIC9kZXZpY2Vz
L3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjYvNi0xLzYtMToxLjAvaW5wdXQvaW5wdXQ0DQpp
bnB1dDogVVNCIEhJRCB2MS4wMCBNb3VzZSBbTWljcm9zb2Z0IE1pY3Jvc29mdCAzLUJ1dHRvbiBN
b3VzZSB3aXRoIEludGVsbGlFeWU/XSBvbiB1c2ItMDAwMDowMDoxZC4wLTENCnVzYmNvcmU6IHJl
Z2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiaGlkDQpkcml2ZXJzL2hpZC91c2JoaWQv
aGlkLWNvcmUuYzogdjIuNjpVU0IgSElEIGNvcmUgZHJpdmVyDQpUQ1AgY3ViaWMgcmVnaXN0ZXJl
ZA0KVENQIHZlbm8gcmVnaXN0ZXJlZA0KTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAx
DQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3DQpkcml2ZXJzL3J0Yy9oY3Rvc3lz
LmM6IHVuYWJsZSB0byBvcGVuIHJ0YyBkZXZpY2UgKHJ0YzApDQpram91cm5hbGQgc3RhcnRpbmcu
ICBDb21taXQgaW50ZXJ2YWwgNSBzZWNvbmRzDQpFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0g
d2l0aCBvcmRlcmVkIGRhdGEgbW9kZS4NClZGUzogTW91bnRlZCByb290IChleHQzIGZpbGVzeXN0
ZW0pIHJlYWRvbmx5Lg0KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMTg4ayBmcmVlZA0K
QUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjFiLjBbQV0gLT4gR1NJIDIyIChsZXZlbCwgbG93
KSAtPiBJUlEgMjINClBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAw
OjFiLjAgdG8gNjQNCkxpbnV4IHZpZGVvIGNhcHR1cmUgaW50ZXJmYWNlOiB2Mi4wMA0Kc2FhNzE0
NjogcmVnaXN0ZXIgZXh0ZW5zaW9uICdidWRnZXRfYXYnLg0KQUNQSTogUENJIEludGVycnVwdCAw
MDAwOjAzOjA5LjBbQV0gLT4gR1NJIDE3IChsZXZlbCwgbG93KSAtPiBJUlEgMTcNClBDSTogU2V0
dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAzOjA5LjAgdG8gNjQNCnNhYTcxNDY6
IGZvdW5kIHNhYTcxNDYgQCBtZW0gZmZmZmMyMDAwMDAzZTAwMCAocmV2aXNpb24gMSwgaXJxIDE3
KSAoMHgxODk0LDB4MDAxNSkuDQpzYWE3MTQ2ICgwKTogZG1hIGJ1ZmZlciBzaXplIDE5MjUxMg0K
RFZCOiByZWdpc3RlcmluZyBuZXcgYWRhcHRlciAoS05DMSBEVkItUykNCmFkYXB0ZXIgZmFpbGVk
IE1BQyBzaWduYXR1cmUgY2hlY2sNCmVuY29kZWQgTUFDIGZyb20gRUVQUk9NIHdhcyBmZjpmZjpm
ZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZjpmZg0Kc2Fh
NzE0Nl92djogc2FhNzE0NiAoMCk6IHJlZ2lzdGVyZWQgZGV2aWNlIHZpZGVvMCBbdjRsMl0NCktO
QzEtMDogTUFDIGFkZHIgPSAwMDowOTpkNjo2NTphMDo3ZQ0KRFZCOiByZWdpc3RlcmluZyBmcm9u
dGVuZCAwIChTVCBTVFYwMjk5IERWQi1TKS4uLg0KYnVkZ2V0LWF2OiBjaSBpbnRlcmZhY2UgaW5p
dGlhbGlzZWQuDQpFWFQzIEZTIG9uIHNkYTMsIGludGVybmFsIGpvdXJuYWwNCmxpcmNfZGV2OiBJ
UiBSZW1vdGUgQ29udHJvbCBkcml2ZXIgcmVnaXN0ZXJlZCwgYXQgbWFqb3IgNjEgDQoNCmxpcmNf
bWNldXNiMjogUGhpbGlwcyBlSG9tZSBVU0IgSVIgVHJhbnNjaWV2ZXIgYW5kIE1pY3Jvc29mdCBN
Q0UgMjAwNSBSZW1vdGUgQ29udHJvbCBkcml2ZXIgZm9yIExJUkMgJFJldmlzaW9uOiAxLjI5ICQN
CmxpcmNfbWNldXNiMjogRGFuaWVsIE1lbGFuZGVyIDxsaXJjQHJhamlkYWUuc2U+LCBNYXJ0aW4g
QmxhdHRlciA8bWFydGluX2FfYmxhdHRlckB5YWhvby5jb20+DQp1c2Jjb3JlOiByZWdpc3RlcmVk
IG5ldyBpbnRlcmZhY2UgZHJpdmVyIGxpcmNfbWNldXNiMg0Kc2t5MiBldGgwOiBlbmFibGluZyBp
bnRlcmZhY2UNCnNreTIgZXRoMDogTGluayBpcyB1cCBhdCAxMDAgTWJwcywgZnVsbCBkdXBsZXgs
IGZsb3cgY29udHJvbCBib3RoDQo=

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_6c2f4b92-0a7d-47c5-8738-37e4caa29222_--
