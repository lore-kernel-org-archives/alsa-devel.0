From: Kevin Hilman <khilman@ti.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Thu, 01 Mar 2012 10:22:17 -0800
Message-ID: <87d38wfag6.fsf@ti.com>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
	<87zkc1cvaa.fsf@ti.com>
	<CAN8ccib90y8m0KLTYKe7Jz5sXVZFY=D7aUwm8vog3aZvZPHH0Q@mail.gmail.com>
	<874nu99k9y.fsf@ti.com>
	<CAN8cciayARuQGLH=DHsReH0sYbz92K3BPNhmNEqYmSjc6wUUVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 45955103CDD
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 19:22:35 +0100 (CET)
Received: by mail-pz0-f53.google.com with SMTP id y25so1213910dad.26
	for <alsa-devel@alsa-project.org>; Thu, 01 Mar 2012 10:22:20 -0800 (PST)
In-Reply-To: <CAN8cciayARuQGLH=DHsReH0sYbz92K3BPNhmNEqYmSjc6wUUVw@mail.gmail.com>
	(Raymond Yau's message of "Thu, 1 Mar 2012 13:56:21 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau <superquad.vortex2@gmail.com> writes:

> 2012/3/1, Kevin Hilman <khilman@ti.com>:
>> Raymond Yau <superquad.vortex2@gmail.com> writes:
>>
>> [...]
>>
>>>> As you can see, there's no detected difference between the TRS and TRRS
>>>> headsets, which is the root of the problem.
>>>
>>> can you post the output of alsa-info.sh ?
>>
>> below is the output when the headset w/mic is plugged in
>>
>>> In the codec info, do you find  Misc bit of pin defaults of the node
>>> [jack] Mic at Ext is set ? (i.e. Misc = NO_PRESENCE ) ?
>>
>> I don't see any Mic at Ext, but I do see a 'Mic at Int' and it shows
>> NO_PRESENCE.
>>
>> Should I be seeing a 2 different Mics?  one for internal one for external?
>
>> Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
>>   Control: name="Headphone Jack", index=0, device=0
>>   Pincap 0x0000001c: OUT HP Detect
>>   Pin Default 0x012b4030: [Jack] HP Out at Ext Rear
>>     Conn = Comb, Color = Green
>>     DefAssociation = 0x3, Sequence = 0x0
>>   Pin-ctls: 0xc0: OUT HP
>>   Unsolicited: tag=01, enabled=1
>>   Power states:  D0 D3 EPSS
>>   Power: setting=D0, actual=D0
>>   Delay: 1 samples
>>   Connection: 1
>>      0x02
>
> Headphone Conn=Combo
> but Pincap is OUTPUT only so it cannot be retasked as Input
>
> Does internal mic work or not ?

Yes, it works fine.

> It Int Mic is correct and 0x06 [Audio Input] is used ,
>
> ext mic may be at 0x0e
>
> you can use hda_analyzer to switch the connection at node 0x6 from 0x0d to 0x0e
> to test the external mic

Here's what I tried:

Selecting Node 0x6, I changed the connection from 0xd to 0xe.
Selecting Node 0xe, I checked the 'IN' box under Widget control (which
is what 0xd had enabled.), then changed the Val[0] and Val[1] sliders
from 0 to 2 under Input Amplifier.

Still no input detected from the headset mic.

FWIW, I'm using the 'Input level' indicator in the Input tab of the
Sound settings in the Ubuntu control panel to check if the input is
working.

>
>> Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
>>   Control: name="Capture Switch", index=0, device=0
>>   Control: name="Capture Volume", index=0, device=0
>>   Device: name="Cirrus Analog", type="Audio", device=0
>>   Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
>>   Amp-In vals:  [0x3f 0x3f] [0x3f 0x3f]
>>   Converter: stream=0, channel=0
>>   SDI-Select: 0
>>   PCM:
>>     rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
>>     bits [0x1e]: 16 20 24 32
>>     formats [0x3]: PCM FLOAT
>>   Power states:  D0 D3 EPSS
>>   Power: setting=D0, actual=D0
>>   Delay: 8 samples
>>   Connection: 2
>>      0x0d* 0x0e
>
>>Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
>>  Control: name="Mic Capture Volume", index=0, device=0
>>    ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>  Amp-In vals:  [0x03 0x03]
>>  Pincap 0x00001764: IN Detect Balanced
>>    Vref caps: HIZ 50 GRD 80
>>  Pin Default 0x90a00110: [Fixed] Mic at Int N/A
>>    Conn = Unknown, Color = Unknown
>>    DefAssociation = 0x1, Sequence = 0x0
>>    Misc = NO_PRESENCE
>>  Pin-ctls: 0x24: IN VREF_80
>>  Unsolicited: tag=00, enabled=0
>>  Power states:  D0 D3 EPSS
>>  Power: setting=D0, actual=D0
>>  Delay: 1 samples
>> Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
>>   Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
>>   Amp-In vals:  [0x00 0x00]
>>   Pincap 0x00000020: IN
>>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>>     Conn = Unknown, Color = Unknown
>>     DefAssociation = 0xf, Sequence = 0x0
>>   Pin-ctls: 0x00:
>>   Delay: 1 samples
>
>
> There are also other possibilities 0xc and 0x12  if 0x05 is used
>
>
> Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
>   Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
>   Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
>     bits [0x1e]: 16 20 24 32
>     formats [0x3]: PCM FLOAT
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
>   Delay: 8 samples
>   Connection: 2
>      0x0c* 0x12

OK, I selected Node 0x5, and un-checked the mute box for the 4 sliders
under Input amplifier, and increased the sliders to the max of 63.
The 0xc connection was the default, so I started with that one.
Selecting Node 0xc, I checked the 'IN' box under widget control and
changed the 2 Val sliders under Input Amplifier from 0 to 3.

Still nothing detected on headset mic.

Under 0x05, I then selected the 0x12 connection.  Selecting Node 0x12, I
again selected the 'IN' box under widget control and increased the 2 Val
sliders from 0 to 3.

Still nothing.

Kevin
