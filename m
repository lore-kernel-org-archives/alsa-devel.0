From: Rafal Maszkowski <rzm@icm.edu.pl>
Subject: Re: HDA Intel on V3505
Date: Thu, 18 Jan 2007 12:10:43 +0100
Message-ID: <20070118111043.GA19869@delta.icm.edu.pl>
References: <20070109231049.GW2271@delta.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070109231049.GW2271@delta.icm.edu.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wonder how could I get help on issues described below. Sound works only
partially, the modem is recognized but does not work. Should I try to describe
the issues better or enter a report into some bugzilla?

R.

On Wed, Jan 10, 2007 at 12:10:49AM +0100, Rafal Maszkowski wrote:
> I use Fujitsu-Siemens Amilo Pro V3505 with 
> 
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
> 
> It has two codecs:
> 
> Codec: Realtek ALC861
> 
> Codec: Motorola Si3054
> Vendor Id: 0x10573055
> 
> (a half-modem really).
> 
> I started with kernel-2.6.18-1.2869.fc6 of Fedora 6 (alsa 1.0.12). I was able to play sound
> but input, recording and modem were not working properly (modem was not visible at all).
> 
> With recent hg sources all this works as follows:
> 
> MODEM:
> 
> rzm@rzm-ab:~,0# cat /proc/asound/card0/codec#1
> Codec: Motorola Si3054
> Address: 1
> Vendor Id: 0x10573055
> Subsystem Id: 0x10573055
> Revision Id: 0x100700
> rzm@rzm-ab:~,0# modprobe snd-intel8x0m
> rzm@rzm-ab:~,1# /root/V3505/dead-end/slmodem-2.9.11-20061021/modem/slmodemd -a -c POLAND -d 4 modem:0
> SmartLink Soft Modem: version 2.9.11 Jan  6 2007 19:21:07
> <478.906438> SmartLink Soft Modem: version 2.9.11 Jan  6 2007 19:21:07
> <478.906494> modem:0: startup modem...
> <478.906814> modem:0: update termios...
> symbolic link `/dev/ttySL0' -> `/dev/pts/5' created.
> modem `modem:0' created. TTY is `/dev/pts/5'
> <478.908339> open file: /var/lib/slmodem/data.modem:0...
> <478.965975> main: rt applyed: SCHED_FIFO, pri 99
> Use `/dev/ttySL0' as modem device, Ctrl+C for termination.
> <519.422951> main: termios changed.
> <519.422981> modem:0: update termios...
> <535.201913> modem:0: run cmd: atdt0w202122
> <535.201947> modem:0: modem dial: t0w202122...
> <535.201961> modem:0: modem_dial_start...
> <535.201974> call: create...
> <535.201992> CallProgFP_Create >>
> <535.202004> APPLY_FILTER = 0
> <535.202018> Detection Thresholds: levle_fix=45,--> LEVEL_THRESHOLD=90
> <535.202032> ============> 0
> <535.202044> Cadence: Busy Tone loose detection is 0
> <535.202059> TYPE BUSY
> <535.202071> Filter index 0
> <535.202082> Filter SubIndex 0
> <535.202094> MAX_ON_TIME 30 Buffers     MIN_ON_TIME 5 Buffers
> <535.202106> MAX_OFF_TIME 30 Buffers    MIN_OFF_TIME 5 Buffers
> <535.202119> OFF_TIME_THAT_RESETS_CYCLE 90
> <535.202131> BUFFER LENGTH 160 samples.
> <535.202143> INTEGRATION_LENGTH 0[ms]
> <535.202155> LEVEL 90
> <535.202171> INTEGRATION_TIME = 0 Buffers.
> <535.202185> Detection Thresholds: levle_fix=45,--> LEVEL_THRESHOLD=90
> <535.202200> TYPE DIAL
> <535.202211> Filter index 5
> <535.202223> Filter SubIndex 0
> <535.202234> MAX_ON_TIME 0 Buffers     MIN_ON_TIME 0 Buffers
> <535.202246> MAX_OFF_TIME 0 Buffers    MIN_OFF_TIME 0 Buffers
> <535.202259> OFF_TIME_THAT_RESETS_CYCLE 0
> <535.202271> BUFFER LENGTH 666 samples.
> <535.202283> INTEGRATION_LENGTH 800[ms]
> <535.202294> LEVEL 90
> <535.202308> INTEGRATION_TIME = 8 Buffers.
> <535.202323> CALLPROG Create <<
> <535.202335> CALLPROG Dialing t0w202122
> <535.202348> Configuration->tone_DigitLength 100
> <535.202360> Configuration->pulse_OffHookTime 33
> <535.202372> Configuration->pulse_OnHookTime 67
> <535.202384> Configuration->dialPauseTime 4
> <535.202396> Configuration->flashTime 9
> <535.202408> Configuration->toneOrPulseFlag 0
> <535.202420> Configuration->dialModifierValidationFlag 1
> <535.202432> Configuration->ABCD_PermittedFlag 0
> <535.202444> Configuration->pulseAndToneInSameStringPermittedFlag 0
> <535.202456> Configuration->callingToneFlag 0
> <535.202468> Configuration->commaPauseDurLimit 30
> <535.202480> Configuration->digitPattern 1
> <535.202492> Configuration->tone_BetweenDigitsInterval 100
> <535.202504> Configuration->pulse_BetweenDigitsInterval 800
> <535.202516> DTMF_Gain1 = 13014
> <535.202528> DTMF_Gain2 = 16384
> <535.202541> AnalyzeDialString: Updated 17 May 1999 00:50
> <535.202553> AnalyzeDialString: LAST_DIALABLE_SYMBOL is 8
> <535.202565> Dial String Syntax is VALID
> <535.202580> GetNoAnswerTimeOut. 60
> <535.202593> WAIT DIAL TIMEOUT = 4
> <535.202605> CALLPROG_Dial was exited.
> <535.202616> call: create RC: 9600 <-> 8000...
> <535.202633> modem:0: modem_start..
> <535.202645> modem:0: modem set state: 1 --> 2...
> <535.202659> modem:0: new state: DP_ESTAB
> <535.202672> main: alsa_ioctl: cmd 8, arg 3...
> <535.202685> modem:0: modem set hook: 0 --> 1...
> <535.202697> main: alsa_ioctl: cmd 2, arg 1...
> <535.203833> main: alsa_ioctl: cmd 11, arg 0...
> <535.204067> main: alsa_ioctl: cmd 4, arg 2580...
> <535.204084> main: alsa_ioctl: cmd 7, arg 30...
> <535.204097> main: alsa_start...
> error: cannot setup hw params for playback: Invalid argument
> <535.205906> err: modem:0: modem start = -22: cannot start device.
> <535.205922> modem:0: modem_stop..
> <535.205934> modem:0: modem set hook: 1 --> 0...
> <535.205947> main: alsa_ioctl: cmd 2, arg 0...
> <535.207825> main: alsa_ioctl: cmd 8, arg 0...
> <535.207846> call: delete...
> <535.207860> Dialer was aborted.
> <535.207871> CALLPROG_Delete is entered
> <535.207883> cadence_delete with CADENCE_DIAL_OBJ is invoked
> <535.207896> cadence_delete with CADENCE_OBJ is invoked
> <535.207908> CALLPROG_Delete is exited
> <535.207922> modem:0: modem set state: 2 --> 1...
> <535.207936> modem:0: new state: MODEM_IDLE
> <535.207948> modem:0: modem report result: 3 (NO CARRIER)
> <535.207976> modem:0: modem report result: 4 (ERROR)
> <544.892326> main: termios changed.
> <544.892355> modem:0: update termios...
> <544.892382> main: pty closed.
> 
> The above log shows an attempt to dial:
> 
> rzm@rzm-ab:~,0# cu -l /dev/ttySL0 -s 115200
> Connected.
> atdt0w202122
> NO CARRIER
> ERROR
> ~.
> Disconnected.
> 
> dmesg shows:
> ALSA /usr/src/sound/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1153: hda-intel: invalid format_val, rate=9600, ch=1, format=2
> 
> SOUND:
> 
> dmesg:
> hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> ALSA /usr/src/sound/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:556: hda_intel: azx_get_response timeout, switching to polling mode...
> 
> alsamixer:
> +---------------------------------------------------[AlsaMixer v1.0.12 (Press Escape to quit)]----------------------------------------------------+
> | Card: HDA Intel                                                                                                                                 |
> | Chip: Realtek ALC861                                                                                                                            |
> | View:  Playback  Capture [All]                                                                                                                  |
> | Item: Capture [dB gain=-6.00, -6.00]                                                                                                            |
> ...
> |                                +--+               +--+               +--+                                                                       |
> ...
> |             +--+               +--+               +--+               +--+               +--+               Mic                +--+              |
> |             |OO|               |MM|               |MM|                                  |MM|                                  |MM|              |
> |             +--+               +--+               +--+              L    R              +--+                                  +--+              |
> |                                                                     CAPTUR                                                                      |
> |                                0<>0               0<>0               0<>0                                                                       |
> |            Front             Front Mi             Mic             <Capture >          Caller I           Input So           Off-hook            |
> ...
> +-------------------------------------------------------------------------------------------------------------------------------------------------+
> 
> There is no PCM slider.
> 
> The other possible input source is Front Mic.
> 
> Playing works. Recording works - I have not checked yet what is really
> recorded.
> 
> Listening to the sounds coming from the input: THe line input and built in
> microphone are mixed. Volume of this mixture can be regulated with Front Mic or
> Mic regulation. Each of them takes over the level, i.e. when one of them is set
> to lower level setting the other set the sound level. When the second one is
> left at high level moving the first even slightly sets the level (to this lower
> value).
> 
> rzm@rzm-ab:~,0# cat /proc/asound/card0/codec#0
> Codec: Realtek ALC861
> Address: 0
> Vendor Id: 0x10ec0861
> Subsystem Id: 0x17c01205
> Revision Id: 0x100300
> Default PCM:
>     rates [0x140]: 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Power: 0x0
> Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x80 0x80]
>   Power: 0x0
> Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x80 0x80]
>   Power: 0x0
> Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x80 0x80]
>   Power: 0x0
> Node 0x07 [Audio Output] wcaps 0x605: Stereo Digital Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x00 0x00]
>   Power: 0x0
> Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x02, nsteps=0x0d, stepsize=0x0b, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   PCM:
>     rates [0x140]: 48000 96000
>     bits [0x2]: 16
>     formats [0x1]: PCM
>   Power: 0x0
>   Connection: 6 
>      0x0d* 0x0c 0x0f 0x10 0x11 0x15
> Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x081f: OUT HP Detect
>   Pin Default 0x01014110: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 1 
>      0x16
> Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0837: IN OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
>   Power: 0x0
>   Connection: 1 
>      0x19
> Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x08337: IN OUT Detect
>   Pin Default 0x01a19c2e: [Jack] Mic at Ext Rear
>     Conn = 1/8, Color = Pink
>   Pin-ctls: 0x24: IN
>   Power: 0x0
>   Connection: 1 
>      0x18
> Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0817: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 1 
>      0x19
> Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0833f: IN OUT HP Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 1 
>      0x1a
> Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0833f: IN OUT HP Detect
>   Pin Default 0x99a30120: [Fixed] Mic at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x24: IN
>   Power: 0x0
>   Connection: 1 
>      0x1b
> Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0863: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
> Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 1 
>      0x07
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x0d 0x10  
> Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x00 0x00]
>   Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
>   Amp-Out vals:  [0x0c 0x0c]
>   Power: 0x0
>   Connection: 3 
>      0x11 0x14 0x1c
> Node 0x16 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x03 0x15  
> Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x04 0x15  
> Node 0x18 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x05 0x15  
> Node 0x19 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x06 0x15  
> Node 0x1a [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x00 0x00]
>   Connection: 4 
>      0x04 0x06 0x15 0x03
> Node 0x1b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x00 0x00]
>   Connection: 4 
>      0x04 0x06 0x15 0x03
> Node 0x1c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Connection: 2 
>      0x0c 0x0f  
> Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1f [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0817: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 1 
>      0x18
> Node 0x20 [Pin Complex] wcaps 0x400581: Stereo
>   Pincap 0x0817: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 1 
>      0x17
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
>   Amp-Out vals:  [0x8f]

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
