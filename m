From: =?UTF-8?B?T25kcmVqIEl2YW5pxI0=?= <ondrej@kmit.sk>
Subject: Bt87x Audio Capture
Date: Wed, 08 Mar 2006 22:39:18 +0100
Message-ID: <440F4F06.4030904@kmit.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi

I have problems with audio capture function on my tv card. After 
`modprobe snd_bt87x', I have got nothing in logs (dmesg, messages).

Last relevant info is from bt878 module:

bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
PCI: Found IRQ 12 for device 0000:00:0a.1
PCI: Sharing IRQ 12 with 0000:00:0a.0
bt878(0): Bt878 (rev 17) at 00:0a.1, irq: 12, latency: 64, memory: 
0xe9000000
PCI: Found IRQ 10 for device 0000:00:0c.0
PCI: Sharing IRQ 10 with 0000:00:07.2

lspci output:
$ lspci -s 00:0a -vn
00:0a.0 0400: 109e:036e (rev 11)
         Subsystem: 11bd:0012
         Flags: bus master, medium devsel, latency 64, IRQ 12
         Memory at e9002000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2

00:0a.1 0480: 109e:0878 (rev 11)
         Subsystem: 11bd:0012
         Flags: bus master, medium devsel, latency 64, IRQ 12
         Memory at e9000000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2

$ lspci -s 00:0a
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)

alsa configuration:

alias snd-card-0 snd-ens1371
alias snd-card-1 snd-bt87x
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1

options snd-bt87x id="tv" load_all=1

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
##  OSS/Free portion - card #2
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

options snd cards_limit=2

lsmod output:
$ lsmod
Module                  Size  Used by
snd_bt87x              11496  0
snd_seq_midi            6816  0
snd_pcm_oss            49440  0
snd_mixer_oss          17088  1 snd_pcm_oss
snd_seq_oss            31552  0
snd_seq_midi_event      5664  2 snd_seq_midi,snd_seq_oss
snd_seq                47824  5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_ens1371            18596  0
snd_rawmidi            19840  2 snd_seq_midi,snd_ens1371
snd_seq_device          6732  4 snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi
snd_ac97_codec         93088  1 snd_ens1371
snd_ac97_bus            1728  1 snd_ac97_codec
bt878                   8088  0
tuner                  43012  0
tda9887                14352  0
msp3400                32848  0
bttv                  158480  1 bt878
video_buf              17060  1 bttv
i2c_algo_bit            8360  1 bttv
btcx_risc               3912  1 bttv
tveeprom               13744  1 bttv
i2c_core               16752  6 
tuner,tda9887,msp3400,bttv,i2c_algo_bit,tveeprom
snd_pcm                79976  4 
snd_bt87x,snd_pcm_oss,snd_ens1371,snd_ac97_codec
snd_timer              20580  2 snd_seq,snd_pcm
snd                    44804  11 
snd_bt87x,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_ens1371,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer
soundcore               7168  1 snd
snd_page_alloc          8424  2 snd_bt87x,snd_pcm

I don't have an idea what is wrong, because I can't found any output 
from snd_bt87x module.

Thanks

PS. I'm not on the list. Send CC to me, please.

-- 
Ondrej Ivanic
(ondrej@kmit.sk)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
