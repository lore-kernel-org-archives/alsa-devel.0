From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Sun, 07 Oct 2018 13:32:54 +0200
Message-ID: <9a365a25cc65997a4d918129ebd437787e861774.camel@suse.com>
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
 <bc5df36b-f9ed-f39d-381f-13fc6bc85f16@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 81647267791
 for <alsa-devel@alsa-project.org>; Sun,  7 Oct 2018 13:32:56 +0200 (CEST)
In-Reply-To: <bc5df36b-f9ed-f39d-381f-13fc6bc85f16@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Sat, 2018-10-06 at 18:07 +0900, Takashi Sakamoto wrote:
> Hi Scott,

> 
> Thanks for your report. I have additional information from today
> investigation. In detail, please read the end of this message.

Your findings match mine.

> I think it reasonable to take kernel-land driver emits events for
> quadlet 05-15 to userspace applications, then let SndTscm object in
> libhinawa. (Extra care is required for the value of monitor-knob).
> Additionally, SndTscm object produces API to retrieve current value
> of fader, knob and so on.
> 
> Anyway, initial value should be reported to userspace, mmm...
> 
> ======== 8< --------
> 
> 00: fader2 fader1
> 01: fader4 fader3
> 02: fader6 fader5
> 03: fader8 fader7
> 04: solo-knob fader9(=master)
> 
> The value of fader is between 0x0000 and 0x03ff (2byte).
> The value of solo-knob (FW-1884 only) is between 0x0000 and
> 0x03ff (2byte).
> 
> 05: op-mode+fader-sense monitor-knob
> 
> op-mode is 7 bits in MSB side.
>   - 0x00: computer mode
>   - 0xfe: midi-ctl/mon-mix modes
> 
> The value of fader-sense consists of bitflags in which
> a bit becomes zero during user touches corresponding fader.
> This is next 9 bits in MSB side.
>   - 0x0100: for fader 9 (=master)
>   - 0x0080: for fader 8
>     ...
>   - 0x0001: for fader 1
> 
> The value of monitor-knob is between 0x0000 and 0x03ff.
> But the lowest bits becomes frequently without handy operation.

I notice the same unstable low bits with the Solo knob as well.

> 06: bitflags
> 07: bitflags
> 08: bitflags
> 09: bitflags
> 
> These bitflags consists two states:
>   - During corresponding button is pressed, bit becomes zero.
>   - some sets of 2 bits represent current value of corresponding
>     knob.

The 2 bits are actually the raw encoder bits from the knobs. This is a
"quadrature output" [1] showing the velocity and direction of the
encoder as it spins.  This bits can also be unstable and fluctuate when
there is no movement depending on the position of the encoder knob. If
used, some form of filtering would need to be done to avoid triggering
false updates.

The FW-1884 also tracks the absolute position of the encoders as 16 bit
values similar to the dial-value. They are tracked at quadlets 10-15.

> The position is largely different depending on FW-1884/FW-1082.

I have all the buttons of the FW-1884 mapped out to the bitflags. See
the end of this email.

> 10: unknown unknown
> 11: unknown unknown
> 12: unknown unknown
> 13: unknown unknown
> 14: unknown unknown

10: encoder2 encoder1
11: encoder4 encoder3
12: encoder6 encoder5
13: encoder8 encoder7
14: Freq     Gain

> 15: dial-value unknown

15: dial-value Q

> The value of dial is between 0x0000 and 0xffff, accumulated clockwise.
> At overflow it resets to 0x0000.
> 
> 16: analog-in-1
> 17: analog-in-2
> 18: analog-in-3
> 19: analog-in-4
> 20: analog-in-5
> 21: analog-in-6
> 22: analog-in-7
> 23: analog-in-8
> 24: adat-in-1
> 25: adat-in-2
> 26: adat-in-3
> 27: adat-in-4
> 28: adat-in-5
> 29: adat-in-6
> 30: adat-in-7
> 31: adat-in-8
> 32: s/pdif-in-1
> 33: s/pdif-in-2
> 34: analog-out-1
> 35: analog-out-2
> 36: analog-out-3
> 37: analog-out-4
> 38: analog-out-5
> 39: analog-out-6
> 40: analog-out-7
> 41: analog-out-8
> 42: adat-out-1
> 43: adat-out-2
> 44: adat-out-3
> 45: adat-out-4
> 46: adat-out-5
> 47: adat-out-6
> 48: adat-out-7
> 49: adat-out-8
> 
> The value of level is between 0x00000000 and 0x7fffff00.
> 
> 50: (unknown)
> 51: (unknown)
> 
> I expect them for spdif-out-1/2 but actually they're not.
> 
> 52: clock-status clock-config
> 
> As Scott investigated, but configuration of clock source
> is not necessarily effective in bits of clock-status.
> 
> 53: (unknown)
> 54: monitor-mix-1 (enabled at INPUT/BOTH modes)
> 55: monitor-mix-2 (enabled at INPUT/BOTH modes)
> 56: (unknown)
> 57: analog-in-mix-1
> 58: analog-in-mix-2
> 
> 59: 0:COMPUTER, 1:INPUTS, 2:BOTH
> 
> At monitor mix mode, the above selections are available.
> 
> 60: (unknown)
> 61: (unknown)
> 62: (unknown)
> 63: (unknown)
> 
> ======== 8< --------

Button Mapping:

Quadlet 6
=========

Bit Button
--- --------------
  1 unknown
  2 unknown 
  3 unknown
  4 unknown

  5 unknown
  6 unknown
  7 unknown
  8 unknown

  9 unknown
 10 unknown
 11 unknown
 12 unknown

 13 unknown
 14 unknown
 15 unknown
 16 unknown

 17 Sel Channel 1
 18 Sel Channel 2
 19 Sel Channel 3
 20 Sel Channel 4

 21 Sel Channel 5
 22 Sel Channel 6
 23 Sel Channel 7
 24 Sel Channel 8

 25 Solo Channel 1
 26 Solo Channel 2
 27 Solo Channel 3
 28 Solo Channel 4

 29 Solo Channel 5
 30 Solo Channel 6
 31 Solo Channel 7
 32 Solo Channel 8


Quadlet 7
=========

Bit Button
--- --------------
  1 Mute Channel 1
  2 Mute Channel 2
  3 Mute Channel 3
  4 Mute Channel 4

  5 Mute Channel 5
  6 Mute Channel 6
  7 Mute Channel 7
  8 Mute Channel 8

  9 Aux5
 10 Aux7
 11 Aux6
 12 Aux8

 13 unknown
 14 unknown
 15 unknown
 16 unknown

 17 Flip
 18 Aux1
 19 Aux3
 20 Pan

 21 Aux2
 22 Aux4
 23 unknown 
 24 unknown 

 25 Control Panel
 26 Save
 27 All Save
 28 Marker

 29 Cut
 30 Copy
 31 Alt
 32 Shift


Quadlet 8
=========

Bit Button
--- --------------
  1 Revert
  2 Clr Solo
  3 Loop
  4 Del

  5 Paste
  6 Undo
  7 Ctrl
  8 unknown

  9 Foot Switch
 10 unknown
 11 unknown
 12 unknown

 13 unknown
 14 unknown
 15 unknown
 16 unknown

 17 unknown
 18 unknown
 19 unknown
 20 unknown

 21 unknown
 22 unknown
 23 unknown
 24 unknown 

 25 unknown
 26 unknown
 27 unknown
 28 unknown

 29 Clock
 30 Route
 31 unknown
 32 unknown


Quadlet 9
=========

Bit Button
--- --------------
  1 F7
  2 F8
  3 F9
  4 F10

  5 Read
  6 Wrt
  7 Tch
  8 Latch

  9 High
 10 Hi-Mid
 11 Hi-Low
 12 Low

 13 Up
 14 Left
 15 Down
 16 Right

 17 Rec
 18 Nudge Left
 19 Nudge Right
 20 Bank Left

 21 Bank Right
 22 Locate Left
 23 Locate Right
 24 Shtl

 25 Set
 26 In
 27 Out
 28 REW

 29 F.FWD
 30 STOP
 31 PLAY
 32 REC

===============


[1] https://en.wikipedia.org/wiki/Incremental_encoder

-Scott
