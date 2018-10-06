From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Sat, 6 Oct 2018 18:07:10 +0900
Message-ID: <bc5df36b-f9ed-f39d-381f-13fc6bc85f16@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <4e0b4dc88db65ddd3055f3266af509fd439472c5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id B2D8426783D
 for <alsa-devel@alsa-project.org>; Sat,  6 Oct 2018 11:07:15 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id c8-v6so7892301plo.9
 for <alsa-devel@alsa-project.org>; Sat, 06 Oct 2018 02:07:15 -0700 (PDT)
In-Reply-To: <4e0b4dc88db65ddd3055f3266af509fd439472c5.camel@suse.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Bahling <sbahling@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On Oct 4 2018 05:37, Scott Bahling wrote:
> On Tue, 2018-10-02 at 12:16 +0900, Takashi Sakamoto wrote:
>> I have an idea to invervene them:
>>
>> 1. For control events, in kernel land, driver module detects
>> changes of set of bitflags for physical controls, then queue
>> events to tell the change to userspace applications
>> (e.g. poll(2)). The queued events include information about
>> changed bitflags (e.g. a shape of u32 data). Userspace
>> applications execute read(2) then get the bitflags, then parse
>> it and emit userspace event by ports in ALSA sequencer
>> subsystem.
>> The driver and userspace application should pay enough
>> attention to share the queue. The driver can drop the oldest
>> queued events if the queue is full.
>>
>> 2. For level meter, in kernel land, driver module caches the
>> recent value. Userspace applications execute ioctl(2) with
>> unique command (You can see this kind of commands in
>> 'include/uapi/sound/firwire.h').
>>
>> However, as long as I note[2], the purpose of some quadlets in the
>> image are not still identified:
>>
>> "Quadlet 00-15 show control messages. Quadlet 16-23 show analog input
>> level. Quadlet 24-31 shows digital ADAT input level. Quadlet 32-33
>> shows digital S/PDIF input level. Quadlet 34-35 is unknown.
> 
> On my FW-1884 34/35 is analog level of output 1/2. The "Monitor" level
> pot (as well as the master fader if enabled) control the level so if
> they are set at 0, then you will not see any signal on the 34/35.
> 
>> Quadlet
>> 36-43 shows analog output level.
> 
> 36-41 = analog outputs 3-8
> 
>> The other quadlets are unknown."
> 
> 52: shows the current sample rate setting
>      010101xx = 44.1k
>      020102xx = 48k
>      810181xx = 88.2k
>      820182xx = 96k
> 
> 52: Byte 1 shows the current clock source
>      0x01 = Internal
>      0x02 = Word Clock
>      0x03 = Digital In
>      0x04 = ADAT
> 
> 54-55 appears to be the level of the internal "Monitor Mix".
> 57-58 appears to be the level of the stereo mix of the analog inputs
> 
> 59: Byte 1 indicates what is routed to the Monitor Mix
>      0x01 = PCM Stream from computer
>      0x02 = Analog Inputs
>      0x03 = Both
> 
>> We need further investigation to clear the unknown fields as much as
>> possible to add more codes in ALSA kernel land.
> 
> Above is as far as I have gotten with the unknown fields.
> 
> On the asynchronous side, I have mapped out the LED codes to the LEDs
> on the FW-1884 and discovered the registers for controlling the faders.

Thanks for your report. I have additional information from today
investigation. In detail, please read the end of this message.

I think it reasonable to take kernel-land driver emits events for
quadlet 05-15 to userspace applications, then let SndTscm object in
libhinawa. (Extra care is required for the value of monitor-knob).
Additionally, SndTscm object produces API to retrieve current value
of fader, knob and so on.

Anyway, initial value should be reported to userspace, mmm...

======== 8< --------

00: fader2 fader1
01: fader4 fader3
02: fader6 fader5
03: fader8 fader7
04: solo-knob fader9(=master)

The value of fader is between 0x0000 and 0x03ff (2byte).
The value of solo-knob (FW-1884 only) is between 0x0000 and
0x03ff (2byte).

05: op-mode+fader-sense monitor-knob

op-mode is 7 bits in MSB side.
  - 0x00: computer mode
  - 0xfe: midi-ctl/mon-mix modes

The value of fader-sense consists of bitflags in which
a bit becomes zero during user touches corresponding fader.
This is next 9 bits in MSB side.
  - 0x0100: for fader 9 (=master)
  - 0x0080: for fader 8
    ...
  - 0x0001: for fader 1

The value of monitor-knob is between 0x0000 and 0x03ff.
But the lowest bits becomes frequently without handy operation.

06: bitflags
07: bitflags
08: bitflags
09: bitflags

These bitflags consists two states:
  - During corresponding button is pressed, bit becomes zero.
  - some sets of 2 bits represent current value of corresponding
    knob.
The position is largely different depending on FW-1884/FW-1082.

10: unknown unknown
11: unknown unknown
12: unknown unknown
13: unknown unknown
14: unknown unknown

15: dial-value unknown

The value of dial is between 0x0000 and 0xffff, accumulated clockwise.
At overflow it resets to 0x0000.

16: analog-in-1
17: analog-in-2
18: analog-in-3
19: analog-in-4
20: analog-in-5
21: analog-in-6
22: analog-in-7
23: analog-in-8
24: adat-in-1
25: adat-in-2
26: adat-in-3
27: adat-in-4
28: adat-in-5
29: adat-in-6
30: adat-in-7
31: adat-in-8
32: s/pdif-in-1
33: s/pdif-in-2
34: analog-out-1
35: analog-out-2
36: analog-out-3
37: analog-out-4
38: analog-out-5
39: analog-out-6
40: analog-out-7
41: analog-out-8
42: adat-out-1
43: adat-out-2
44: adat-out-3
45: adat-out-4
46: adat-out-5
47: adat-out-6
48: adat-out-7
49: adat-out-8

The value of level is between 0x00000000 and 0x7fffff00.

50: (unknown)
51: (unknown)

I expect them for spdif-out-1/2 but actually they're not.

52: clock-status clock-config

As Scott investigated, but configuration of clock source
is not necessarily effective in bits of clock-status.

53: (unknown)
54: monitor-mix-1 (enabled at INPUT/BOTH modes)
55: monitor-mix-2 (enabled at INPUT/BOTH modes)
56: (unknown)
57: analog-in-mix-1
58: analog-in-mix-2

59: 0:COMPUTER, 1:INPUTS, 2:BOTH

At monitor mix mode, the above selections are available.

60: (unknown)
61: (unknown)
62: (unknown)
63: (unknown)

======== 8< --------

Thanks

Takashi Sakamoto
