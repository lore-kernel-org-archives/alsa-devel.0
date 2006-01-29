From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001622]: ASUS A8V-MX onboard sound does not work
Date: Sun, 29 Jan 2006 02:14:19 +0100
Message-ID: <5770c94afca9c195ba07ad08843aa0c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B57018B
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 02:14:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622> 
======================================================================
Reported By:                m_yates
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1622
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12 (also reproduced using 2.6.15-rc2)
======================================================================
Date Submitted:             12-05-2005 18:59 CET
Last Modified:              01-29-2006 02:14 CET
======================================================================
Summary:                    ASUS A8V-MX onboard sound does not work
Description: 
Onboard sound plays for a second, then freezes on Asus A8V-MX mainboard. 
Here is sound output from lspci:

matt@duster:~$ lspci | grep Multimedia
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)

Here is alsa version (version that came with Ubuntu 5.10):

||/ Name           Version        Description
+++-==============-==============-============================================
ii  alsa-base      1.0.9b-4       ALSA driver configuration files

Here are the sound modules:

root@duster:/home/matt# lsmod | grep snd
snd_seq_dummy 4484 0
snd_seq_oss 32128 0
snd_seq_midi 9920 0
snd_seq_midi_event 8064 2 snd_seq_oss,snd_seq_midi
snd_seq 52032 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx 29472 1
gameport 16392 1 snd_via82xx
snd_ac97_codec 87000 1 snd_via82xx
snd_pcm_oss 51232 0
snd_mixer_oss 17664 1 snd_pcm_oss
snd_pcm 91020 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer 24200 2 snd_seq,snd_pcm
snd_page_alloc 11408 2 snd_via82xx,snd_pcm
snd_mpu401_uart 7936 1 snd_via82xx
snd_rawmidi 27040 2 snd_seq_midi,snd_mpu401_uart
snd_seq_device 9488 5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd 55784 13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu40
1_uart,snd_rawmidi,snd_seq_device
soundcore 10912 1 snd

Asus lists the audio chip as "Realtek ALC653", alsamixer shows "Realtek
ALC655 rev 1". 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001557 Sounds play only for a very short time ...
======================================================================

----------------------------------------------------------------------
 AlexCline - 01-03-06 20:41 
----------------------------------------------------------------------
I am also using Ubuntu 5.10 and the Asus A8v-MX, and I get one second of
distorted sound whenever I play a sound, and then it stops. Here's the
output of the debug script:


ALSA Audio Debug v0.1.0 - Tue Jan  3 14:34:43 EST 2006
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux alex 2.6.12-10-amd64-generic #1 Thu Dec 22 10:56:42 UTC 2005 x86_64
GNU/Linux

Loaded Modules --------------------------------------------
snd_seq_dummy           4484  0
snd_seq_oss            32128  0
snd_seq_midi            9920  0
snd_seq_midi_event      8064  2 snd_seq_oss,snd_seq_midi
snd_seq                52032  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx            29472  28
snd_ac97_codec         87000  1 snd_via82xx
snd_pcm_oss            51232  0
snd_mixer_oss          17664  3 snd_pcm_oss
snd_pcm                91020  18 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              24200  2 snd_seq,snd_pcm
snd_page_alloc         11408  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7936  1 snd_via82xx
snd_rawmidi            27040  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          9488  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd                    55784  59
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Proc Config -----------------------------------------------
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_CA0106=m
CONFIG_SND_KORG1212=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VX222=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
# CONFIG_SOUND_CMPCI_FM is not set
# CONFIG_SOUND_CMPCI_MIDI is not set
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SOUND_TVMIXER=m
CONFIG_SOUND_KAHLUA=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_AD1980=m

Modprobe Conf ---------------------------------------------
alias char-major-116    snd
alias char-major-116 snd
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3
alias sound-slot-4 snd-card-4
alias sound-slot-5 snd-card-5
alias sound-slot-6 snd-card-6
alias sound-slot-7 snd-card-7
above sound-slot-0 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-1 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-2 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-3 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-4 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-5 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-6 snd-pcm-oss snd-mixer-oss snd-seq-oss
above sound-slot-7 snd-pcm-oss snd-mixer-oss snd-seq-oss
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
above snd-pcm snd-pcm-oss
above snd-mixer snd-mixer-oss
above snd-seq snd-seq-oss snd-seq-midi
above snd-emu10k1 snd-emu10k1-synth
above snd-via82xx snd-seq
# Cause a script to be run after snd-*-synth module initialization
post-install snd-emu8000-synth /lib/alsa/modprobe-post-install
snd-emu8000-synthpost-install snd-emu10k1-synth
/lib/alsa/modprobe-post-install snd-emu10k1-synthpost-install snd-ad1816a
/lib/alsa/modprobe-post-install snd-ad1816a
post-install snd-ad1848 /lib/alsa/modprobe-post-install snd-ad1848
post-install snd-ali5451 /lib/alsa/modprobe-post-install snd-ali5451
post-install snd-als100 /lib/alsa/modprobe-post-install snd-als100
post-install snd-als4000 /lib/alsa/modprobe-post-install snd-als4000
post-install snd-armaaci /lib/alsa/modprobe-post-install snd-armaaci
post-install snd-asihpi /lib/alsa/modprobe-post-install snd-asihpi
post-install snd-atiixp /lib/alsa/modprobe-post-install snd-atiixp
post-install snd-au1x00 /lib/alsa/modprobe-post-install snd-au1x00
post-install snd-au8810 /lib/alsa/modprobe-post-install snd-au8810
post-install snd-au8820 /lib/alsa/modprobe-post-install snd-au8820
post-install snd-au8830 /lib/alsa/modprobe-post-install snd-au8830
post-install snd-azt2320 /lib/alsa/modprobe-post-install snd-azt2320
post-install snd-azt3328 /lib/alsa/modprobe-post-install snd-azt3328
post-install snd-ca0106 /lib/alsa/modprobe-post-install snd-ca0106
post-install snd-cmi8330 /lib/alsa/modprobe-post-install snd-cmi8330
post-install snd-cmipci /lib/alsa/modprobe-post-install snd-cmipci
post-install snd-cs4231 /lib/alsa/modprobe-post-install snd-cs4231
post-install snd-cs4232 /lib/alsa/modprobe-post-install snd-cs4232
post-install snd-cs4236 /lib/alsa/modprobe-post-install snd-cs4236
post-install snd-cs4281 /lib/alsa/modprobe-post-install snd-cs4281
post-install snd-cs46xx /lib/alsa/modprobe-post-install snd-cs46xx
post-install snd-darla20 /lib/alsa/modprobe-post-install snd-darla20
post-install snd-darla24 /lib/alsa/modprobe-post-install snd-darla24
post-install snd-dt019x /lib/alsa/modprobe-post-install snd-dt019x
post-install snd-echo3g /lib/alsa/modprobe-post-install snd-echo3g
post-install snd-emu10k1x /lib/alsa/modprobe-post-install snd-emu10k1x
post-install snd-ens1370 /lib/alsa/modprobe-post-install snd-ens1370
post-install snd-ens1371 /lib/alsa/modprobe-post-install snd-ens1371
post-install snd-es1688 /lib/alsa/modprobe-post-install snd-es1688
post-install snd-es18xx /lib/alsa/modprobe-post-install snd-es18xx
post-install snd-es1938 /lib/alsa/modprobe-post-install snd-es1938
post-install snd-es1968 /lib/alsa/modprobe-post-install snd-es1968
post-install snd-es968 /lib/alsa/modprobe-post-install snd-es968
post-install snd-fm801 /lib/alsa/modprobe-post-install snd-fm801
post-install snd-fm801-tea575x /lib/alsa/modprobe-post-install
snd-fm801-tea575xpost-install snd-gina20 /lib/alsa/modprobe-post-install
snd-gina20
post-install snd-gina24 /lib/alsa/modprobe-post-install snd-gina24
post-install snd-gusclassic /lib/alsa/modprobe-post-install
snd-gusclassic
post-install snd-gusextreme /lib/alsa/modprobe-post-install
snd-gusextreme
post-install snd-gusmax /lib/alsa/modprobe-post-install snd-gusmax
post-install snd-harmony /lib/alsa/modprobe-post-install snd-harmony
post-install snd-hda-intel /lib/alsa/modprobe-post-install snd-hda-intel
post-install snd-hdsp /lib/alsa/modprobe-post-install snd-hdsp
post-install snd-hdspm /lib/alsa/modprobe-post-install snd-hdspm
post-install snd-ice1712 /lib/alsa/modprobe-post-install snd-ice1712
post-install snd-ice1724 /lib/alsa/modprobe-post-install snd-ice1724
post-install snd-indigo /lib/alsa/modprobe-post-install snd-indigo
post-install snd-indigodj /lib/alsa/modprobe-post-install snd-indigodj
post-install snd-indigoio /lib/alsa/modprobe-post-install snd-indigoio
post-install snd-intel8x0 /lib/alsa/modprobe-post-install snd-intel8x0
post-install snd-interwave /lib/alsa/modprobe-post-install snd-interwave
post-install snd-interwave-stb /lib/alsa/modprobe-post-install
snd-interwave-stbpost-install snd-korg1212 /lib/alsa/modprobe-post-install
snd-korg1212
post-install snd-layla20 /lib/alsa/modprobe-post-install snd-layla20
post-install snd-layla24 /lib/alsa/modprobe-post-install snd-layla24
post-install snd-maestro3 /lib/alsa/modprobe-post-install snd-maestro3
post-install snd-mia /lib/alsa/modprobe-post-install snd-mia
post-install snd-miro /lib/alsa/modprobe-post-install snd-miro
post-install snd-mixart /lib/alsa/modprobe-post-install snd-mixart
post-install snd-mona /lib/alsa/modprobe-post-install snd-mona
post-install snd-mpu401 /lib/alsa/modprobe-post-install snd-mpu401
post-install snd-msnd-pinnacle /lib/alsa/modprobe-post-install
snd-msnd-pinnaclepost-install snd-mtpav /lib/alsa/modprobe-post-install
snd-mtpav
post-install snd-nm256 /lib/alsa/modprobe-post-install snd-nm256
post-install snd-opl3sa2 /lib/alsa/modprobe-post-install snd-opl3sa2
post-install snd-opti92x-ad1848 /lib/alsa/modprobe-post-install
snd-opti92x-ad1848
post-install snd-opti92x-cs4231 /lib/alsa/modprobe-post-install
snd-opti92x-cs4231
post-install snd-opti93x /lib/alsa/modprobe-post-install snd-opti93x
post-install snd-pc98-cs4232 /lib/alsa/modprobe-post-install
snd-pc98-cs4232
post-install snd-pcsp /lib/alsa/modprobe-post-install snd-pcsp
post-install snd-pcxhr /lib/alsa/modprobe-post-install snd-pcxhr
post-install snd-pdaudiocf /lib/alsa/modprobe-post-install snd-pdaudiocf
post-install snd-pdplus /lib/alsa/modprobe-post-install snd-pdplus
post-install snd-portman2x4 /lib/alsa/modprobe-post-install
snd-portman2x4
post-install snd-powermac /lib/alsa/modprobe-post-install snd-powermac
post-install snd-pxa2xx-ac97 /lib/alsa/modprobe-post-install
snd-pxa2xx-ac97
post-install snd-rme32 /lib/alsa/modprobe-post-install snd-rme32
post-install snd-rme96 /lib/alsa/modprobe-post-install snd-rme96
post-install snd-rme9652 /lib/alsa/modprobe-post-install snd-rme9652
post-install snd-s3c2410 /lib/alsa/modprobe-post-install snd-s3c2410
post-install snd-sa11xx-uda1341 /lib/alsa/modprobe-post-install
snd-sa11xx-uda1341
post-install snd-sb16 /lib/alsa/modprobe-post-install snd-sb16
post-install snd-sb8 /lib/alsa/modprobe-post-install snd-sb8
post-install snd-sbawe /lib/alsa/modprobe-post-install snd-sbawe
post-install snd-serialmidi /lib/alsa/modprobe-post-install
snd-serialmidi
post-install snd-serial-u16550 /lib/alsa/modprobe-post-install
snd-serial-u16550post-install snd-sgalaxy /lib/alsa/modprobe-post-install
snd-sgalaxy
post-install snd-sonicvibes /lib/alsa/modprobe-post-install
snd-sonicvibes
post-install snd-sscape /lib/alsa/modprobe-post-install snd-sscape
post-install snd-sun-amd7930 /lib/alsa/modprobe-post-install
snd-sun-amd7930
post-install snd-sun-cs4231 /lib/alsa/modprobe-post-install
snd-sun-cs4231
post-install snd-sun-dbri /lib/alsa/modprobe-post-install snd-sun-dbri
post-install snd-trident /lib/alsa/modprobe-post-install snd-trident
post-install snd-usb-audio /lib/alsa/modprobe-post-install snd-usb-audio
post-install snd-usb-usx2y /lib/alsa/modprobe-post-install snd-usb-usx2y
post-install snd-vx222 /lib/alsa/modprobe-post-install snd-vx222
post-install snd-vxp440 /lib/alsa/modprobe-post-install snd-vxp440
post-install snd-vxpocket /lib/alsa/modprobe-post-install snd-vxpocket
post-install snd-wavefront /lib/alsa/modprobe-post-install snd-wavefront
post-install snd-ymfpci /lib/alsa/modprobe-post-install snd-ymfpci
options snd-bt87x index=-2
options snd-atiixp-modem index=-2
options snd-intel8x0m index=-2
options snd-via82xx-modem index=-2

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29
07:31:02 2005 UTC).
0 [rev70          ]: VIA8237 - VIA 823x rev70
                     VIA 823x rev70 with ALC655 at 0xd400, irq 22
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer
cat: /proc/asound/hwdep: No such file or directory
00-00: VIA 823x rev70 : VIA 823x rev70 : playback 4 : capture 1
00-01: VIA 823x rev70 : VIA 823x rev70 : playback 1 : capture 1
Client info
  cur  clients : 3
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 63:0
Client  62 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
Client  63 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  pcmC0D1c  pcmC0D1p  seq  timer

CPU -------------------------------------------------------
model name      : AMD Athlon(tm) 64 Processor 3200+
cpu MHz         : 2000.157

RAM -------------------------------------------------------
MemTotal:      1021876 kB
SwapTotal:     2996080 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3204
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7204
0000:00:0b.0 Multimedia video controller: Internext Compression Inc iTVC16
(CX23416) MPEG-2 Encoder (rev 01)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)
0000:00:11.7 Host bridge: VIA Technologies, Inc.: Unknown device 287e
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge

----------------------------------------------------------------------
 adaviel - 01-29-06 02:14 
----------------------------------------------------------------------
Me, too. ASUS A8V-MX board, AMD64 CPU, FC3-i386 system
tried FC4 base kernel 2.6.11-1.1369_FC4 (hda DMA fails)
FC updated 2.6.15-1.1871_FC5
kernel.org 2.6.16-rc1

lspci shows VT8233/A/8235/8237 AC97 Audio Controller (rev 70)
  Class 0401: 1106:3059 (rev 70)
Sound is OK for about a second then stops.
With dxs_support=5 sound is OK for about 4 seconds playing 11025/sec file

Tried pci=noacpi, index=0,  id="VIA - no difference
Tried looking for drivers at asus.com and viarena.com. ASUS has
current ALSA driver (lists VT8233 up to rev 60, I have rev 70).
VIA has mostly old stuff (2.4 kernel, RehHat8/9) which I could not build
even though it says "FC4". Hard to find things on their site; their
driver directory is not browsable and some links are broken.

Have submitted this issue to ASUS
http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM2006012863983987
Looks like a boilerplate reply - talks about Windows though
I checked "Linux".Some suggestions re. rearranging IRQ.

Bootup syslog includes
pcie_portdrv_probe->Dev[287c:1106] has invalid IRQ. Check vendor BIOS
Hmm.. think that may be  VT8251 PCI bridge (match with "lspci -n")

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-05 18:59 m_yates        New Issue                                    
12-05-05 18:59 m_yates        Distribution              => Ubuntu 5.10     
12-05-05 18:59 m_yates        Kernel Version            => 2.6.12 (also
reproduced using 2.6.15-rc2)
12-06-05 15:53 tiwai          Note Added: 0006926                          
12-06-05 18:21 m_yates        Note Added: 0006931                          
12-06-05 20:16 m_yates        Note Added: 0006937                          
12-07-05 01:09 Dakkus         Issue Monitored: Dakkus                      
12-07-05 11:24 perex          Relationship added       has duplicate 0001557
12-07-05 16:16 thijser        Issue Monitored: thijser                     
01-02-06 23:53 AlexCline      Issue Monitored: AlexCline                    
01-03-06 20:41 AlexCline      Note Added: 0007406                          
01-29-06 02:14 adaviel        Note Added: 0007830                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
