From: Voluspa <voluspa@bigfoot.com>
Subject: A volume my mother would have liked ;-)
Date: Tue, 19 Feb 2002 20:37:12 +0100
Message-ID: <20020219203712.7982523a.voluspa@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from oden.fish.net (h139n1fls24o900.telia.com [213.66.143.139])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA00324
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 20:33:17 +0100
Received: from loke (IDENT:1000@loke.fish.net [192.168.111.2])
	by oden.fish.net (8.10.2/8.10.2) with SMTP id g1JJdNC06247
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 19:39:24 GMT
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


(Bear with my language - no programmer or sound expert)

Kernel 2.5.5-pre1 + isapnp patch + readable /proc/asound patch gave a working
dt0197h driver. But since the native OSS was broken (something with virt_to_bus_not_defined_use_pci_map) I had to go all ALSA with emulation.

No entries in /etc/modules.conf, modprobe snd-pcm-oss (to use existing /dev structure, from what I've read, I think...), modprobe snd-dt0197h gives sound, but:

The mute button in RealPlayer8 and the volume slider have absolutely no effect. And the physical button on my speakers just _slightly_ increase the volume (while increasing static).

At the moment I have no other sound-handling program compiled (new Linux From Scratch system). The Diamond Technologies card is a piece of s... but volume has never been an issue.

Some dumps after my Best regards,
Mats Johannesson
Sweden

"cat ./config"
[...]
#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

[...]
#
# Sound
#
CONFIG_SOUND=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
[...]
CONFIG_SND_DT0197H=m

loke:loke:~$ lsmod
Module                  Size  Used by    Not tainted
snd-dt0197h             2912   0
snd-sb16-dsp            5216   0 [snd-dt0197h]
snd-opl3-lib            5280   0 [snd-dt0197h]
snd-hwdep               3520   0 [snd-opl3-lib]
snd-sb-common           7352   0 [snd-dt0197h snd-sb16-dsp]
snd-mpu401-uart         2960   0 [snd-dt0197h snd-sb16-dsp]
snd-rawmidi            12736   0 [snd-mpu401-uart]
snd-pcm-oss            39072   0
snd-pcm                48864   0 [snd-sb16-dsp snd-pcm-oss]
snd-timer              10592   0 [snd-opl3-lib snd-pcm]
snd-mixer-oss           8960   0 [snd-pcm-oss]
snd                    25280   0 [snd-dt0197h snd-sb16-dsp snd-opl3-lib snd-hwdep snd-sb-common snd-mpu401-uart snd-rawmidi snd-pcm-oss snd-pcm snd-timer snd-mixer-oss]
soundcore               3428   0 [snd]
eepro100               17872   1

loke:loke:~$ cat /proc/asound/sndstat 
Sound Driver:3.8.1a-980706 (ALSA v0.9.0beta10 emulation code)
Kernel: Linux loke 2.5.5-pre1 #1 Tue Feb 19 17:05:45 CET 2002 i586
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
Diamond Tech. DT-0197H soundcard, Sound Blaster 16 at 0x220, irq 10, dma 1

Audio devices:
0: DSP v4.2 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: mixer00

If other info/dumps are needed, just ask.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
