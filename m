From: Vlad Danego <vlad@vlad.danego.net>
Subject: Updated: via8233 driver -- testers wanted
Date: Thu, 30 May 2002 16:58:58 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020530135858.GA7977@vlad.danego.net>
Reply-To: vlad@al.lg.ua
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I was tested the last cvs version of via8233 driver (rev.1.18)
on a Soltek MB SL-75DRV4 (VIA266 chipset with VT8233A sb).
And it's not work. There is no sound via pcm.

>==================  dmesg  ==================
PCI: Setting latency timer of device 00:11.5 to 64
ALSA ../alsa-kernel/core/pcm_native.c:1093: playback drain error (DMA or IRQ trouble?)
>==================  dmesg  ==================

Kernel 2.4.19-pre9



>-----------------  moduses.conf
alias char-major-116 snd
alias snd-card-0 snd-via8233
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss


>------------------ lsmod | grep snd
snd-pcm-oss            44612   0  (autoclean)
snd-mixer-oss          10240   0  (autoclean) [snd-pcm-oss]
snd-via8233             5860   0 
snd-pcm                56608   0  [snd-pcm-oss snd-via8233]
snd-timer              11424   0  [snd-pcm]
snd-ac97-codec         24772   0  [snd-via8233]
snd                    30696   2  [snd-pcm-oss snd-mixer-oss snd-via8233 snd-pcm snd-timer snd-ac97-codec]
soundcore               3332   3  [snd]


>------------------ cat /proc/asound/cards
0 [card0          ]: VIA8233 - VIA 8233
                     VIA 8233 at 0xc000, irq 10


>------------------ cat /proc/asound/devices
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer


>------------------ cat /proc/asound/card0/ac97#0
0-0/0: ICEnsemble ICE1232

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Reserved 27

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz


>------------------ cat /proc/asound/oss/devices
  0: [0- 0]: mixer
  3: [0- 3]: digital audio
    

>----------------- cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc1 emulation code)
Kernel: Linux vlad.danego.net 2.4.19-pre9 #3 Wed May 29 15:07:40 EEST 2002 i686
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
VIA 8233 at 0xc000, irq 10

Audio devices:
0: VIA 8233 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: mixer00

>-----------------------------------------------


What is wrong?



	Thanks,
		Vlad
-- 
*=================================================
* Vlad Danego
*                          Nic-handles: VD437
* E-mail: vlad@al.lg.ua                 VLAD5-RIPE
*         vlad@vlad.danego.net          VLAD-UANIC
*=================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
