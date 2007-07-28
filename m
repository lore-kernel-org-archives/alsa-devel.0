From: Meelis Roos <mroos@linux.ee>
Subject: snd-hda-intel & ALC268 codec
Date: Sat, 28 Jul 2007 17:44:29 +0300 (EEST)
Message-ID: <Pine.SOC.4.64.0707281744050.18701@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 764E51037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jul 2007 16:44:29 +0200 (CEST)
Received: from math.ut.ee (math.ut.ee [193.40.36.2])
	by smtp2.it.da.ut.ee (Postfix) with ESMTP id 341E84C02273
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jul 2007 17:44:29 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by math.ut.ee (Postfix) with ESMTP id 18D476ADEB
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jul 2007 17:44:29 +0300 (EEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a laptop with Realtek ALC268 codec connected to Intel HDA 
controller. The laptop is Compal OEM, specific module currently unknown 
(it's assembled by a local reseller as Ordi Enduro 7300BF).

2.6.22 didn't much understand the codec. 2.6.23-rc1 seems to know much 
more about it and it almost works - but not quite. On bootup, the 
following line is in dmesg:
hda_codec: Unknown model for ALC268, trying auto-probe from BIOS...
It initializes fine but the sound is so quiet that I can only hear it 
with active speakers when I turn the volume to max. No mixer sliders can 
make it louder. Additionally, there are some strange mixer switches like 
Off-hook and Caller ID.

The only strings identifying the base board are from dmidecode:
Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: COMPAL
        Product Name: IFT00
        Version: REFERENCE
        Serial Number: N/A

Additionally, the system has identified most PCI devices by subsystem 
vendor & ID 14c0:0023, like this:
00:1b.0 0403: 8086:284b (rev 03)
        Subsystem: 14c0:0023
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at f8400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0


ls -lR /proc/asound/Intel/:
/proc/asound/Intel/:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 codec#0
-r--r--r-- 1 root root 0 2007-07-28 17:26 codec#1
-r--r--r-- 1 root root 0 2007-07-28 17:26 id
-rw-r--r-- 1 root root 0 2007-07-28 17:26 oss_mixer
dr-xr-xr-x 4 root root 0 2007-07-28 17:26 pcm0c
dr-xr-xr-x 3 root root 0 2007-07-28 17:26 pcm0p
dr-xr-xr-x 4 root root 0 2007-07-28 17:26 pcm2c
dr-xr-xr-x 3 root root 0 2007-07-28 17:26 pcm6c
dr-xr-xr-x 3 root root 0 2007-07-28 17:26 pcm6p

/proc/asound/Intel/pcm0c:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 oss
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub0
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub1

/proc/asound/Intel/pcm0c/sub0:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm0c/sub1:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm0p:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 oss
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub0

/proc/asound/Intel/pcm0p/sub0:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm2c:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub0
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub1

/proc/asound/Intel/pcm2c/sub0:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm2c/sub1:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm6c:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub0

/proc/asound/Intel/pcm6c/sub0:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params

/proc/asound/Intel/pcm6p:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
dr-xr-xr-x 2 root root 0 2007-07-28 17:26 sub0

/proc/asound/Intel/pcm6p/sub0:
total 0
-r--r--r-- 1 root root 0 2007-07-28 17:26 hw_params
-r--r--r-- 1 root root 0 2007-07-28 17:26 info
-rw-r--r-- 1 root root 0 2007-07-28 17:26 prealloc
-r--r--r-- 1 root root 0 2007-07-28 17:26 prealloc_max
-r--r--r-- 1 root root 0 2007-07-28 17:26 status
-r--r--r-- 1 root root 0 2007-07-28 17:26 sw_params


amixer controls gives the following output:

numid=4,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=3,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=64,step=0
  : values=45,45
  | dBscale-min=-64.00dB,step=1.00dB,mute=0
numid=13,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=255,255
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=2,iface=MIXER,name='Front Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Front Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=64,step=0
  : values=52,52
  | dBscale-min=-64.00dB,step=1.00dB,mute=0
numid=6,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=8,iface=MIXER,name='Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=5,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=31,step=0
  : values=1,1
  | dBscale-min=-16.50dB,step=1.50dB,mute=0
numid=7,iface=MIXER,name='Capture Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=31,step=0
  : values=1,1
  | dBscale-min=-16.50dB,step=1.50dB,mute=0
numid=12,iface=MIXER,name='Caller ID Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=14,iface=MIXER,name='Digital Capture Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=120,step=0
  : values=60,60
  | dBscale-min=-30.00dB,step=0.50dB,mute=0
numid=9,iface=MIXER,name='Input Source'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Mic'
  ; Item #1 'Front Mic'
  : values=0
numid=10,iface=MIXER,name='Input Source',index=1
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Mic'
  ; Item #1 'Front Mic'
  : values=0
numid=11,iface=MIXER,name='Off-hook Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off

-- 
Meelis Roos (mroos@linux.ee)
