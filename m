From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: No sound with C-Media CMI8788
Date: Wed, 02 Sep 2009 11:26:52 +0300
Message-ID: <4A9E2C4C.4010108@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4364D2453E
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 10:23:03 +0200 (CEST)
Received: from [192.168.3.203] (uekae-subnet-out.ume.tubitak.gov.tr
	[194.27.222.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by lider.pardus.org.tr (Postfix) with ESMTPSA id A11F6A7AB22
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 11:18:41 +0300 (EEST)
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

I have two bug reports about the $subject. One of the users had tested
it with 1.0.21 and still can get no sound with it. I'm attaching the
alsa-info output + relevant dmesg lines:


[    7.797723] CMI8788 0000:05:06.0: PCI INT A -> Link[APC1] -> GSI 16
(level, low) -> IRQ 16
[    7.797794] CMI8788 0000:05:06.0: PCI INT A disabled
[    7.941267] AV200 0000:05:06.0: PCI INT A -> Link[APC1] -> GSI 16
(level, low) -> IRQ 16
[    7.941335] AV200 0000:05:06.0: PCI INT A disabled
[    8.020782] CMI8787HiFier 0000:05:06.0: PCI INT A -> Link[APC1] ->
GSI 16 (level, low) -> IRQ 16
[    8.020849] CMI8787HiFier 0000:05:06.0: PCI INT A disabled


!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Tue Sep  1 15:56:18 UTC 2009


!!Linux Distribution
!!------------------

Pardus 2009


!!DMI Information
!!---------------

Manufacturer:      Not provided
Product Name:      Not provided


!!Kernel Information
!!------------------

Kernel release:    2.6.30.1-123
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Athlon(tm) 64 FX-57 Processor
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.20
Utilities version:  1.0.20


!!Loaded ALSA modules
!!-------------------

snd_mpu401


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No
!!Soundcards recognised by ALSA
!!-----------------------------

 1 [UART           ]: MPU-401 UART - MPU-401 UART
                      MPU-401 UART at 0x330, irq 10


!!PCI Soundcards installed in the system
!!--------------------------------------

05:06.0 Multimedia audio controller: C-Media Electronics Inc CMI8788
[Oxygen HD Audio]


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

05:06.0 0401: 13f6:8788
    Subsystem: 13f6:8788


!!Loaded sound module options
!!--------------------------

!!Module: snd_mpu401
enable : Y,N,N,N,N,N,N,N
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -2,-2,-2,-2,-2,-2,-2,-2
irq : 10,65535,65535,65535,65535,65535,65535,65535
pnp : Y,Y,Y,Y,Y,Y,Y,Y
port : 816,1,1,1,1,1,1,1
uart_enter : Y,Y,Y,Y,Y,Y,Y,Y


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root audio 116, 32 Sep  1 04:22 /dev/snd/controlC1
crw-rw----  1 root audio 116, 40 Sep  1 04:22 /dev/snd/midiC1D0
crw-rw----  1 root audio 116,  1 Sep  1 04:22 /dev/snd/seq
crw-rw----  1 root audio 116, 33 Sep  1 04:22 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

# PulseAudio plugin configuration

# Let's create a virtual device "pulse" for mixer and PCM

pcm.pulse {
    type pulse
    hint {
        description "PulseAudio Sound Server"
    }
}

ctl.pulse {
    type pulse
    hint {
        description "PulseAudio Sound Server"
    }
}

# Let's make it the default!

pcm.!default {
    type pulse
    hint {
        description "Default"
    }
}

ctl.!default {
    type pulse
    hint {
        description "Default"
    }
}



!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****

ARECORD

**** List of CAPTURE Hardware Devices ****

!!Amixer output
!!-------------

!!-------Mixer controls for card 1 [UART]

Card hw:1 'UART'/'MPU-401 UART at 0x330, irq 10'
  Mixer name    : ''
  Components    : ''
  Controls      : 0
  Simple ctrls  : 0


!!Alsactl output
!!-------------

--startcollapse--
state.UART {
    control {
    }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ppp_deflate
zlib_deflate
ppp_async
crc_ccitt
ppp_generic
slhc
ipv6
snd_hifier
snd_virtuoso
snd_cs4236
snd_oxygen
snd_oxygen_lib
snd_wavefront
snd_wss_lib
nouveau
ppdev
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_opl3_lib
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_mpu401
snd_mpu401_uart
parport_pc
drm
snd_rawmidi
snd_seq_device
snd_timer
snd
pcspkr
agpgart
k8temp
snd_page_alloc
lp
ns558
i2c_algo_bit
soundcore
gameport
parport
i2c_nforce2
cdc_acm
asus_atk0110
brd
ata_generic
sata_nv
pata_amd
pata_acpi
libata
