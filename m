From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9652 - Some first results, but lockups and
	no actual audio
Date: 12 Apr 2003 21:21:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050175294.1415.638.camel@satellite.undata.org>
References: <1050169066.1183.31.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050169066.1183.31.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, PlanetCCRMA <planetccrma@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org


> post-install snd-hdsp /usr/bin/hdsploader
> [root@Wizard etc]#
> 
> 
> [root@Wizard etc]# hdsploader
> hdsploader - firmware loader for RME Hammerfall DSP cards
> Looking for HDSP + Multiface or Digiface cards :
> Card 0 : RME HDSP 9652 at 0xe8800000, irq 10
> [root@Wizard etc]#
> 
> 

Note that you do not need to run hdsploader with the HDSP9652 card.
Note too that one wouldn't need superuser privileges for the tool to
work, anyway.

> 
> [root@Wizard root]# lsmod
> Module                  Size  Used by    Not tainted
> ide-cd                 35548   0  (autoclean)
> cdrom                  33344   0  (autoclean) [ide-cd]
> snd-mixer-oss          16536   2  (autoclean)
> snd-seq-midi            5280   0  (unused)
> snd-seq-midi-event      5928   0  [snd-seq-midi]
> snd-seq                49648   0  [snd-seq-midi snd-seq-midi-event]
> snd-hdsp               39212   2
> snd-pcm                85888   0  [snd-hdsp]
> snd-page-alloc          8452   0  [snd-pcm]
> snd-timer              20776   0  [snd-seq snd-pcm]
> snd-rawmidi            19712   0  [snd-seq-midi snd-hdsp]
> snd-seq-device          6380   0  [snd-seq-midi snd-seq snd-rawmidi]
> snd-hwdep               7008   0  [snd-hdsp]
> snd                    44836   0  [snd-mixer-oss snd-seq-midi
> snd-seq-midi-event snd-seq snd-hdsp snd-pcm snd-timer snd-rawmidi
> snd-seq-device snd-hwdep]
> soundcore               6724   5  [snd]
> snd-hammerfall-mem      2976   0  [snd-hdsp]
> autofs                 13588   0  (autoclean) (unused)
> bcm4400                31136   1
> ipt_REJECT              3928   6  (autoclean)
> iptable_filter          2412   1  (autoclean)
> ip_tables              14904   2  [ipt_REJECT iptable_filter]
> ohci1394               29224   0  (unused)
> ieee1394               60044   0  [ohci1394]
> mousedev                5588   0  (unused)
> keybdev                 2912   0  (unused)
> hid                    22148   0  (unused)
> input                   5824   0  [mousedev keybdev hid]
> usb-uhci               27116   0  (unused)
> ehci-hcd               20488   0  (unused)
> usbcore                79840   1  [hid usb-uhci ehci-hcd]
> ext3                   71808   1
> jbd                    53908   1  [ext3]
> [root@Wizard root]#
> 
> 
> [root@Wizard root]# cat /proc/interrupts
>            CPU0
>   0:    1977701          XT-PIC  timer
>   1:       8743          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:       2178          XT-PIC  eth0
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  ehci-hcd, usb-uhci, usb-uhci, usb-uhci
>  10:      57026          XT-PIC  hdsp
>  11:          2          XT-PIC  ohci1394
>  12:      48832          XT-PIC  PS/2 Mouse
>  14:      13159          XT-PIC  ide0
>  15:       9355          XT-PIC  ide1
> NMI:          0
> LOC:    1977713
> ERR:       2364
> MIS:          0
> [root@Wizard root]#
> 
> 
> [root@Wizard card0]# more /proc/asound/card0/hdsp
> RME HDSP 9652 (Card #1)
> Buffers: capture dde00000 playback ddc00000
> IRQ: 10 Registers bus: 0xe8800000 VM: 0xe0967000
> Control register: 0x1008098
> Status register: 0x6086a48
> Status2 register: 0xffff8061
> FIFO status: 0
> MIDI1 Output status: 0xffffff00
> MIDI1 Input status: 0xffffff80
> MIDI2 Output status: 0xffffff00
> MIDI2 Input status: 0xffffff5f
> 
> Buffer Size (Latency): 1024 samples (2 periods of 4096 bytes)
> Hardware pointer (frames): 1024
> Passthru: no
> Line out: on
> Firmware version: 1
> 
> Sample Clock Source: Internal 44.1 kHz
> Preferred Sync Reference: ADAT1
> AutoSync Reference: ADAT1
> AutoSync Frequency: 48000
> System Clock Mode: Master
> System Clock Frequency: 44100
> 
> IEC958 input: Internal
> IEC958 output: Coaxial only
> IEC958 quality: Consumer
> IEC958 emphasis: off
> IEC958 NonAudio: off
> IEC958 sample rate: Error flag set
> 
> ADAT1: Lock
> ADAT2: No Lock
> ADAT3: No Lock
> SPDIF: No Lock
> Word Clock: No Lock
> ADAT Sync: No Lock
> 
> [root@Wizard card0]#

> 
This looks good to me.

The way the matrix mixer is handled for the HDSP9652 series differs from
the cardbus/pci Digiface/Multiface. It looks to me like the mixer offset
from the iobase is wrong. This could explain both the absence of sound
and the locks. I need to put a hand on a HDSP9652 card to investigate
this.

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
