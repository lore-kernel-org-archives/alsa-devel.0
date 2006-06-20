From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002219]: snd-mpu401 don't load
Date: Wed, 21 Jun 2006 00:00:20 +0200
Message-ID: <f8886d7b9e3212badcd18a1ca56feb29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9517916F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 00:00:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2219> 
======================================================================
Reported By:                El Santo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2219
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian etch (2006-06-18)
Kernel Version:             2.6.15-1-686
======================================================================
Date Submitted:             06-18-2006 17:41 CEST
Last Modified:              06-21-2006 00:00 CEST
======================================================================
Summary:                    snd-mpu401 don't load
Description: 
I have a Aopen MX63LE board with onboard sound managed by snd-via82xx
driver. It loads all necesary modules, includind snd-mpu401-uart, but no
snd-mpu401
The audio part of the driver works perfectly, but the midi port doesn't
work.

In BIOS i can set (and see) the mpu401 port (0x300 or 0x330) but there is
not a MPU401 IRQ setting in bios. When i tried to manually load snd-mpu401
(setting the port accordingly to BIOS) it doesnt work. I don't know the
mpu401 irq setting but i tryed them all. None of them worked. The driver
says "device not found".

Under windows xp the port works perfectly, so the hardware is ok. Anyway
under windows xp, i use a "system inspector" to monitor ioports and irq
usage, and i didnt see any irq assigned for mpu401 port, and the port
(0x330) wasn't occupied neither.

any idea?
======================================================================

----------------------------------------------------------------------
 El Santo - 06-20-06 23:54 
----------------------------------------------------------------------
-------------------
cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02e8-02ef : serial
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-4003 : PM1a_EVT_BLK
4008-400b : PM_TMR
4010-4015 : ACPI CPU throttle
4020-4023 : GPE0_BLK
40f0-40f1 : PM1a_CNT_BLK
5000-500f : 0000:00:07.4
  5000-5007 : vt596_smbus
6000-607f : 0000:00:07.4
  6000-607f : via686a
d000-d00f : 0000:00:07.1
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : 0000:00:07.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:07.3
  d800-d81f : uhci_hcd
dc00-dcff : 0000:00:07.5
  dc00-dcff : VIA686A
e000-e003 : 0000:00:07.5
  e000-e003 : VIA686A
e400-e403 : 0000:00:07.5
  e400-e403 : VIA686A
ec00-ec7f : 0000:00:09.0
-------------------

-------------------
lsmod

Module                  Size  Used by
ipv6                  221696  8
nls_iso8859_1           3936  1
isofs                  32792  1
loop                   15176  2
dm_mod                 51160  0
snd_seq_dummy           3556  0
snd_seq_oss            28896  0
snd_seq_midi            8384  0
snd_seq_midi_event      6368  2 snd_seq_oss,snd_seq_midi
snd_seq                44432  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
shpchp                 39712  0
pci_hotplug            24756  1 shpchp
via_agp                 9280  1
agpgart                31400  1 via_agp
snd_via82xx            25688  1
gameport               13928  1 snd_via82xx
snd_ac97_codec         82464  1 snd_via82xx
snd_ac97_bus            2048  1 snd_ac97_codec
snd_pcm_oss            45536  0
snd_mixer_oss          16448  1 snd_pcm_oss
snd_pcm                77576  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              21316  2 snd_seq,snd_pcm
snd_page_alloc          9928  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6592  1 snd_via82xx
via686a                15368  0
bt878                   9656  0
snd_rawmidi            22240  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          7916  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
i2c_isa                 4608  1 via686a
i2c_viapro              7924  0
snd                    48420  13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               8928  1 snd
tuner                  36644  0
bttv                  151600  1 bt878
video_buf              19748  1 bttv
firmware_class          9696  1 bttv
i2c_algo_bit            8296  1 bttv
v4l2_common             5632  1 bttv
btcx_risc               4520  1 bttv
tveeprom               13744  1 bttv
i2c_core               19280  7
via686a,i2c_isa,i2c_viapro,tuner,bttv,i2c_algo_bit,tveeprom
videodev                8768  1 bttv
parport_pc             32036  0
parport                31624  1 parport_pc
pcspkr                  1668  0
psmouse                32356  0
serio_raw               6468  0
rtc                    11316  0
floppy                 54628  0
joydev                  8864  0
evdev                   8800  2
mousedev               10496  1
ext3                  117768  2
jbd                    48404  1 ext3
mbcache                 8484  1 ext3
ide_disk               15712  4
ide_cd                 36484  0
cdrom                  33280  1 ide_cd
via82cxxx               8164  0 [permanent]
generic                 4260  0 [permanent]
ide_core              112800  4 ide_disk,ide_cd,via82cxxx,generic
uhci_hcd               28016  0
usbcore               113284  2 uhci_hcd
3c59x                  39432  0
mii                     5056  1 3c59x
thermal                13416  0
processor              22912  1 thermal
fan                     4580  0
-------------------

----------------------------------------------------------------------
 rlrevell - 06-21-06 00:00 
----------------------------------------------------------------------
Doesn't "gameport" conflict with "snd-mpu401"?

Try blacklisting gameport and/or snd-mpu401-uart, reboot and try again

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 17:41 El Santo       New Issue                                    
06-18-06 17:41 El Santo       Distribution              => Debian etch
(2006-06-18)
06-18-06 17:41 El Santo       Kernel Version            => 2.6.15-1-686    
06-19-06 03:45 Raymond        Note Added: 0010305                          
06-20-06 19:49 tiwai          Note Added: 0010349                          
06-20-06 23:30 El Santo       Note Added: 0010357                          
06-20-06 23:39 rlrevell       Note Added: 0010359                          
06-20-06 23:54 El Santo       Note Added: 0010362                          
06-21-06 00:00 rlrevell       Note Added: 0010363                          
======================================================================
