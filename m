From: tony mancill <tony@mancill.com>
Subject: Re: Problems with hda-intel driver
Date: Wed, 20 Dec 2006 21:32:53 -0800
Message-ID: <458A1C85.5020704@mancill.com>
References: <1166566334.2082.15.camel@knc-se-lap0001.knorca.se>
	<1166567342.25873.140.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050606000103000308060606"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1166567342.25873.140.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050606000103000308060606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Tobin and Mathias,

Please excuse me for jumping into the middle of this thread, but I'm
experiencing the same problem on an Acer 5102 with this driver.

The requested debug information is attached; I am running 1.0.14rc1.

Thank you,
tony

Tobin Davis wrote:
> Need a little more information on this to proceed.  Could you send the
> output from the following commands:
> lspci -s 0:14.2 -vn
> cat /proc/asound/version
> cat /proc/asound/card0/codec*
> 
> These will give us more information to go on.
> 
> It's also possible that a newer version of alsa will fix your problems. 
> Try downloading alsa-driver-1.0.14rc1.tar.bz2 from the alsa-progject.org
> web site.
> 
> Tobin
> 
> 
> On Tue, 2006-12-19 at 23:12 +0100, Mathias Friman wrote:
>> Hi list.
>>
>> A friend of mine has an Acer 5100 Laptop which
>> has a hda-intel driver sound card. He cannot start
>> alsamixer, it errors out with:
>>
>> alsamixer: function snd_mixer_load failed: Invalid argument
>>
>> When the alsa-packages are reinstalled in Kubuntu, the
>> alsamixer works, but after a reboot it does not anymore.
>> The mic input is muted, or volume set to zero. The output
>> works though, but no levels can be adjusted due to the
>> alsamixer error.
>>
>> We've tried with:
>>
>> options snd_hda_intel model=acer position_fix=1
>>
>> in /etc/modprobe.d/alsa-base but that does not fix the
>> problem. 
>>
>> I haven't got enough knowledge about ALSA to take
>> this further, so I put my hope to you guys. Below are
>> some outputs that might be useful:
>>
>>
>>
>> # cat /proc/asound/cards
>>  0 [SB             ]: HDA-Intel - HDA ATI SB
>>                       HDA ATI SB at 0xd0000000 irq 209
>>
>> # lspci
>> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
>>
>> # amixer contents
>> numid=11,iface=MIXER,name='Headphone Playback Switch'
>>   ; type=BOOLEAN,access=rw---,values=2
>>   : values=on,on
>> numid=29,iface=MIXER,name='PCM Playback Volume'
>>   ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0
>>   : values=160,160
>> numid=4,iface=MIXER,name='Surround Playback Switch'
>>   ; type=BOOLEAN,access=rw---,values=2
>>   : values=off,off
>> amixer: Control default snd_hctl_elem_info error: Invalid argument
>>
>> # alsactl store
>> alsactl: get_control:149: Cannot read control info '2,0,0,Capture Volume,1': Invalid argument
>>
>>
>>
>> Hope this pins down the matter in some respect. :)
>>
>> Regards,
>> Mathias


--------------050606000103000308060606
Content-Type: text/plain;
 name="snd-hda-intel.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-hda-intel.txt"

$ sudo lspci -s 0:14.2 -vn
00:14.2 0403: 1002:437b (rev 01)
	Subsystem: 1025:009f
	Flags: bus master, slow devsel, latency 64, IRQ 225
	Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.14rc1.
Compiled on Dec 19 2006 for kernel 2.6.18-3-k7 (SMP).

$ cat /proc/asound/card0/codec*
Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x1025140d
Revision Id: 0x100002
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x80]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x19 0x19] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x80] [0x00 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x01011110: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x01a1993f: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x01814130: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330131: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x99830132: [Fixed] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x1025009f
Revision Id: 0x90000
Codec: Generic ffff ID ffff
Address: 3
Vendor Id: 0xffffffff
Subsystem Id: 0xffffffff
Revision Id: 0xffffffff
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x03 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x04 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x05 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x06 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x07 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x08 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x09 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0a [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0b [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0c [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0d [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0e [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x0f [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x10 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x11 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x12 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x13 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x14 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x15 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x16 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x17 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x18 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x19 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1a [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1b [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1c [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1d [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1e [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x1f [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x20 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x21 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x22 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x23 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x24 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x25 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0
    
Node 0x26 [Vendor Defined Widget] wcaps 0xffffffff: Stereo Digital Amp-In Amp-Out
  Amp-In caps: N/A
  Amp-In vals: 
  Amp-Out caps: N/A
  Amp-Out vals:  [0xffffffff 0xffffffff]
  Power: 0xffffffff
  Connection: 0

--------------050606000103000308060606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050606000103000308060606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------050606000103000308060606--
