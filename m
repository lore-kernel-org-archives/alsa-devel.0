From: thomas.besser@ngi.de
Subject: no sound anymore... (alsa & ac97 & intel8x0)
Date: Thu, 10 Aug 2006 12:49:12 +0200
Message-ID: <ebf2vj$ajv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3372731.nvhBahu1JQ"
Content-Transfer-Encoding: 7Bit
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

--nextPart3372731.nvhBahu1JQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi,

after upgrading my debian sarge box (with backport from backports.org) fr=
om
kernel 2.6.7 to 2.6.16 my sound doesn't work anymore.

Error messages:
ALSA sound/pci/ac97/ac97_codec.c:1898: AC'97 2 does not respond - RESET
ALSA sound/pci/ac97/ac97_codec.c:1907: AC'97 2 access is not valid
[0xffffffff], removing mixer.
ALSA sound/pci/intel8x0.c:2129: Unable to initialize codec #2

Whats going wrong there?

More details in the attached aadebug-output.

Regards
Thomas
--nextPart3372731.nvhBahu1JQ
Content-Type: text/plain; name="aa-debug-output"
Content-Disposition: attachment; filename="aa-debug-output"
Content-Transfer-Encoding: quoted-printable

ALSA Audio Debug v0.1.0 - Mo Mai 15 11:16:11 CEST 2006
http://alsa.opensrc.org/index.php?page=3Daadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux ThessyMobil 2.6.16 #1 PREEMPT Fri May 12 11:56:17 CEST 2006 i686 GN=
U/Linux

Loaded Modules --------------------------------------------
snd_intel8x0           30748  0
snd_ac97_codec         96160  1 snd_intel8x0
snd_ac97_bus            1984  1 snd_ac97_codec
snd_pcm_oss            58656  0
snd_mixer_oss          17984  1 snd_pcm_oss
snd_pcm                93320  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              23940  1 snd_pcm
snd                    54052  6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,s=
nd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc          9288  2 snd_intel8x0,snd_pcm

Proc Config -----------------------------------------------
CONFIG_SOUND=3Dm
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
CONFIG_SND_DEBUG_DETECT=3Dy
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_AC97_BUS=3Dm
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=3Dm
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set
# CONFIG_SOUND_PRIME is not set

Modprobe Conf ---------------------------------------------
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
post-install snd-emu8000-synth /lib/alsa/modprobe-post-install snd-emu800=
0-synth
post-install snd-emu10k1-synth /lib/alsa/modprobe-post-install snd-emu10k=
1-synth
post-install snd-ad1816a /lib/alsa/modprobe-post-install snd-ad1816a
post-install snd-ad1848 /lib/alsa/modprobe-post-install snd-ad1848
post-install snd-adlib /lib/alsa/modprobe-post-install snd-adlib
post-install snd-ad1889 /lib/alsa/modprobe-post-install snd-ad1889
post-install snd-ali5451 /lib/alsa/modprobe-post-install snd-ali5451
post-install snd-als100 /lib/alsa/modprobe-post-install snd-als100
post-install snd-als300 /lib/alsa/modprobe-post-install snd-als300
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
post-install snd-cs5535audio /lib/alsa/modprobe-post-install snd-cs5535au=
dio
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
post-install snd-fm801-tea575x /lib/alsa/modprobe-post-install snd-fm801-=
tea575x
post-install snd-gina20 /lib/alsa/modprobe-post-install snd-gina20
post-install snd-gina24 /lib/alsa/modprobe-post-install snd-gina24
post-install snd-gusclassic /lib/alsa/modprobe-post-install snd-gusclassi=
c
post-install snd-gusextreme /lib/alsa/modprobe-post-install snd-gusextrem=
e
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
post-install snd-interwave-stb /lib/alsa/modprobe-post-install snd-interw=
ave-stb
post-install snd-korg1212 /lib/alsa/modprobe-post-install snd-korg1212
post-install snd-layla20 /lib/alsa/modprobe-post-install snd-layla20
post-install snd-layla24 /lib/alsa/modprobe-post-install snd-layla24
post-install snd-maestro3 /lib/alsa/modprobe-post-install snd-maestro3
post-install snd-mia /lib/alsa/modprobe-post-install snd-mia
post-install snd-miro /lib/alsa/modprobe-post-install snd-miro
post-install snd-mixart /lib/alsa/modprobe-post-install snd-mixart
post-install snd-mona /lib/alsa/modprobe-post-install snd-mona
post-install snd-mpu401 /lib/alsa/modprobe-post-install snd-mpu401
post-install snd-msnd-pinnacle /lib/alsa/modprobe-post-install snd-msnd-p=
innacle
post-install snd-mtpav /lib/alsa/modprobe-post-install snd-mtpav
post-install snd-nm256 /lib/alsa/modprobe-post-install snd-nm256
post-install snd-opl3sa2 /lib/alsa/modprobe-post-install snd-opl3sa2
post-install snd-opti92x-ad1848 /lib/alsa/modprobe-post-install snd-opti9=
2x-ad1848
post-install snd-opti92x-cs4231 /lib/alsa/modprobe-post-install snd-opti9=
2x-cs4231
post-install snd-opti93x /lib/alsa/modprobe-post-install snd-opti93x
post-install snd-pc98-cs4232 /lib/alsa/modprobe-post-install snd-pc98-cs4=
232
post-install snd-pcsp /lib/alsa/modprobe-post-install snd-pcsp
post-install snd-pcxhr /lib/alsa/modprobe-post-install snd-pcxhr
post-install snd-pdaudiocf /lib/alsa/modprobe-post-install snd-pdaudiocf
post-install snd-pdplus /lib/alsa/modprobe-post-install snd-pdplus
post-install snd-portman2x4 /lib/alsa/modprobe-post-install snd-portman2x=
4
post-install snd-powermac /lib/alsa/modprobe-post-install snd-powermac
post-install snd-pxa2xx-ac97 /lib/alsa/modprobe-post-install snd-pxa2xx-a=
c97
post-install snd-pxa2xx-i2sound /lib/alsa/modprobe-post-install snd-pxa2x=
x-i2sound
post-install snd-riptide /lib/alsa/modprobe-post-install snd-riptide
post-install snd-rme32 /lib/alsa/modprobe-post-install snd-rme32
post-install snd-rme96 /lib/alsa/modprobe-post-install snd-rme96
post-install snd-rme9652 /lib/alsa/modprobe-post-install snd-rme9652
post-install snd-s3c2410 /lib/alsa/modprobe-post-install snd-s3c2410
post-install snd-sa11xx-uda1341 /lib/alsa/modprobe-post-install snd-sa11x=
x-uda1341
post-install snd-sb16 /lib/alsa/modprobe-post-install snd-sb16
post-install snd-sb8 /lib/alsa/modprobe-post-install snd-sb8
post-install snd-sbawe /lib/alsa/modprobe-post-install snd-sbawe
post-install snd-serialmidi /lib/alsa/modprobe-post-install snd-serialmid=
i
post-install snd-serial-u16550 /lib/alsa/modprobe-post-install snd-serial=
-u16550
post-install snd-sgalaxy /lib/alsa/modprobe-post-install snd-sgalaxy
post-install snd-sonicvibes /lib/alsa/modprobe-post-install snd-sonicvibe=
s
post-install snd-sscape /lib/alsa/modprobe-post-install snd-sscape
post-install snd-sun-amd7930 /lib/alsa/modprobe-post-install snd-sun-amd7=
930
post-install snd-sun-cs4231 /lib/alsa/modprobe-post-install snd-sun-cs423=
1
post-install snd-sun-dbri /lib/alsa/modprobe-post-install snd-sun-dbri
post-install snd-trident /lib/alsa/modprobe-post-install snd-trident
post-install snd-usb-audio /lib/alsa/modprobe-post-install snd-usb-audio
post-install snd-usb-usx2y /lib/alsa/modprobe-post-install snd-usb-usx2y
post-install snd-vx222 /lib/alsa/modprobe-post-install snd-vx222
post-install snd-vxpocket /lib/alsa/modprobe-post-install snd-vxpocket
post-install snd-wavefront /lib/alsa/modprobe-post-install snd-wavefront
post-install snd-ymfpci /lib/alsa/modprobe-post-install snd-ymfpci
options snd-bt87x index=3D-2
options snd-atiixp-modem index=3D-2
options snd-intel8x0m index=3D-2
options snd-via82xx-modem index=3D-2
# alias snd-atiixp-modem off
# alias snd-intel8x0m off
# alias snd-via82xx-modem off
### update-modules: start processing /etc/modutils/linux-sound-base_noOSS
alias sound off
alias dmasound_core off
alias dmasound_pmac off
alias soundcard off
### update-modules: end processing /etc/modutils/linux-sound-base_noOSS

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08=
:57:20 2006 UTC).
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq =
5
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 20: [ 0- 4]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 26: [ 0- 2]: digital audio capture
 27: [ 0- 3]: digital audio capture
 33:        : timer
cat: /proc/asound/hwdep: Datei oder Verzeichnis nicht gefunden
00-04: Intel ICH - IEC958 : Intel 82801DB-ICH4 - IEC958 : playback 1
00-03: Intel ICH - ADC2 : Intel 82801DB-ICH4 - ADC2 : capture 1
00-02: Intel ICH - MIC2 ADC : Intel 82801DB-ICH4 - MIC2 ADC : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801DB-ICH4 - MIC ADC : capture 1
00-00: Intel ICH : Intel 82801DB-ICH4 : playback 1 : capture 1
cat: /proc/asound/seq/clients: Datei oder Verzeichnis nicht gefunden

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0p  pcmC0D2c  pcmC0D4p
pcmC0D0c   pcmC0D1c  pcmC0D3c  timer

CPU -------------------------------------------------------
model name      : Intel(R) Pentium(R) M processor 1300MHz
cpu MHz         : 1295.998

RAM -------------------------------------------------------
MemTotal:       515584 kB
SwapTotal:      506512 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller=
 (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (IC=
H4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)

--nextPart3372731.nvhBahu1JQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--nextPart3372731.nvhBahu1JQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart3372731.nvhBahu1JQ--
