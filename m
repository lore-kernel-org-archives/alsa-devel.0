From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: snd_pcm_avail_delay() returned strange values: delay 0
 is less than avail 4.
Date: Sat, 27 Jun 2015 17:36:17 +1000
Message-ID: <20150627173617.1ade4161@korath.teln.shikadi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A72C3261584
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 09:36:40 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z8kfH-000071-AP
 for alsa-devel@alsa-project.org; Sat, 27 Jun 2015 09:36:39 +0200
Received: from 58.7.45.51 ([58.7.45.51])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 09:36:39 +0200
Received: from a.nielsen by 58.7.45.51 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 09:36:39 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to track down a problem with my media player (xmms2) where
it has stopped advancing to the next track after reaching the end of
the song.

I have the same distro with the same package versions on two slightly
different computers, and it works fine on one but not the other.  One
difference between the two is that although both have Intel HD Audio,
each is provided by a different type of chip.

I was asked to try pulseaudio to see if the problem persisted there and
it did, however upon loading the pulseaudio server it told me this:

E: [alsa-source-ALC892 Analog] alsa-util.c: snd_pcm_avail_delay() returned strange values: delay 0 is less than avail 4.
E: [alsa-source-ALC892 Analog] alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
E: [alsa-source-ALC892 Analog] alsa-util.c: snd_pcm_dump():
E: [alsa-source-ALC892 Analog] alsa-util.c: Direct Snoop PCM
E: [alsa-source-ALC892 Analog] alsa-util.c: Its setup is:
E: [alsa-source-ALC892 Analog] alsa-util.c:   stream       : CAPTURE
E: [alsa-source-ALC892 Analog] alsa-util.c:   access       : MMAP_INTERLEAVED
E: [alsa-source-ALC892 Analog] alsa-util.c:   format       : S32_LE
E: [alsa-source-ALC892 Analog] alsa-util.c:   subformat    : STD
E: [alsa-source-ALC892 Analog] alsa-util.c:   channels     : 2
E: [alsa-source-ALC892 Analog] alsa-util.c:   rate         : 48000
E: [alsa-source-ALC892 Analog] alsa-util.c:   exact rate   : 48000 (48000/1)
E: [alsa-source-ALC892 Analog] alsa-util.c:   msbits       : 32
E: [alsa-source-ALC892 Analog] alsa-util.c:   buffer_size  : 16384
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_size  : 1024
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_time  : 21333
E: [alsa-source-ALC892 Analog] alsa-util.c:   tstamp_mode  : ENABLE
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_step  : 1
E: [alsa-source-ALC892 Analog] alsa-util.c:   avail_min    : 15943
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_event : 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   start_threshold  : -1
E: [alsa-source-ALC892 Analog] alsa-util.c:   stop_threshold   : 4611686018427387904
E: [alsa-source-ALC892 Analog] alsa-util.c:   silence_threshold: 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   silence_size : 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   boundary     : 4611686018427387904
E: [alsa-source-ALC892 Analog] alsa-util.c: Hardware PCM card 1 'HDA Intel PCH' device 0 subdevice 0
E: [alsa-source-ALC892 Analog] alsa-util.c: Its setup is:
E: [alsa-source-ALC892 Analog] alsa-util.c:   stream       : CAPTURE
E: [alsa-source-ALC892 Analog] alsa-util.c:   access       : MMAP_INTERLEAVED
E: [alsa-source-ALC892 Analog] alsa-util.c:   format       : S32_LE
E: [alsa-source-ALC892 Analog] alsa-util.c:   subformat    : STD
E: [alsa-source-ALC892 Analog] alsa-util.c:   channels     : 2
E: [alsa-source-ALC892 Analog] alsa-util.c:   rate         : 48000
E: [alsa-source-ALC892 Analog] alsa-util.c:   exact rate   : 48000 (48000/1)
E: [alsa-source-ALC892 Analog] alsa-util.c:   msbits       : 32
E: [alsa-source-ALC892 Analog] alsa-util.c:   buffer_size  : 16384
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_size  : 1024
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_time  : 21333
E: [alsa-source-ALC892 Analog] alsa-util.c:   tstamp_mode  : ENABLE
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_step  : 1
E: [alsa-source-ALC892 Analog] alsa-util.c:   avail_min    : 1024
E: [alsa-source-ALC892 Analog] alsa-util.c:   period_event : 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   start_threshold  : 1
E: [alsa-source-ALC892 Analog] alsa-util.c:   stop_threshold   : 4611686018427387904
E: [alsa-source-ALC892 Analog] alsa-util.c:   silence_threshold: 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   silence_size : 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   boundary     : 4611686018427387904
E: [alsa-source-ALC892 Analog] alsa-util.c:   appl_ptr     : 0
E: [alsa-source-ALC892 Analog] alsa-util.c:   hw_ptr       : 8236

So I am reporting this in the hope that someone understands what the
problem is and knows how to fix it.

The wiki said to include the output of aadebug with a bug report, so
here's that:

ALSA Audio Debug v0.2.0 - Sat Jun 27 17:26:44 AEST 2015
http://alsa.opensrc.org/aadebug
http://www.gnu.org/licenses/agpl-3.0.txt

Kernel ----------------------------------------------------
Linux korath.teln.shikadi.net 4.0.6-1-ARCH #1 SMP PREEMPT Tue Jun 23 14:25:08 CEST 2015 x86_64 GNU/Linux
Advanced Linux Sound Architecture Driver Version k4.0.6-1-ARCH.

Loaded Modules --------------------------------------------
snd_hrtimer            16384  1 
snd_seq                61440  1 
snd_seq_device         16384  1 snd_seq
snd_hda_codec_hdmi     53248  1 
snd_hda_codec_realtek    65536  1 
snd_hda_codec_generic    65536  1 snd_hda_codec_realtek
snd_hda_intel          28672  9 
snd_hda_controller     28672  1 snd_hda_intel
snd_hda_codec         114688  5 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller
snd_hwdep              16384  1 snd_hda_codec
snd_pcm                90112  6 snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller
snd_timer              28672  5 snd_hrtimer,snd_pcm,snd_seq
snd                    69632  25 snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_hda_codec_generic,snd_hda_codec,snd_hda_intel,snd_seq_device

Proc Asound -----------------------------------------------
 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf7c34000 irq 30
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7c30000 irq 28
  1:        : sequencer
  2: [ 1]   : control
  3: [ 1- 0]: digital audio playback
  4: [ 1- 0]: digital audio capture
  5: [ 1- 1]: digital audio playback
  6: [ 1- 2]: digital audio capture
  7: [ 1- 0]: hardware dependent
  8: [ 0]   : control
  9: [ 0- 3]: digital audio playback
 10: [ 0- 7]: digital audio playback
 11: [ 0- 0]: hardware dependent
 33:        : timer
01-00: HDA Codec 0
00-00: HDA Codec 0
00-03: HDMI 0 : HDMI 0 : playback 1
00-07: HDMI 1 : HDMI 1 : playback 1
01-00: ALC892 Analog : ALC892 Analog : playback 1 : capture 1
01-01: ALC892 Digital : ALC892 Digital : playback 1
01-02: ALC892 Alt Analog : ALC892 Alt Analog : capture 1
Client info
  cur  clients : 2
  peak clients : 2
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client  14 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
Client 128 : "TiMidity" [User]
  Port   0 : "TiMidity port 0" (-We-)
  Port   1 : "TiMidity port 1" (-We-)
  Port   2 : "TiMidity port 2" (-We-)
  Port   3 : "TiMidity port 3" (-We-)
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0
  Input pool :
    Pool size          : 1000
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0

Dev Snd ---------------------------------------------------
total 0
drwxr-xr-x  2 root root       80 Jun 27 13:31 by-path
crw-rw----+ 1 root audio 116,  8 Jun 27 13:31 controlC0
crw-rw----+ 1 root audio 116,  2 Jun 27 13:31 controlC1
crw-rw----+ 1 root audio 116, 11 Jun 27 13:31 hwC0D0
crw-rw----+ 1 root audio 116,  7 Jun 27 13:31 hwC1D0
crw-rw----+ 1 root audio 116,  9 Jun 27 17:12 pcmC0D3p
crw-rw----+ 1 root audio 116, 10 Jun 27 17:12 pcmC0D7p
crw-rw----+ 1 root audio 116,  4 Jun 27 17:12 pcmC1D0c
crw-rw----+ 1 root audio 116,  3 Jun 27 17:13 pcmC1D0p
crw-rw----+ 1 root audio 116,  5 Jun 27 13:31 pcmC1D1p
crw-rw----+ 1 root audio 116,  6 Jun 27 13:31 pcmC1D2c
crw-rw----+ 1 root audio 116,  1 Jun 27 13:31 seq
crw-rw----+ 1 root audio 116, 33 Jun 27 13:31 timer

CPU -------------------------------------------------------
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3097.500
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3000.000
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3295.664
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3120.703
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3001.406
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3000.351
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3645.585
model name      : Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz
cpu MHz         : 3000.468

RAM -------------------------------------------------------
MemTotal:       16362900 kB
SwapTotal:             0 kB

Hardware --------------------------------------------------
00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor Integrated Graphics Controller (rev 06)
00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset High Definition Audio Controller (rev 04)

Interupts -------------------------------------------------
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
  0:         19          0          0          0          0          0          0          0   IO-APIC-edge      timer
  1:          1          0          0          0          0          0          0          1   IO-APIC-edge      i8042
  7:          9          0          0          0          0          0          0          0   IO-APIC-edge
  8:          0          0          0          1          0          0          0          0   IO-APIC-edge      rtc0
  9:          1          0          0          0          1          0          0          1   IO-APIC-fasteoi   acpi
 16:         20          0          0          0          4          1          3          1   IO-APIC  16-fasteoi   ehci_hcd:usb1
 23:         23          0          5          0          2          1          1          1   IO-APIC  23-fasteoi   ehci_hcd:usb2
 24:     236257      13391      10344       8635       7919       6578       6237       5429   PCI-MSI-edge      xhci_hcd
 25:      27200       5286       3884       3536      10293       3395       2433       1864   PCI-MSI-edge      0000:00:1f.2
 26:          3          6          0          0          0          2          0          2   PCI-MSI-edge      mei_me
 27:     231790      38059      33089      33480      38333      18853      15356      13578   PCI-MSI-edge      eth0
 28:     549701      20320      18918      16545      17439      14054      12933      11245   PCI-MSI-edge      snd_hda_intel
 29:       1936        799        524        368        520        541        356        265   PCI-MSI-edge      i915
 30:         25        272         13          2        477        200          8          2   PCI-MSI-edge      snd_hda_intel
NMI:         15         14         14         14          9          7          9         10   Non-maskable interrupts
LOC:    1051971     756503     703396     726403     198333     221752     198703     213191   Local timer interrupts
SPU:          0          0          0          0          0          0          0          0   Spurious interrupts
PMI:         15         14         14         14          9          7          9         10   Performance monitoring interrupts
IWI:          0          0          0          0          0          0          1          0   IRQ work interrupts
RTR:          7          0          0          0          0          0          0          0   APIC ICR read retries
RES:      13573      10138       7672       8132       3954       3624       3500       2935   Rescheduling interrupts
CAL:      32694      13897      13827      14113        968       1025       1057       1107   Function call interrupts
TLB:       7503       7559       9116      13064       9259       6773       5330       4805   TLB shootdowns
TRM:          0          0          0          0          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0          0          0          0          0   Machine check exceptions
MCP:         48         48         48         48         48         48         48         48   Machine check polls
HYP:          0          0          0          0          0          0          0          0   Hypervisor callback interrupts
ERR:          9
MIS:          0

Please let me know if I can provide any other info.

Many thanks,
Adam.
