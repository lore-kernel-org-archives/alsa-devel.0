From: "np" <np@f-matic.net>
Subject: usb audio problems
Date: Fri, 29 Aug 2003 15:25:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829192544.24790.qmail@mail1.qwknetllc.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


hello list, 

i'm crossposting this problem because it looks like it may be something more 
suited to the developers list. i'm having some problems getting sound to 
play through my emagic emi 2|6 usb soundcard. i've set up my internal sound 
card on slot 0, and the emi on slot 1. modules are loaded fine according to 
lsmod, and alsamixer seems to recognize the card fine. playing sound through 
the internal soundcard works fine, but when i attempt to use the emi card 
(with pd -alsadev 2) i get the following error messages: 

couldn't open MIDI input device 1
couldn't open MIDI output device 1
opened 0 MIDI input device(s) and 0 MIDI output device(s).
snd_pcm_hw_params_set_format (input): Invalid argument
snd_pcm_hw_params_set_format (input): Invalid argument
ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: 
Invalid argument
snd_pcm_hw_params (input): Invalid argument
ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: 
Invalid argument
ALSA lib pcm.c:1146:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed: File 
descriptor in bad state
ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: File 
descriptor in bad state
snd_pcm_start: File descriptor in bad state
Using ALSA interface
audio I/O stuck... closing audio 

 

could anyone here help diagnose what the problem is? i'm running debian sid 
on a 2.4.22 kernel, latest version of alsa. for the record, my lsmod shows: 

snd-usb-audio          44176   0
snd-rawmidi            15952   0  [snd-usb-audio]
snd-seq-device          5000   0  [snd-rawmidi]
snd-powermac           34996   0
i2c-core               14324   0  [snd-powermac]
snd-pcm                66180   0  [snd-usb-audio snd-powermac]
snd-timer              16580   0  [snd-pcm]
snd-page-alloc          4964   0  [snd-pcm]
snd                    35416   0  [snd-usb-audio snd-rawmidi snd-seq-device 
snd-powermac snd-pcm snd-timer]
soundcore               4168   0  [snd]
ds                      8268   1
yenta_socket           11792   1
pcmcia_core            44232   0  [ds yenta_socket]
ieee1394               49920   0  (unused)
emi26                 162192   0  (unused) 

any help would be appreciated! 

thanks,
nick


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
