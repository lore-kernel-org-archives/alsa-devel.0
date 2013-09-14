From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mic Boost channel is unused
Date: Fri, 13 Sep 2013 20:34:04 -0400
Message-ID: <5233AEFC.8000907@canonical.com>
References: <5231E348.8020204@gnat.ca> <52333782.9070402@gnat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CE6F4261A95
 for <alsa-devel@alsa-project.org>; Sat, 14 Sep 2013 02:34:10 +0200 (CEST)
In-Reply-To: <52333782.9070402@gnat.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nathanael D. Noblet" <nathanael@gnat.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013-09-13 12:04, Nathanael D. Noblet skrev:
> Sorry I some how deleted your response... so this may not thread well...
>
> Only about 20% of what you said makes much sense to me so you'll have 
> to bear with me...

Raymond often comments on everything that looks strange or interesting 
to him, even if it's irrelevant to the actual problem. Don't worry.

>
>>>
>>>  1) I have the following hardware (alsa-info attached).
>>
>> Simple mixer control 'Input Source',0
>> Capabilities: cenum Items: 'Mic' 'Internal Mic' 'Mic 1'
>> Item0: 'Internal Mic'
>> Simple mixer control 'Input Source',1
>> Capabilities: cenum Items: 'Mic' 'Internal Mic' 'Mic 1'
>> Item0: 'Internal Mic'
>> Simple mixer control 'Input Source',2
>> Capabilities: cenum Items: 'Mic' 'Internal Mic' 'Mic 1'
>> Item0: 'Internal Mic'
>>
>>
>> using hda-emu
>>
>> the driver always use selector 0x17 for the three input source controls
>>
>> 6 Input Source:0
>> ITEM: 0:Mic, 1:Mic 1, 2:Internal Mic, VAL: [Mic]
>>> set 6 2
>> send: NID=0x14, VERB=0x701(set_connect_sel), PARM=0x0
>> receive: 0x0
>> send: NID=0x17, VERB=0x701(set_connect_sel), PARM=0x3
>> receive: 0x0
>>> set 7 2
>> send: NID=0x15, VERB=0x701(set_connect_sel), PARM=0x0
>> receive: 0x0
>> send: NID=0x17, VERB=0x701(set_connect_sel), PARM=0x3
>> receive: 0x0
>>> set 8 2
>> send: NID=0x16, VERB=0x701(set_connect_sel), PARM=0x0
>> receive: 0x0
>> send: NID=0x17, VERB=0x701(set_connect_sel), PARM=0x3
>> receive: 0x0
>>
>> It is a bug of the driver to create three input source select 
>> controls when
>> there are only two audio selectors 0x17 and 0x18 as node 0x23 is not 
>> one of
>> the input pins
>>
>> The topology does not allow three different input sources with two 
>> selectors
>
> Ok so the that makes sense but I'm not sure what you want me to do 
> about it.

This indeed looks like a driver bug, but let's figure out the hardware 
first.

>
>>
>>  >  2) The internal microphone requires that the mic boost channel be
>> something other than 0 to function properly.
>>
>> You have to find out whether node 0x1a or 0x1b can be used as the 
>> headset
>> jack (headphone with Mic using TRRS connector)
>
> So basically I need to plug a microphone into each port and figure out 
> if both of them work as microphone. A couple things.
>
> 1) What if both can be a microphone?
> 2) If only one can be a microphone, I have no idea how to tell you if 
> its 0x1a or 0x1b.. hda-analyzer/alsa low level stuff is completely new 
> to me.

When you plug something in, you can look at the output of "amixer -D 
hw:<cardname> contents" to see what, if anything switched to "values=on" 
instead of "values=off".

We would like you to plug a mic into the mic jack and see in what way 
the output of "amixer -D hw:<cardname> contents" changes.
Then we would like you to plug a headset (with both headphone and mic, 
like most smartphones have), and again see if there's a difference in 
amixer.
You can also try this with a headphone only in the headphone jack, if 
you like.

>
>>
>>>  3) Changing what pulseaudio expects things to be labelled causes the
>> problem to go away. (via the attached patch to
>> /usr/share/pulseaudio/paths/analog-input-mic.conf).
>>>
>>>   From the discussion with David Henningsson (diwic on IRC). It seems
>> that pulse doesn't expect a Mic Boost channel to be used with internal
>> microphones. As such to fix this particular hardware, the driver 
>> would need
>> to make the internal mic boost be labelled "Internal Mic Boost" as 
>> opposed
>> to Mic Boost, which is then is used for both external and internal mics.
>>>
>>
>> Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>> Control: name="Capture Volume", index=0, device=0 ControlAmp: chs=3,
>> dir=In, idx=0, ofs=0
>> Control: name="Capture Switch", index=0, device=0 ControlAmp: chs=3,
>> dir=In, idx=0, ofs=0
>> Device: name="CX20588 Analog", type="Audio", device=0 Amp-In caps:
>> ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>> Amp-In vals: [0x50 0x50] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>> Converter: stream=4, channel=0 SDI-Select: 0
>> PCM: rates [0x160]: 44100 48000 96000
>> bits [0xe]: 16 20 24
>> formats [0x1]: PCM
>> Power states: D0 D1 D2 D3 D3cold EPSS Power: setting=D0, actual=D0
>> Connection: 4
>> 0x17* 0x18 0x23 0x24
>>
>> Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
>> Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
>> Amp-In vals: [0x00 0x00] [0x00 0x00]
>> Power states: D0 D1 D2 D3 D3cold EPSS
>> Power: setting=D0, actual=D0
>> Connection: 2
>> 0x10 0x11
>>
>> BTW there seem to be an audio path from DAC to ADC throungh audio mixer
>> 0x24, does this allow you to record the DAC playback directly ? Using
>> hda-analyzer to change the selection of  audio input node 0x14 and 
>> fix the
>> amps at node 0x24
>
> I have no idea what DAC to ADC means. If you want me to do something 
> to test I can do that.

This is completely irrelevant to your problem.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
