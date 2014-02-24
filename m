From: Jay Fenlason <fenlason@redhat.com>
Subject: Re: [RFC v3] [PATCH 00/52] Enhancement for support of firewire devices
Date: Mon, 24 Feb 2014 12:28:47 -0500
Message-ID: <20140224172846.GA880@redhat.com>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
	<20140221165444.GA25817@redhat.com>
	<53080CB3.9000504@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <53080CB3.9000504@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 22, 2014 at 11:34:27AM +0900, Takashi Sakamoto wrote:
> Hi Jay,
> 
> Thanks for your testing.
> 
> But I  cannot respond to your bugs without enough information.
> 
> Please inform me what you tested. My RFC v3 patches or my repository
> in github? If my repository in github, please show me HEAD in your
> local repository.

The RFC v3 patches.

> Additionally, please send me:
> 
> 1. PreSonus Inspire1394
>  $ cat /proc/asound/cardX/#formation

[hack@precision ~]$ cat /proc/asound/card3/#formation 
Output Stream from device:
	Rate	PCM	MIDI
	22050	0	0
	24000	0	0
	32000	0	0
	44100	4	0
	48000	4	0
	88200	4	0
	96000	4	0
	176400	0	0
	192000	0	0
Input Stream to device:
	Rate	PCM	MIDI
	22050	0	0
	24000	0	0
	32000	0	0
	44100	2	0
	48000	2	0
	88200	2	0
	96000	2	0
	176400	0	0
	192000	0	0

>  $ cat /proc/asound/cardX/#clock

[hack@precision ~]$ cat /proc/asound/card3/#clock 
Sampling rate: 44100
Clock Source: Internal (MSU-dest: 3)

>  $ cat /proc/asound/cardX/#firmware

[hack@precision ~]$ cat /proc/asound/card3/#firmware 
Manufacturer:	bridgeCo
Protocol Ver:	1
Build Ver:	0
GUID:		0x000A9200E6120698
Model ID:	0x9C
Model Rev:	1
Firmware Date:	20050902
Firmware Time:	182323
Firmware ID:	0x10001
Firmware Ver:	16777215
Base Addr:	0x20080000
Max Size:	1572864
Loader Date:	20050902
Loader Time:	174321

>  $ aplay --verbose -D plughw:X /usr/share/sounds/alsa/Noise.wav

[hack@precision ~]$ aplay --verbose -D plughw:3
/usr/share/sounds/alsa/Noise.wav 
Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
Endian, Rate 48000 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
Slave: Hardware PCM card 3 'Inspire1394' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 6000
  period_event : 0
  start_threshold  : 24000
  stop_threshold   : 24000
  silence_threshold: 0
  silence_size : 0
  boundary     : 6755399441055744000
  appl_ptr     : 0
  hw_ptr       : 0

>  $ arecord --verbose -D plughw:X /tmp/test.wav

[hack@precision ~]$ arecord --verbose -D plughw:3 /tmp/test.wav
Recording WAVE '/tmp/test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=U8)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 1365
  period_size  : 341
  period_time  : 42666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 341
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1365
  silence_threshold: 0
  silence_size : 0
  boundary     : 768426686420090880
Slave: Route conversion PCM (sformat=S32_LE)
  Transformation table:
    0 <- 0*0.25 + 1*0.25 + 2*0.25 + 3*0.25
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 8192
  period_size  : 2048
  period_time  : 42666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2048
  period_event : 0
  start_threshold  : 6
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Slave: Hardware PCM card 3 'Inspire1394' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 24
  buffer_size  : 8192
  period_size  : 2048
  period_time  : 42666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2048
  period_event : 0
  start_threshold  : 6
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
^CAborted by signal Interrupt...
arecord: pcm_read:2031: read error: Interrupted system call

>  ('X' should be for inspire1394.)
> 
> 2. FireWave
>  $ cat /proc/asound/cards

[hack@precision ~]$ cat /proc/asound/cards
 0 [ICH5           ]: ICH4 - Intel ICH5
                      Intel ICH5 with AD1981B at irq 17
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xf0710000 irq 89
 2 [Surrou         ]: FireWave - Griffin FireWave Surrou
                      Griffin Technology Griffin FireWave Surrou
(OXFW970 0104), GUID 001292060052048
 3 [Inspire1394    ]: BeBoB - Inspire1394
                      Presonus Inspire1394 (id:156, rev:1), GUID
000a9200e6120698 at fw2.0, S400

>  $ cat /proc/asound/cardY/#formation

[hack@precision ~]$ cat /proc/asound/card2/#formation
Output Stream from device:
	Rate	PCM	MIDI
	32000	0	0
	44100	0	0
	48000	0	0
	88200	0	0
	96000	0	0
	176400	0	0
	192000	0	0
Input Stream to device:
	Rate	PCM	MIDI
	32000	6	0
	44100	6	0
	48000	2	0
	88200	0	0
	96000	2	0
	176400	0	0
	192000	0	0

>  $ cat /proc/asound/cardY/#clock

[hack@precision ~]$ cat /proc/asound/card2/#clock
[hack@precision ~]$ 
>  $ aplay --verbose -D plughw:Y /usr/share/sounds/alsa/Noise.wav
> ('Y' should be for FireWave.)

[hack@precision ~]$ aplay --verbose -D plughw:2
/usr/share/sounds/alsa/Noise.wav 
Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
Endian, Rate 48000 Hz, Mono
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 48000
PERIOD_TIME: 125000
PERIOD_SIZE: 6000
PERIOD_BYTES: 12000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 48000
TICK_TIME: 0

> And I need dump of config_rom for FireWave.
>  $ hexdump -C /sys/bus/firewire/devices/fwZ/config_rom
> ('Z' should be 1 or 2 for FireWave.)

I'm including the hexdump for the Inspire1394 here and a decoded
version of the FireWave's config rom (as reported by my fwhack tool)

[hack@precision ~]$ echo /dev/fw*
/dev/fw0 /dev/fw1 /dev/fw2 /dev/fw3
[hack@precision ~]$ hexdump -C /sys/bus/firewire/devices/fw3/config_rom
00000000  a8 06 27 04 34 39 33 31  03 50 ff 20 06 92 12 00  |..'.4931.P. ....|
00000010  81 04 52 00 9a 54 06 00  92 12 00 03 0a 00 00 81  |..R..T..........|
00000020  70 f9 00 17 10 00 00 81  c0 83 00 0c 01 00 00 d1  |p...............|
00000030  bd ba 04 00 2d a0 00 12  01 00 01 13 70 f9 00 17  |....-.......p...|
00000040  0e 00 00 81 1e 89 07 00  00 00 00 00 00 00 00 00  |................|
00000050  66 69 72 47 20 6e 69 66  68 63 65 54 6f 6c 6f 6e  |firG nifhceTolon|
00000060  00 00 79 67 2b 0c 04 00  00 00 00 00 00 00 00 00  |..yg+...........|
00000070  65 72 69 46 65 76 61 57  1a 90 09 00 00 00 00 00  |eriFevaW........|
00000080  00 00 00 00 66 69 72 47  20 6e 69 66 65 72 69 46  |....firG niferiF|
00000090  65 76 61 57 72 75 53 20  6e 75 6f 72 00 00 00 64  |evaWruS nuor...d|
000000a0
[hack@precision ~]$ hexdump -C /sys/bus/firewire/devices/fw2/config_rom
00000000  28 ea 2b 04 34 39 33 31  22 61 64 f0 00 92 0a 00  |(.+.4931"ad.....|
00000010  98 06 12 e6 75 f1 09 00  9c 00 00 04 c0 83 00 0c  |....u...........|
00000020  92 0a 00 03 12 00 00 81  01 00 01 17 15 00 00 81  |................|
00000030  ff ff ff 13 02 00 00 d1  06 00 00 d4 c9 af 04 00  |................|
00000040  2d a0 00 12 01 00 01 13  01 00 01 17 13 00 00 81  |-...............|
00000050  c7 37 06 00 f5 07 00 12  01 00 00 13 c7 ff ff 3a  |.7.............:|
00000060  00 00 10 3b c7 ff ff 3c  00 00 60 3d a5 74 04 00  |...;...<..`=.t..|
00000070  00 00 00 00 00 00 00 00  73 65 72 50 73 75 6e 6f  |........serPsuno|
00000080  18 12 05 00 00 00 00 00  00 00 00 00 70 73 6e 49  |............psnI|
00000090  31 65 72 69 00 34 39 33  18 12 05 00 00 00 00 00  |1eri.493........|
000000a0  00 00 00 00 70 73 6e 49  31 65 72 69 00 34 39 33  |....psnI1eri.493|
000000b0
[hack@precision ~]$ fwhack /dev/fw3
i
info: version = 5, rom_length = 160, bus_reset_closure = 1, card = 1
rom (40 quadlets):
 042706a8  31333934  20ff5003  00129206
 00520481  0006549a  03001292  8100000a
 1700f970  81000010  0c0083c0  d1000001
 0004babd  1200a02d  13010001  1700f970
 8100000e  0007891e  00000000  00000000
 47726966  66696e20  54656368  6e6f6c6f
 67790000  00040c2b  00000000  00000000
 46697265  57617665  0009901a  00000000
 00000000  47726966  66696e20  46697265
 57617665  20537572  726f756e  64000000

Info length:  4
CRC length:  27
CRC:          6a8
Bus Info Block:  ISC res1=0, cyc_clk_acc=ff, max_rec=64, res2=3, max_rom=Quadlet, generation=0, res3=0, link_spd=3, node_vendor_id=001292, node_chip_id=0600520481
6 elements CRC 549a
Immediate Vendor   1292
Leaf Descriptor      a
key type 2
    7 elements CRC 891e
    Text 0 Griffin Technology
Immediate Model   f970
Leaf Descriptor     10
key type 2
    4 elements CRC c2b
    Text 0 FireWave
Immediate Node Capabilities   83c0
Directory Unit      1
key type 3
    4 elements CRC babd
    Immediate Specifier ID   a02d
    Immediate Version  10001
    Immediate Model   f970
    Leaf Descriptor      e
key type 2
        9 elements CRC 901a
        Text 0 Griffin FireWave Surround
bus reset: closure = 1, type = 0, node_id = ffc1, local_node_id = ffc2, bm_node_id = ffc2, irm_node_id = ffc2, root_node_id = ffc2, generation = 4



Let me know if there is any other information you need.

			-- JF

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
