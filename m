From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Internal Mic Boost channel is unused
Date: Sat, 14 Sep 2013 12:14:10 +0800
Message-ID: <CAN8cciYg90mZHn_vzJAJW26TF+qUEXej+XGztmC=+JZ_h53n-w@mail.gmail.com>
References: <5231E348.8020204@gnat.ca>
	<52333782.9070402@gnat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id DBB9A261AA7
 for <alsa-devel@alsa-project.org>; Sat, 14 Sep 2013 06:14:13 +0200 (CEST)
Received: by mail-ie0-f171.google.com with SMTP id at1so4234441iec.16
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 21:14:11 -0700 (PDT)
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>
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
>> hda-analyzer to change the selection of  audio input node 0x14 and fix the
>> amps at node 0x24
>>
>
> I have no idea what DAC to ADC means. If you want me to do something to
> test I can do that.
>
>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio.txt


hints::
  Shows / stores hint strings for codec parsers for any use.
  Its format is `key = value`.  For example, passing `jack_detect = no`
  will disable the jack detection of the machine completely.


Hint Strings
~~~~~~~~~~~~
The codec parser have several switches and adjustment knobs for
matching better with the actual codec or device behavior.  Many of
them can be adjusted dynamically via "hints" strings as mentioned in
the section above.  For example, by passing `jack_detect = no` string
via sysfs or a patch file, you can disable the jack detection, thus
the codec parser will skip the features like auto-mute or mic
auto-switch.  As a boolean value, either `yes`, `no`, `true`, `false`,
`1` or `0` can be passed.

The generic parser supports the following hints:

- add_stereo_mix_input (bool): add the stereo mix (analog-loopback
  mix) to the input mux if available
- mixer_nid (int): specifies the widget NID of the analog-loopback
  mixer

specify hints



mixer_nid = 0x24
add_stereo_mix_input = true


> get 6
6 Input Source:0
ITEM: 0:Mic, 1:Mic 1, 2:Internal Mic, 3:Stereo Mix, VAL: [Mic]
> set 6 3
send: NID=0x14, VERB=0x701(set_connect_sel), PARM=0x3
receive: 0x0
send: NID=0x24, VERB=0x360(set_amp_gain_mute,I:L#0), PARM=0x4a
receive: 0x0
send: NID=0x24, VERB=0x350(set_amp_gain_mute,I:R#0), PARM=0x4a
receive: 0x0
