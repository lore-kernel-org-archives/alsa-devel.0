From: Kevin Hilman <khilman@ti.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Fri, 02 Mar 2012 11:32:14 -0800
Message-ID: <87booesssh.fsf@ti.com>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
	<87zkc1cvaa.fsf@ti.com>
	<CAN8ccib90y8m0KLTYKe7Jz5sXVZFY=D7aUwm8vog3aZvZPHH0Q@mail.gmail.com>
	<874nu99k9y.fsf@ti.com>
	<CAN8cciayARuQGLH=DHsReH0sYbz92K3BPNhmNEqYmSjc6wUUVw@mail.gmail.com>
	<87d38wfag6.fsf@ti.com>
	<CAN8cciaB6-GUvsPS8+bpftLb7BaawdpCsgY3Z7R9H+XdkJ8LNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id EF8E7245B1
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 20:32:40 +0100 (CET)
Received: by mail-pz0-f47.google.com with SMTP id o14so2064681dad.6
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 11:32:21 -0800 (PST)
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

> 2012/3/2, Kevin Hilman <khilman@ti.com>:
>
>
>>> Does your headset/mic has a TRRS (Tip, ring, ring, sleeve) connector
>>> instead of TRS (Tip, ring, sleeve) connector ?
>
>> Yes.  It's TRRS.
>
> Does it mean that the headset/mic is a mono mic ?
>
> Is the internal mic mono or stereo ?

I believe it's mono.  Based on vumeter activity, and the fact that
changing only one slider in hda_analyzer is needed to quiet/mute the
mic.

>>>>>
>>>>> can you post the output of alsa-info.sh ?
>>>>
>>>> below is the output when the headset w/mic is plugged in
>>>>
>>>>> In the codec info, do you find  Misc bit of pin defaults of the node
>>>>> [jack] Mic at Ext is set ? (i.e. Misc = NO_PRESENCE ) ?
>>>>
>>>> I don't see any Mic at Ext, but I do see a 'Mic at Int' and it shows
>>>> NO_PRESENCE.
>>>>
>>>> Should I be seeing a 2 different Mics?  one for internal one for
>>>> external?
>
> the functions parse_input() and change_cur_input() in patch_cirrus.c
> seem expect ext mic and int mic for auto mic detection
>
> e.g.
>
> 	/* check whether the automatic mic switch is available */
> 	if (spec->num_inputs == 2 &&
> 	    cfg->inputs[0].type == AUTO_PIN_MIC &&
> 	    cfg->inputs[1].type == AUTO_PIN_MIC) {
>
> so it won't switch mic automatically when there is one mic pin
>
>
> 	if (spec->cur_adc && spec->cur_adc != spec->adc_nid[idx]) {
> 		/* stream is running, let's swap the current ADC */
>
> it swap the ADC if the external mic and internal mic are connected to
> different ADCs
>
> but there is no mic connected to other ADC
>
>
>>>
>>>> Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
>>>>   Control: name="Headphone Jack", index=0, device=0
>>>>   Pincap 0x0000001c: OUT HP Detect
>>>>   Pin Default 0x012b4030: [Jack] HP Out at Ext Rear
>>>>     Conn = Comb, Color = Green
>>>>     DefAssociation = 0x3, Sequence = 0x0
>>>>   Pin-ctls: 0xc0: OUT HP
>>>>   Unsolicited: tag=01, enabled=1
>>>>   Power states:  D0 D3 EPSS
>>>>   Power: setting=D0, actual=D0
>>>>   Delay: 1 samples
>>>>   Connection: 1
>>>>      0x02
>>>
>>> Headphone Conn=Combo
>>> but Pincap is OUTPUT only so it cannot be retasked as Input
>>>
>>> Does internal mic work or not ?
>>
>> Yes, it works fine.
>>
>
> arecord --vumeter=stereo -f CD -Dhw:0,0 foo.wav
>
> does the vumeters change when you change the sliders of node 0x0d or
> 0x06 in hda-analyzer ?

Yes.  The sliders in either 0xd or 0x6 affect the input level.

>>> It Int Mic is correct and 0x06 [Audio Input] is used ,
>>>
>>> ext mic may be at 0x0e
>>>
>>> you can use hda_analyzer to switch the connection at node 0x6 from 0x0d to
>>> 0x0e
>>> to test the external mic
>>
>> Here's what I tried:
>>
>> Selecting Node 0x6, I changed the connection from 0xd to 0xe.
>> Selecting Node 0xe, I checked the 'IN' box under Widget control (which
>> is what 0xd had enabled.), then changed the Val[0] and Val[1] sliders
>> from 0 to 2 under Input Amplifier.
>>
>> Still no input detected from the headset mic.
>>
>> FWIW, I'm using the 'Input level' indicator in the Input tab of the
>> Sound settings in the Ubuntu control panel to check if the input is
>> working.
>>
>
> pulseaudio just sum the stereo input to mono , and you get silence if
> the left/right channel is out of phase
>
>>>
>>>> Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
>>>>   Control: name="Capture Switch", index=0, device=0
>>>>   Control: name="Capture Volume", index=0, device=0
>>>>   Device: name="Cirrus Analog", type="Audio", device=0
>>>>   Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
>>>>   Amp-In vals:  [0x3f 0x3f] [0x3f 0x3f]
>>>>   Converter: stream=0, channel=0
>>>>   SDI-Select: 0
>>>>   PCM:
>>>>     rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
>>>>     bits [0x1e]: 16 20 24 32
>>>>     formats [0x3]: PCM FLOAT
>>>>   Power states:  D0 D3 EPSS
>>>>   Power: setting=D0, actual=D0
>>>>   Delay: 8 samples
>>>>   Connection: 2
>>>>      0x0d* 0x0e
>>>
>>>>Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
>>>>  Control: name="Mic Capture Volume", index=0, device=0
>>>>    ControlAmp: chs=3, dir=In, idx=0, ofs=0
>>>>  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>>>  Amp-In vals:  [0x03 0x03]
>>>>  Pincap 0x00001764: IN Detect Balanced
>>>>    Vref caps: HIZ 50 GRD 80
>>>>  Pin Default 0x90a00110: [Fixed] Mic at Int N/A
>>>>    Conn = Unknown, Color = Unknown
>>>>    DefAssociation = 0x1, Sequence = 0x0
>>>>    Misc = NO_PRESENCE
>>>>  Pin-ctls: 0x24: IN VREF_80
>>>>  Unsolicited: tag=00, enabled=0
>>>>  Power states:  D0 D3 EPSS
>>>>  Power: setting=D0, actual=D0
>>>>  Delay: 1 samples
>>>> Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
>>>>   Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
>>>>   Amp-In vals:  [0x00 0x00]
>>>>   Pincap 0x00000020: IN
>>>>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>>>>     Conn = Unknown, Color = Unknown
>>>>     DefAssociation = 0xf, Sequence = 0x0
>>>>   Pin-ctls: 0x00:
>>>>   Delay: 1 samples
>>>
>>>
>>> There are also other possibilities 0xc and 0x12  if 0x05 is used
>>>
>>>
>>> Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
>>>   Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
>>>   Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
>>>   Converter: stream=0, channel=0
>>>   SDI-Select: 0
>>>   PCM:
>>>     rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
>>>     bits [0x1e]: 16 20 24 32
>>>     formats [0x3]: PCM FLOAT
>>>   Power states:  D0 D3 EPSS
>>>   Power: setting=D0, actual=D0
>>>   Delay: 8 samples
>>>   Connection: 2
>>>      0x0c* 0x12
>>
>> OK, I selected Node 0x5, and un-checked the mute box for the 4 sliders
>> under Input amplifier, and increased the sliders to the max of 63.
>> The 0xc connection was the default, so I started with that one.
>> Selecting Node 0xc, I checked the 'IN' box under widget control and
>> changed the 2 Val sliders under Input Amplifier from 0 to 3.
>>
>> Still nothing detected on headset mic.
>>
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio.txt
>
> you need to use hda-jack-retask or early patching to change the pin
> default of  node 0xe,  0xc or 0x12 default to "ext mic"

Using hda-jack-retask, under the Cirrus codec, I only saw options for
0x9, 0xb and 0xd.     0xd has 4 options: Microphone, Line In, Internal
mic, and Not connected.   I tried all 4 of these and none resulted in
input from the headset mic.  Microphone and Internal Mic both were the
built-in internal mic, the other 2 stopped the internal mic from
working, but didn't get the headset mic working.

I had to 'Show unconnected pins' in order to see the rest of the nodes.
For 0xe, 0xc and 0x12, the options are only 'Internal Mic' and 'Not
connected' and the default was Not connected for all of them.  I tried
switching them each to 'Internal Mic' but still don't get anything from
the headset mic.

Note that I had to reboot for each of these tests since the 'Apply now'
feature of hda-jack-retask didn't work.  I always reported:

   tee: /sys/class/sound/hwC0D0/reconfig: Device or resource busy

even with pulseaudio not running and fuser didn't report anyone using
/dev/snd/*

> either hda-reconfig or early patching  if  node 0x0e, 0x0c 0r 0x12 is ext mic
>
>
>> Under 0x05, I then selected the 0x12 connection.  Selecting Node 0x12, I
>> again selected the 'IN' box under widget control and increased the 2 Val
>> sliders from 0 to 3.
>>
>> Still nothing.
>>
>
> Only the pincap of node  0xc and 0xd support jack detect , and node
> 0x0e and 0x12

Did you mean to finish a thought here... ?

>
> Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D3 EPSS
>   Power: setting=D0, actual=D0
>   Delay: 1 samples
>
> Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Pincap 0x00000020: IN
>   Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>     DefAssociation = 0xf, Sequence = 0x0
>   Pin-ctls: 0x00:
>   Delay: 1 samples
>
>
>
> the last resort is to use hda-verb to check jack detect  of pin 0xd,
> 0xe, 0xc and 0x12
>
>
> hda-verb /dev/snd/hwC0D0 0x0d GET_PIN_SENSE 0

With the headset plugged in:

$ sudo hda-verb /dev/snd/hwC0D0 0x0d GET_PIN_SENSE 0
nid = 0xd, verb = 0xf09, param = 0x0
value = 0x0

$ sudo hda-verb /dev/snd/hwC0D0 0x0e GET_PIN_SENSE 0
nid = 0xe, verb = 0xf09, param = 0x0
value = 0x0

$ sudo hda-verb /dev/snd/hwC0D0 0x0c GET_PIN_SENSE 0
nid = 0xc, verb = 0xf09, param = 0x0
value = 0x0

$ sudo hda-verb /dev/snd/hwC0D0 0x12 GET_PIN_SENSE 0
nid = 0x12, verb = 0xf09, param = 0x0
value = 0x0

And the same result with the headset unplugged.


Thanks again for all your advice and ideas to test.  I'll be glad to
keep doing experiments.

Kevin
