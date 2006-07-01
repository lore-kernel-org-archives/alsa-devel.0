From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: ASUS M2N32 MCP55 HDAudio problems - small solution!
Date: Sat, 01 Jul 2006 11:36:31 +0200
Message-ID: <44A6421F.9020307@dschroeder.info>
References: <44A19885.8020104@dschroeder.info>	<s5hwtb1qp16.wl%tiwai@suse.de>	<44A2F28C.509@dschroeder.info>	<s5h64ikce22.wl%tiwai@suse.de>	<44A41EBF.2040308@dschroeder.info>
	<s5hpsgr9cra.wl%tiwai@suse.de>
Reply-To: sec@dschroeder.info
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsgr9cra.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 29 Jun 2006 20:41:03 +0200,
> Daniel Schroeder wrote:
>>>> --------------------------
>>>> headphone jack in front: if connected the regular sound isnt muted.
>>>> --------------------------
>>>> speaker test hangs in surround51 configuration:
>>>>
>>>> speaker-test -Dplug:surround51 -c6
>>>>
>>>> speaker-test 1.0.12rc1
>>>>
>>>> Playback device is plug:surround51
>>>> Stream parameters are 48000Hz, S16_LE, 6 channels
>>>> Using 16 octaves of pink noise
>>>> Rate set to 48000Hz (requested 48000Hz)
>>>> Buffer size range from 22 to 5461
>>>> Period size range from 11 to 2730
>>>> Using max buffer size 5460
>>>> Periods = 4
>>>> was set period_size = 1365
>>>> was set buffer_size = 5460
>>>>  0 - Front Left
>>>> ---- hangs forever
>>> That's bad.  Does aplay with 6 channel samples work fine?
>> while true;  do aplay chan-id.wav ; done
>> Playing WAVE 'chan-id.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
>> Channels 6
>>
>>
>> aplay with 6 channel sample works but only front left / front right the
>> other "tracks" in the file are "silent".
>> Output of front left and front right are: front left all speakers to the
>> left. front left/rear left/center with output of channel "front right"
>> all speakers to the right "front right/rear right/subwoofer"
> 
> So, it doesn't hang up, right?  Then maybe the buffer/period setting
> influences on behavior of speaker-test...
> 
> 
>>>> ----------------------------
>>>> speaker-test in surround40
>>>>
>>>> front left=sound output rear left;
>>>> front right=sound output rear right;
>>>> rear right=sound output subwoofer
>>>> rear left=sound output center
>>> So the channels are shifted.
>>>
>>> When you play with 2-channel via "aplay foo.wav", do the samples come
>>> from front speakers?
>> aplay 10.wav
>> Playing WAVE 10.wav : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>>
>> sound comes through all speakers, front left/front right/rear left/rear
>> right/center and subwoofer
> 
> OK, that's default behavior of the driver.  All left/right are spread
> to rear and CLFE.
> 
> 
>>> As you might have noticed in the kernel message, there is a workaround
>>> for AD1988A rev2 codec.  You can disable it by re-defining
>>> AD1988A_REV2 in patch_analog.c to a bogus value, for example, a patch
>>> like below.  Then try the tests again.
>>>
>>>
>>> Takashi
>>>
>>> diff -r ac7516b5dcb9 pci/hda/patch_analog.c
>>> --- a/pci/hda/patch_analog.c	Thu Jun 29 13:22:29 2006 +0200
>>> +++ b/pci/hda/patch_analog.c	Thu Jun 29 14:58:36 2006 +0200
>>> @@ -1543,7 +1543,8 @@ enum {
>>>  };
>>>  
>>>  /* reivision id to check workarounds */
>>> -#define AD1988A_REV2		0x100200
>>> +// #define AD1988A_REV2		0x100200
>>> +#define AD1988A_REV2		0xabcd1234 /* bogus */
>>>  
>>>  
>>>  /*
>> i have patched the file patch_analog.c recompiled and loaded the module.
>> same bad behaviour. Im sure that he has taken the new module because the
>> dmesg output is missing.
>>
>> ----
>>
>> have you any clues of what i could do? This stuff is a bit mysterious
>> for me. Why does he play a stereo wav file to all speakers. And why does
>> he plays only two channels of the surround file (chan-id.wav) and these
>> two channels getting splitted to every left speaker / every right speaker...
> (snip)
>> now the missing audio channel is there and it seems to me that this
>> movie is fully working in surround!
>> This bogus patch seems to work :)
> 
> It disables the workaround for AD1988A rev2.  According to AD, this
> codec revision has a h/w bug, so I implemented the workaround as they
> suggested.
> 
> Could you attach the content of /proc/asound/card0/codec#* files?
> Is it really AD1988A, not AD1988B?
> 
> 
> Takashi

It is a AD1988B

small summary:

 - out of the box 1.0.12_rc1 recognize my chip as a AD1988A rev.2 ->
seems to be wrong.

 - with the "bogus patch" mplayer is working.

 -  Speaker-Test and aplay are "buggy" or not working as i would expect...

 - hp jack does not mute the other speakers

 - normal amarok output is a kind of too center/lfe centric (the winamp
output under windows has a much better sound)

 - i miss a "rear" volume slider in kmix

cat /proc/asound/card0/codec#0
Codec: Analog Devices AD1988B
Address: 0
Vendor Id: 0x11d4198b
Subsystem Id: 0x104381f6
Revision Id: 0x100200
Default PCM: rates 0x7ff, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
  Connection: 1
     0x1d
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x27 0x27]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x24 0x24]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x10 0x0c]
  Power: 0x0
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x10 0x10]
  Power: 0x0
Node 0x07 [Audio Input] wcaps 0x130391: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
  Connection: 1
     0x1c
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x0d
Node 0x0a [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x14 0x14]
  Power: 0x0
Node 0x0b [Audio Selector] wcaps 0x300301: Stereo Digital
  Connection: 3
     0x08* 0x09 0x0f
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0f [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x0e
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x00]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08373f: IN OUT HP Detect
  Pin Default 0x02214130: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x22
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081373f: IN OUT HP EAPD Detect
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x29
Node 0x13 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x511711f0: [N/A] Speaker at Int Rear
    Conn = Analog, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x2d
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08373f: IN OUT HP Detect
  Pin Default 0x02a19122: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x2b
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0813737: IN OUT EAPD Detect
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x2c
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083737: IN OUT Detect
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x2a
Node 0x17 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083737: IN OUT Detect
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x26
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x9933112e: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x20: IN
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power: 0x0
  Connection: 2
     0x20* 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x99f301f0: [Fixed] Other at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x0810: OUT
  Pin Default 0x0145f1f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:
  Pincap 0x0820: IN
  Pin Default 0x41c5f1f0: [N/A] SPDIF In at Ext Rear
    Conn = Optical, Color = Other
  Pin-ctls: 0x20: IN
Node 0x1d [Audio Mixer] wcaps 0x200303: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x01 0x0b
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x36 0x21
Node 0x1f [Volume Knob Widget] wcaps 0x600080: Mono
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 8
     0x39 0x33 0x38 0x3d 0x34 0x3b 0x18 0x1a
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x20
Node 0x22 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x37 0x21
Node 0x23 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 18
     0x11* 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x24 0x25 0x38 0x39 0x3a
0x3b 0x3c 0x3d 0x20 0x21
Node 0x24 [Pin Complex] wcaps 0x40098d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x27
Node 0x25 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x01012013: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x28
Node 0x26 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x32 0x21
Node 0x27 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x05 0x21
Node 0x28 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x0a 0x21
Node 0x29 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x04 0x21
Node 0x2a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x06 0x21
Node 0x2b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x30 0x21
Node 0x2c [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x31 0x21
Node 0x2d [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x2e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x2f [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 6
     0x11* 0x12 0x14 0x15 0x16 0x17
Node 0x30 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03* 0x04 0x06
Node 0x31 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x0a
Node 0x32 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x04
Node 0x33 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3a* 0x25 0x24
Node 0x34 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x3c* 0x25 0x24
Node 0x35 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x36 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03 0x04* 0x06
Node 0x37 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x03 0x04* 0x06
Node 0x38 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x11
Node 0x39 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x14
Node 0x3a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x15
Node 0x3b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x16
Node 0x3c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x17
Node 0x3d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x12

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
