From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001609]: Sound Blaster 24bit (SB0410) PCI card (in PCI-X slot) not producing any sound
Date: Wed, 30 Nov 2005 17:55:17 +0100
Message-ID: <a6a11cd50300595f824f068c719fd23b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 69F71168
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2005 17:55:17 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1609> 
======================================================================
Reported By:                esgeraul
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1609
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.2
Kernel Version:             2.6.14.2
======================================================================
Date Submitted:             11-30-2005 17:55 CET
Last Modified:              11-30-2005 17:55 CET
======================================================================
Summary:                    Sound Blaster 24bit (SB0410) PCI card (in PCI-X
slot) not producing any sound
Description: 
(see also the alsa-user thread with the same subject.)

The card is recognized, all modules load, mixer settings are ok. But aplay
playing a wav file hangs while never producing any sound. 

Tested with alsa 1.0.9 and 1.0.10, kernel version 2.6.14.2 (stock,
non-suse)


aadebug output:

ALSA Audio Debug v0.1.0 - Wed Nov 30 17:58:27 CET 2005
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt
 
Kernel ----------------------------------------------------
Linux pipe 2.6.14.2 #4 SMP PREEMPT Wed Nov 30 11:43:20 CET 2005 i686 i686
i386 GNU/Linux
 
Loaded Modules --------------------------------------------
snd_pcm_oss            56992  0
snd_mixer_oss          22912  1 snd_pcm_oss
snd_ca0106             34596  0
snd_ac97_codec         94332  1 snd_ca0106
snd_pcm                97412  3 snd_pcm_oss,snd_ca0106,snd_ac97_codec
snd_timer              30084  1 snd_pcm
snd                    59876  6
snd_pcm_oss,snd_mixer_oss,snd_ca0106,snd_ac97_codec,snd_pcm,snd_timer
snd_ac97_bus            6400  1 snd_ac97_codec
snd_page_alloc         14728  2 snd_ca0106,snd_pcm
 
Proc Config -----------------------------------------------
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
CONFIG_SND_CA0106=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SOUND_PRIME is not set
 
Modprobe Conf ---------------------------------------------
# remove this if sound is configured
#alias char-major-116 snd
#alias snd-card-0 snd-ca0106
#alias char-major-14 soundcore
#alias sound-slot-0 snd-card-0
#alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
#alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
#alias sound-service-0-12 snd-pcm-oss
#alias sound-slot-1 nvaudio
 
Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
0 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0410] at 0x3000 irq 233
 19: [0- 3]: digital audio playback
 27: [0- 3]: digital audio capture
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
cat: /proc/asound/hwdep: No such file or directory
00-00: ca0106 : CA0106 : playback 1 : capture 1
00-01: ca0106 : CA0106 : playback 1 : capture 1
00-02: ca0106 : CA0106 : playback 1 : capture 1
00-03: ca0106 : CA0106 : playback 1 : capture 1
cat: /proc/asound/seq/clients: No such file or directory
 
Dev Snd ---------------------------------------------------
controlC0  hwC5D2    midiC2D4  midiC6D2  pcmC1D0c  pcmC2D7c  pcmC4D6c 
pcmC6D5c
controlC1  hwC5D3    midiC2D5  midiC6D3  pcmC1D0p  pcmC2D7p  pcmC4D6p 
pcmC6D5p
controlC2  hwC6D0    midiC2D6  midiC6D4  pcmC1D1c  pcmC3D0c  pcmC4D7c 
pcmC6D6c
controlC3  hwC6D1    midiC2D7  midiC6D5  pcmC1D1p  pcmC3D0p  pcmC4D7p 
pcmC6D6p
controlC4  hwC6D2    midiC3D0  midiC6D6  pcmC1D2c  pcmC3D1c  pcmC5D0c 
pcmC6D7c
controlC5  hwC6D3    midiC3D1  midiC6D7  pcmC1D2p  pcmC3D1p  pcmC5D0p 
pcmC6D7p
controlC6  hwC7D0    midiC3D2  midiC7D0  pcmC1D3c  pcmC3D2c  pcmC5D1c 
pcmC7D0c
controlC7  hwC7D1    midiC3D3  midiC7D1  pcmC1D3p  pcmC3D2p  pcmC5D1p 
pcmC7D0p
hwC0D0     hwC7D2    midiC3D4  midiC7D2  pcmC1D4c  pcmC3D3c  pcmC5D2c 
pcmC7D1c
hwC0D1     hwC7D3    midiC3D5  midiC7D3  pcmC1D4p  pcmC3D3p  pcmC5D2p 
pcmC7D1p
hwC0D2     midiC0D0  midiC3D6  midiC7D4  pcmC1D5c  pcmC3D4c  pcmC5D3c 
pcmC7D2c
hwC0D3     midiC0D1  midiC3D7  midiC7D5  pcmC1D5p  pcmC3D4p  pcmC5D3p 
pcmC7D2p
hwC1D0     midiC0D2  midiC4D0  midiC7D6  pcmC1D6c  pcmC3D5c  pcmC5D4c 
pcmC7D3c
hwC1D1     midiC0D3  midiC4D1  midiC7D7  pcmC1D6p  pcmC3D5p  pcmC5D4p 
pcmC7D3p
hwC1D2     midiC0D4  midiC4D2  pcmC0D0c  pcmC1D7c  pcmC3D6c  pcmC5D5c 
pcmC7D4c
hwC1D3     midiC0D5  midiC4D3  pcmC0D0p  pcmC1D7p  pcmC3D6p  pcmC5D5p 
pcmC7D4p
hwC2D0     midiC0D6  midiC4D4  pcmC0D1c  pcmC2D0c  pcmC3D7c  pcmC5D6c 
pcmC7D5c
hwC2D1     midiC0D7  midiC4D5  pcmC0D1p  pcmC2D0p  pcmC3D7p  pcmC5D6p 
pcmC7D5p
hwC2D2     midiC1D0  midiC4D6  pcmC0D2c  pcmC2D1c  pcmC4D0c  pcmC5D7c 
pcmC7D6c
hwC2D3     midiC1D1  midiC4D7  pcmC0D2p  pcmC2D1p  pcmC4D0p  pcmC5D7p 
pcmC7D6p
hwC3D0     midiC1D2  midiC5D0  pcmC0D3c  pcmC2D2c  pcmC4D1c  pcmC6D0c 
pcmC7D7c
hwC3D1     midiC1D3  midiC5D1  pcmC0D3p  pcmC2D2p  pcmC4D1p  pcmC6D0p 
pcmC7D7p
hwC3D2     midiC1D4  midiC5D2  pcmC0D4c  pcmC2D3c  pcmC4D2c  pcmC6D1c 
seq
hwC3D3     midiC1D5  midiC5D3  pcmC0D4p  pcmC2D3p  pcmC4D2p  pcmC6D1p 
timer
hwC4D0     midiC1D6  midiC5D4  pcmC0D5c  pcmC2D4c  pcmC4D3c  pcmC6D2c
hwC4D1     midiC1D7  midiC5D5  pcmC0D5p  pcmC2D4p  pcmC4D3p  pcmC6D2p
hwC4D2     midiC2D0  midiC5D6  pcmC0D6c  pcmC2D5c  pcmC4D4c  pcmC6D3c
hwC4D3     midiC2D1  midiC5D7  pcmC0D6p  pcmC2D5p  pcmC4D4p  pcmC6D3p
hwC5D0     midiC2D2  midiC6D0  pcmC0D7c  pcmC2D6c  pcmC4D5c  pcmC6D4c
hwC5D1     midiC2D3  midiC6D1  pcmC0D7p  pcmC2D6p  pcmC4D5p  pcmC6D4p
 
CPU -------------------------------------------------------
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
cpu MHz         : 2800.781
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
cpu MHz         : 2800.781
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
cpu MHz         : 2800.781
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
cpu MHz         : 2800.781
 
RAM -------------------------------------------------------
MemTotal:      1033828 kB
SwapTotal:     1052216 kB
 
Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corp. E7520 Memory Controller Hub (rev
0c)
0000:02:03.0 Multimedia audio controller: Creative Labs SB Audigy LS


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-30-05 17:55 esgeraul       New Issue                                    
11-30-05 17:55 esgeraul       Distribution              => SuSE 9.2        
11-30-05 17:55 esgeraul       Kernel Version            => 2.6.14.2        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
