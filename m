From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: S/PDIF support for Intel HDA Realtek ALC880?
Date: Wed, 15 Nov 2006 10:37:35 +1030 (CST)
Message-ID: <200611150007.kAF07Z7L018650@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

I am forwarding the following message I received privately to the list
for others to comment on.  I am not an ALC880 expert and so my ability to
assist is greatly diminished.

Regards
  jonathan

Forwarded message:

> Subject: S/PDIF support for Intel HDA Realtek ALC880?
> From: "Peter Carlsson" <peter.carlsson@space.se>
> 
> Hello!
> 
> I am running Debian (testing) on a Gigabyte GA-K8N51PVMT-9
> motherboard with integrated Intel HDA Realtek ALC880 sound.
> On the motherboard is also a connector for S/PDIF where I
> have attached a back plate. I am using ALSA 1.0.13.
> 
> Could you please tell me if S/PDIF is supported for this
> configuration and if so, how can I enable it?
> 
> Below you will find some output if that might help.
> 
> Best regards,
> Peter Carlsson
> 
> htpc:~# aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: NVidia [HDA NVidia], device 0: ALC880 Analog [ALC880 Analog]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> htpc:~#
> 
> htpc:~# aplay -L
> PCM list:
> hw {
>          @args.0 CARD
>          @args.1 DEV
>          @args.2 SUBDEV
>          @args.CARD {
>                  type string
>                  default {
>                          @func getenv
>                          vars {
>                                  0 ALSA_PCM_CARD
>                                  1 ALSA_CARD
>                          }
>                          default {
>                                  @func refer
>                                  name 'defaults.pcm.card'
>                          }
>                  }
>          }
>          @args.DEV {
>                  type integer
>                  default {
>                          @func igetenv
>                          vars {
>                                  0 ALSA_PCM_DEVICE
>                          }
>                          default {
>                                  @func refer
>                                  name 'defaults.pcm.device'
>                          }
>                  }
>          }
>          @args.SUBDEV {
>                  type integer
>                  default {
>                          @func refer
>                          name 'defaults.pcm.subdevice'
>                  }
>          }
>          type hw
>          card $CARD
>          device $DEV
>          subdevice $SUBDEV
> }
> plughw {
>          @args.0 CARD
>          @args.1 DEV
>          @args.2 SUBDEV
>          @args.CARD {
>                  type string
>                  default {
>                          @func getenv
>                          vars {
>                                  0 ALSA_PCM_CARD
>                                  1 ALSA_CARD
>                          }
>                          default {
>                                  @func refer
>                                  name 'defaults.pcm.card'
>                          }
>                  }
>          }
>          @args.DEV {
>                  type integer
>                  default {
>                          @func igetenv
>                          vars {
>                                  0 ALSA_PCM_DEVICE
>                          }
>                          default {
>                                  @func refer
>                                  name 'defaults.pcm.device'
>                          }
>                  }
>          }
>          @args.SUBDEV {
>                  type integer
>                  default {
>                          @func refer
>                          name 'defaults.pcm.subdevice'
>                  }
>          }
>          type plug
>          slave.pcm {
>                  type hw
>                  card $CARD
>                  device $DEV
>                  subdevice $SUBDEV
>          }
> }
> plug {
>          @args.0 SLAVE
>          @args.SLAVE {
>                  type string
>          }
>          type plug
>          slave.pcm $SLAVE
> }
> shm {
>          @args.0 SOCKET
>          @args.1 PCM
>          @args.SOCKET {
>                  type string
>          }
>          @args.PCM {
>                  type string
>          }
>          type shm
>          server $SOCKET
>          pcm $PCM
> }
> tee {
>          @args.0 SLAVE
>          @args.1 FILE
>          @args.2 FORMAT
>          @args.SLAVE {
>                  type string
>          }
>          @args.FILE {
>                  type string
>          }
>          @args.FORMAT {
>                  type string
>                  default raw
>          }
>          type file
>          slave.pcm $SLAVE
>          file $FILE
>          format $FORMAT
> }
> file {
>          @args.0 FILE
>          @args.1 FORMAT
>          @args.FILE {
>                  type string
>          }
>          @args.FORMAT {
>                  type string
>                  default raw
>          }
>          type file
>          slave.pcm null
>          file $FILE
>          format $FORMAT
> }
> null {
>          type null
> }
> cards 'cards.pcm'
> front 'cards.pcm.front'
> rear 'cards.pcm.rear'
> center_lfe 'cards.pcm.center_lfe'
> side 'cards.pcm.side'
> surround40 'cards.pcm.surround40'
> surround41 'cards.pcm.surround41'
> surround50 'cards.pcm.surround50'
> surround51 'cards.pcm.surround51'
> surround71 'cards.pcm.surround71'
> iec958 'cards.pcm.iec958'
> spdif 'cards.pcm.iec958'
> modem 'cards.pcm.modem'
> phoneline 'cards.pcm.phoneline'
> default 'cards.pcm.default'
> dmix 'cards.pcm.dmix'
> dsnoop 'cards.pcm.dsnoop'
> htpc:~#
> 
> htpc:~# cat /proc/asound/NVidia/codec#0
> Codec: Realtek ALC880
> Address: 0
> Vendor Id: 0x10ec0880
> Subsystem Id: 0x1458f603
> Revision Id: 0x100800
> Default PCM: rates 0x560, bits 0x0e, types 0x1
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x02 [Audio Output] wcaps 0x411: Stereo
>    PCM: rates 0x560, bits 0x0e, types 0x1
>    Power: 0x0
> Node 0x03 [Audio Output] wcaps 0x411: Stereo
>    PCM: rates 0x560, bits 0x0e, types 0x1
>    Power: 0x0
> Node 0x04 [Audio Output] wcaps 0x411: Stereo
>    PCM: rates 0x160, bits 0x0e, types 0x1
>    Power: 0x0
> Node 0x05 [Audio Output] wcaps 0x411: Stereo
>    PCM: rates 0x160, bits 0x0e, types 0x1
>    Power: 0x0
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>    PCM: rates 0x160, bits 0x1e, types 0x1
> Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>    Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
>    Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
> 0x00=
> ] [0x00 =
> 
> 0x00] [0x00 0x00]
>    PCM: rates 0x160, bits 0x06, types 0x1
>    Power: 0x0
>    Connection: 7
>       0x18 0x19 0x1a 0x1b 0x1c* 0x14 0x15
> Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>    Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
>    Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
> 0x00=
> ] [0x00 =
> 
> 0x00] [0x00 0x00]
>    PCM: rates 0x160, bits 0x06, types 0x1
>    Power: 0x0
>    Connection: 7
>       0x18 0x19 0x1a* 0x1b 0x1c 0x14 0x15
> Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>    Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
>    Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
> 0x00=
> ] [0x00 =
> 
> 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>    PCM: rates 0x160, bits 0x06, types 0x1
>    Power: 0x0
>    Connection: 10
>       0x18* 0x19 0x1a 0x1b 0x1c 0x0b 0x14 0x15 0x16 0x17
> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>    PCM: rates 0x160, bits 0x1e, types 0x1
>    Connection: 1
>       0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>    Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
>    Amp-In vals:  [0x80 0x80] [0x31 0x31] [0x80 0x80] [0x00 0x00] [0x31
> 0x31=
> ] [0x31 =
> 
> 0x31] [0xa3 0xa3] [0xa3 0xa3]
>    Connection: 8
>       0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>    Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-In vals:  [0x00 0x00] [0x00 0x00]
>    Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>    Amp-Out vals:  [0x3d 0x3d]
>    Connection: 2
>       0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>    Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-In vals:  [0x80 0x80] [0x80 0x80]
>    Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>    Amp-Out vals:  [0x30 0x30]
>    Connection: 2
>       0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>    Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-In vals:  [0x00 0x00] [0x00 0x00]
>    Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>    Amp-Out vals:  [0x30 0x2e]
>    Connection: 2
>       0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>    Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-In vals:  [0x80 0x80] [0x80 0x80]
>    Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
>    Amp-Out vals:  [0x00 0x00]
>    Connection: 2
>       0x05 0x0b
> Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
>    Connection: 4
>       0x0c* 0x0d 0x0e 0x0f
> Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
>    Connection: 4
>       0x0c* 0x0d 0x0e 0x0f
> Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
>    Connection: 4
>       0x0c* 0x0d 0x0e 0x0f
> Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
>    Connection: 4
>       0x0c* 0x0d 0x0e 0x0f
> Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x00 0x00]
>    Pincap 0x083f: IN OUT HP
>    Pin Default 0x01014410: [Jack] Line Out at Ext Rear
>      Conn = 1/8, Color = Green
>    Pin-ctls: 0x40: OUT
>    Connection: 1
>       0x0c
> Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x00 0x00]
>    Pincap 0x083f: IN OUT HP
>    Pin Default 0x01016412: [Jack] Line Out at Ext Rear
>      Conn = 1/8, Color = Orange
>    Pin-ctls: 0x40: OUT
>    Connection: 1
>       0x0d
> Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x00 0x00]
>    Pincap 0x083f: IN OUT HP
>    Pin Default 0x01011011: [Jack] Line Out at Ext Rear
>      Conn = 1/8, Color = Black
>    Pin-ctls: 0x40: OUT
>    Connection: 1
>       0x0e
> Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x00 0x00]
>    Pincap 0x083f: IN OUT HP
>    Pin Default 0x01012014: [Jack] Line Out at Ext Rear
>      Conn = 1/8, Color = Grey
>    Pin-ctls: 0x40: OUT
>    Connection: 1
>       0x0f
> Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x80 0x80]
>    Pincap 0x08133f: IN OUT HP
>    Pin Default 0x01a19c40: [Jack] Mic at Ext Rear
>      Conn = 1/8, Color = Pink
>    Pin-ctls: 0x24: IN
>    Connection: 1
>       0x10
> Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x80 0x80]
>    Pincap 0x08133f: IN OUT HP
>    Pin Default 0x02a19c50: [Jack] Mic at Ext Front
>      Conn = 1/8, Color = Pink
>    Pin-ctls: 0x24: IN
>    Connection: 1
>       0x11
> Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x80 0x80]
>    Pincap 0x08133f: IN OUT HP
>    Pin Default 0x01813441: [Jack] Line In at Ext Rear
>      Conn = 1/8, Color = Blue
>    Pin-ctls: 0x20: IN
>    Connection: 1
>       0x12
> Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>    Amp-Out vals:  [0x00 0x00]
>    Pincap 0x08133f: IN OUT HP
>    Pin Default 0x02214c20: [Jack] HP Out at Ext Front
>      Conn = 1/8, Color = Green
>    Pin-ctls: 0xc0: OUT HP
>    Connection: 1
>       0x13
> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>    Pincap 0x0820: IN
>    Pin Default 0x99331142: [Fixed] CD at Int ATAPI
>      Conn = ATAPI, Color = Black
>    Pin-ctls: 0x00:
> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>    Pincap 0x0820: IN
>    Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>      Conn = 1/8, Color = Black
>    Pin-ctls: 0x00:
> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>    Pincap 0x0810: OUT
>    Pin Default 0x99431130: [Fixed] SPDIF Out at Int ATAPI
>      Conn = ATAPI, Color = Black
>    Pin-ctls: 0x00:
>    Connection: 1
>       0x06
> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>    Pincap 0x0820: IN
>    Pin Default 0x99c31160: [Fixed] SPDIF In at Int ATAPI
>      Conn = ATAPI, Color = Black
>    Pin-ctls: 0x00:
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
> htpc:~#

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
