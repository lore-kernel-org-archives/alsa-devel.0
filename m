From: Horacio de Oro <horacio@trimaxcba.com>
Subject: Mixer problem with VT8233/A/8235/8237 AC97 Audio Controller (rev
 60)
Date: Sat, 22 Jan 2005 00:54:40 -0300
Message-ID: <41F1CE80.1080302@trimaxcba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've a problem with the mixer of my sound card. It never has worked fine.

I run 'aumix', the /dev/mixer is opened fine:

horacio@corralito-ng:~$ lsof  /dev/mixer
COMMAND    PID    USER   FD   TYPE DEVICE SIZE NODE NAME
mixer_app  859 horacio   34u   CHR   14,0      5239 /dev/mixer0
aumix     1869 horacio    3u   CHR   14,0      5239 /dev/mixer0

I can change any volume control (for example: "CD"). While I move the 
control, I can hear the volume goes UP and DOWN, but I can't change the 
"main" volume, and I can't change the "PCM" volume (this control are on 
"top").

Something like this happens with "Gnome Volume Control", but with this 
application, I do can move "Volume" and "PCM" controls of the 
application, but the volume of the music doesn't chage (this time, I've 
checked this listeting some mp3 from xmms, mpg123, and totem).

My motherboard is a MSI KT6 Delta, with Debian unstable, kernel 
2.6.11-rc1. I've tested this with some version of Mandrake (version 10.0 
IIRC) and Knoppix, and the same happens with those distros.

As you can see, this isn't a "permission" problem. I think this isn't a 
kernel configuration related problem. The sound card works very well, 
the problem is the mixer.

Thanks in advance!

Horacio

PS: These outputs could be usefull:



#~ lspci

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:0a.0 Ethernet controller: Linksys NC100 Network Everywhere Fast 
Ethernet 10/100 (rev 11)
0000:00:0b.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T 
(rev 01)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce 
FX 5200] (rev a1)

#~ lspci -n
0000:00:00.0 0600: 1106:3189 (rev 80)
0000:00:01.0 0604: 1106:b198
0000:00:0a.0 0200: 1317:0985 (rev 11)
0000:00:0b.0 0200: 14e4:4401 (rev 01)
0000:00:0f.0 0101: 1106:0571 (rev 06)
0000:00:10.0 0c03: 1106:3038 (rev 81)
0000:00:10.1 0c03: 1106:3038 (rev 81)
0000:00:10.2 0c03: 1106:3038 (rev 81)
0000:00:10.3 0c03: 1106:3038 (rev 81)
0000:00:10.4 0c03: 1106:3104 (rev 86)
0000:00:11.0 0601: 1106:3227
0000:00:11.5 0401: 1106:3059 (rev 60)
0000:01:00.0 0300: 10de:0322 (rev a1)

#~ lsmod
Module                  Size  Used by
snd_pcm_oss            53344  0
snd_mixer_oss          20096  2 snd_pcm_oss
8250                   23876  0
serial_core            22528  1 8250
snd_via82xx            22432  2
snd_ac97_codec         77088  1 snd_via82xx
snd_pcm                92488  4 snd_pcm_oss,snd_via82xx,snd_ac97_codec
snd_timer              24772  1 snd_pcm
snd_page_alloc         10180  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7488  1 snd_via82xx
snd_rawmidi            23968  1 snd_mpu401_uart
snd                    54308  9 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi
soundcore               9440  2 snd
(...)

#~ cat /proc/asound/cards
0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with CMI9739 at 0xd800, irq 22


#~ cat /proc/asound/devices
  17: [0- 1]: digital audio playback
  25: [0- 1]: digital audio capture
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
   0: [0- 0]: ctl
  33:       : timer



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
