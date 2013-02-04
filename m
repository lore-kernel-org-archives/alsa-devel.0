From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Mon, 04 Feb 2013 17:56:54 +0100
Message-ID: <510FE856.9050206@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
 <510A485F.9060100@ivitera.com> <510AEF46.1080608@gmail.com>
 <510C6A3C.1000501@gmail.com> <510CEE14.2050800@ivitera.com>
 <510D9799.6070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 35A582602DC
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 17:56:54 +0100 (CET)
In-Reply-To: <510D9799.6070307@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 2.2.2013 23:47, Jonas Petersen wrote:
> Am 02.02.2013 11:44, schrieb Pavel Hofman:
> 
> Yeah, I found the right combination, it's OCKS0=1,OCKS1=0. Now the spdif
> input works, thank you!

Congrats.
> 
> I wonder why there is no level controls for the analog input (e.g. in
> alsamixer). Is that because the "AK5385 ADC chip has no control"? The
> ESI Juli doesn't have an analog input level control as well.

Right, ak5385 offers no attenuation control.

> 
> 
> Ok, to make it clear, on the ap192 the FSx registers are always at their
> default (0001). So far I've never seen them on any other value. Only the
> corresponding Channel Status bits do change.

OK

> 
> Well, I guess by default snd_ak4114_rate_get should still interpret the
> FSx bits. Other cards might work as expected (see 'Observation C' below).
> In the case of the ap192 it might make sense to read the Channel Status.
> Maybe it needs a flag that gets set on card initializing indicating what
> should be used?
> 
> But, after all it seems there is still something obscure in the rate
> detection. Because while watching the ak4114 registers when switching
> sample rates I made the following observations:
> 
> Observation A:
> 
> RME Multiface spdif out goes to AP192 spdif in. In Linux the FSx bits
> are alwas "0001" and the Channel Status bis are set according to sample
> rate and mode (consumer/professional).

That means the RME driver configured the SPDIF-out preamble correctly.
In alsa e.g. using the iecset tool.

> 
> Observation B:
> 
> ESI Julia spdif out goes to AP192 spdif in. (Recall that in windows the
> AP192 _does_ detect sample rate changes!)
> In Linux the FSx bits are alwas "0001" and the Channel Status bis are
> (almost) always _all_ "0". It seems the ESI does not send Channel Status
> at all (could it be the misconfiguration of the ESI?). It looks like this:
> 
> 0x07 = 0x10 (00010000) [FS3,2,1,0 etc.]
> 0x08 = 0x00 (00000000) [CS0]
> 0x09 = 0x00 (00000000) [CS1]
> 0x0a = 0x00 (00000000) [CS2]
> 0x0b = 0x00 (00000000) [CS3]
> 0x0c = 0x00 (00000000) [CS4]
> 
> There is one strange exception. When I switch the output to spdif in the
> (I think it is) pulseaudio GUI. Then register 0x09 will be '00000010'
> for 5 second and switch back to '00000000'. When I play the test sound,
> then register 0x09 _and_ register 0x0b will be '00000010' for 5 second
> and switch back. Other than that the Channel Status does not change.

I do not know in windows, but in alsa the SPDIF bits can be set
explicitly by user space. See the AESx params in
/usr/share/alsa/pcm/iec958.conf , /usr/share/alsa/cards/ICE1724.conf
(setting the alsa control "IEC958 Playback Default"). ICE1724 datasheet
says the integrated SPDIF transmitter should set the corresponding SPDIF
bits (reg MT3C) automatically:

quote

These bits declare the S/PDIF transmitter clock rate (64*fs) in the
Channel Status Byte 3, low
nibble if Consumer mode (MT3C_0 = 0) and Byte 0 (bits 7-6) and Byte 4
(bits 6-3) if
Professional mode (MT3C_0 = 1). It will be set automatically by MT01 low
nibble if master. In
slave mode (MT01_4 = 1), to display the correct sampling rate, it must
be written to reflect the
external clock recovered.

endquote


> 
> Now, how is the windows driver detecting the rate if there is a) no
> crystal in there and b) no Channel Status available? Might it be the
> clock being on PLL (I'm not realy aware of what that means right now)?

I do not know, are you sure there is really no channel status available?

> 
> One thing might be of interest here: when switching the sample rates,
> register 0x06 does the following: Bit 0, bit 4 and flash to 1 for a
> short moment and back to zero (sometimes 2 times in a row).
> 
> 0x06 = 0x11 (00010001) [flash to 1]
> 0x06 = 0x00 (00000000) [and back to 0]
> 
> Bit 0 is "PAR: Parity Error or Biphase Error Status"
> Bit 4 is "PLL Lock Status" (1 being "Out of Lock")
> 
> Observation C (this is regarding ESI Juli):
> 
> dbx 376 tube channel strip spdif out goes to ESI Juli spdif in.
> The FSx bits in register 0x07 of ESI Juli's AK4114 _do_ change on
> different sample rates. They do not match those in the datasheet though:
> 
> 1000 - 44kHz (expected: 0000)
> 1010 - 48kHz (expected: 0010)
> 1100 - 88.2kHz (expected: 1000)
> 1110 - 96kHz (expected: 1010)
> 
> So maybe this is another symptom of the ESI's misconfiguration?


When I tested the driver of Juli the values worked correctly. Let's
figure out AP192 first and then attack Juli :)


> 
> 
>> Back to the light indicating "sync source" in the windows driver. I
>> think it is reading status of GPIO06 as you reported "INT0 (pin36) --
>> GPIO6 pin 58". It would be possible to add a new read-only control for
>> sync source to revo.c for ap192. It might be useful. Of course a generic
>> method for ak4114.c would be more suitable but we would have to abstract
>> the reading method.
> 
> Ok, why not adding a control for that. But first explain something to
> me. I see these 15 control definitions "snd_ak4114_iec958_controls[]" in
> ak4114.c. How are they accessed? Where can I read for example the
> "IEC958 External Rate" value? In the proc dir they do not show up.
> Neither at Juli nor at AP192. Are these only API functions?

see output of amixer contents. They are defined as PCM-type controls
(not MIXER type and do not apper e.g. in alsamixer.

Regards,

Pavel.
