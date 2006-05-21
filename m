From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002112]: Problems recording sound from my USB microphone
Date: Sun, 21 May 2006 19:20:06 +0200
Message-ID: <a8e8e8d3f78f21f40900570aca50ae27@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F544192
	for <alsa-devel@alsa-project.org>; Sun, 21 May 2006 19:20:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2112> 
======================================================================
Reported By:                mkap
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2112
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-10-2006 23:00 CEST
Last Modified:              05-21-2006 19:20 CEST
======================================================================
Summary:                    Problems recording sound from my USB microphone
Description: 
Hello,
I'm using a Ubuntu Breezy with a 2.6.12.10 kernel.
I am trying to use my USB headset.
I must say listening to anything works fine.
Unfortunately If I try to record something this is what I get.

command line:
arecord -c 1 -d 10 -f cd -t wav -D hw:0,0 foobar.wav

errmsg:
arecord: set_params:887: Channels count non available

aadebug gives this back, if it's any use to you.
ALSA Audio Debug v0.1.0 - mer mai 10 22:34:43 CEST 2006
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux portablemk 2.6.12-10-amd64-generic #1 Fri Apr 28 13:18:42 UTC 2006
x86_64 GNU/Linux

Loaded Modules --------------------------------------------
snd_via82xx_modem      16580  0 
snd_via82xx            29472  0 
snd_ac97_codec         87000  2 snd_via82xx_modem,snd_via82xx
snd_mpu401_uart         7936  1 snd_via82xx
snd_usb_audio          80640  0 
snd_pcm                91020  4
snd_via82xx_modem,snd_via82xx,snd_ac97_codec,snd_usb_audio
snd_timer              24200  1 snd_pcm
snd_page_alloc         11408  3 snd_via82xx_modem,snd_via82xx,snd_pcm
snd_usb_lib            15488  1 snd_usb_audio
snd_rawmidi            27040  2 snd_mpu401_uart,snd_usb_lib
snd_seq_device          9488  1 snd_rawmidi
snd_hwdep              10784  1 snd_usb_audio
snd                    55784  10
snd_via82xx_modem,snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_usb_audio,snd_pcm,snd_timer,snd_rawmidi,snd_seq_device,snd_hwdep

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

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29
07:31:02 2005 UTC).
0 [Headset        ]: USB-Audio - Logitech USB Headset
                     Logitech Logitech USB Headset at usb-0000:00:10.1-2,
full speed
1 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 with ALC655 at 0xe000, irq 22
2 [modem          ]: VIA82XX-MODEM - VIA 82XX modem
                     VIA 82XX modem at 0xe100, irq 22
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
 49: [1- 1]: digital audio playback
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl
 80: [2- 0]: digital audio playback
 88: [2- 0]: digital audio capture
 64: [2- 0]: ctl
00-00: USB Audio : USB Audio : playback 1 : capture 1
01-00: VIA 8235 : VIA 8235 : playback 4 : capture 1
01-01: VIA 8235 : VIA 8235 : playback 1 : capture 1
02-00: VIA 82XX modem : VIA 82XX modem : playback 1 : capture 1

Dev Snd ---------------------------------------------------
controlC0  controlC2  pcmC0D0p	pcmC1D0p  pcmC1D1p  pcmC2D0p
controlC1  pcmC0D0c   pcmC1D0c	pcmC1D1c  pcmC2D0c  timer

CPU -------------------------------------------------------
model name	: AMD Turion(tm) 64 Mobile Technology MT-30
cpu MHz		: 801.847

RAM -------------------------------------------------------
MemTotal:       959024 kB
SwapTotal:      262136 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0204
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1204
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2204
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3204
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4204
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7204
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge

It seems my product version is a bit old.
Is it possible the problem has already been solved?
I must check if they plan on putting a new version of alsa-utils in the
next Ubuntu release (Dapper Drake).
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-11-06 01:30 
----------------------------------------------------------------------
arecord -c 1 -d 10 -f cd -t wav -D hw:0,0 foobar.wav

Don't use hw:0, use plughw:0.  By using hw:0 you are telling ALSA to only
use the formats directly supported by the hardware.  It sounds like you
want to record mono but your hardware doesn't support that.

----------------------------------------------------------------------
 mkap - 05-21-06 19:20 
----------------------------------------------------------------------
Hey, it worked, Thank you very, very much. Sorry I haven't answered
earlier. Thank you again for the help. I'm gonna look into this hwplug
thing, my next goal will be. Can I find something to make skype work on my
PC? (with no microphone it seemed somewhat difficult :-). Thank you again

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-10-06 23:00 mkap           New Issue                                    
05-11-06 01:30 rlrevell       Note Added: 0009756                          
05-21-06 19:20 mkap           Note Added: 0009900                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
