From: difrost@poczta.onet.pl
Subject: hwptr issue with CMI9880
Date: Fri, 12 Jan 2007 12:12:39 +0100
Message-ID: <20070112111244Z6522288-32090+24894@ps12.test.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hi All.

Recently I bought new 5.1 speakers and was trying to set 5.1 surround
sound with Alsa 1.0.14rc1. I didn't managed to do that using all
knowledge that can be found in Uncle Google, so I went into debug mode
and found following message (I also added some more variable prints so
this is ,,extended'' message) in my kernel log:

Jan 12 23:30:45 slawek kernel: ALSA /NORA/SlaP4/tmp/alsa-driver-1.0.14rc1/acore/../alsa-kernel/cor
e/pcm_lib.c:207: Unexpected hw_pointer value [1] (stream = 0, delta: -3, max jitter = 2730, period
s = 4, period size = 0x555, hw_ptr_base = 0x0, new_hw_ptr = 0x552, runtime->hw_ptr_interrupt = 0x0
, hw_ptr_interrupt = 0x555, pos = 0x552) : wrong interrupt acknowledge?
Jan 12 23:30:45 slawek kernel:  [<e02a8ceb>] snd_pcm_period_elapsed+0x1e6/0x339 [snd_pcm]
Jan 12 23:30:45 slawek kernel:  [<e0068cf4>] azx_interrupt+0x52/0x95 [snd_hda_intel]
Jan 12 23:30:45 slawek kernel:  [<c0131f75>] handle_IRQ_event+0x1a/0x3f
Jan 12 23:30:45 slawek kernel:  [<c01330ed>] handle_fasteoi_irq+0x7c/0xae
Jan 12 23:30:45 slawek kernel:  [<c0104f99>] do_IRQ+0x7d/0xa4
Jan 12 23:30:45 slawek kernel:  [<c01033ce>] common_interrupt+0x1a/0x20
Jan 12 23:30:45 slawek kernel:  [<c0100f2d>] mwait_idle_with_hints+0x3b/0x3f
Jan 12 23:30:45 slawek kernel:  [<c0100f3d>] mwait_idle+0xc/0x1b
Jan 12 23:30:45 slawek kernel:  [<c010193e>] cpu_idle+0x5e/0x74
Jan 12 23:30:45 slawek kernel:  [<c037b6ec>] start_kernel+0x338/0x340
Jan 12 23:30:45 slawek kernel:  [<c037b1ae>] unknown_bootoption+0x0/0x206
Jan 12 23:30:45 slawek kernel:  =======================


AFAIK this message is harmless if it comes from snd_pcm_update_hw_ptr
but in this case it comes from snd_pcm_update_hw_ptr_interrupt. It
looks like irq is not handled correctly - I think (not sure, I'm not
expert in that field). Message occurs also with pci=noacpi
specified. I haven't tried single_cmd, but can do that if
necessary. I don't know whether it is kernel or sloppy hardware
problem.

Now, more detailed information's about my setup:
1) Output from aadebug:
Kernel ----------------------------------------------------
Linux slawek 2.6.19.2 #1 SMP Fri Jan 12 19:55:58 CET 2007 i686 prescott i386 GNU/Linux

Loaded Modules --------------------------------------------
snd_hda_intel          15512  0 
snd_hda_codec         193792  1 snd_hda_intel
snd_pcm                67844  2 snd_hda_intel,snd_hda_codec
snd_timer              17668  1 snd_pcm
snd_page_alloc          7432  2 snd_hda_intel,snd_pcm
snd                    46444  5 snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer

Modprobe Conf ---------------------------------------------
alias snd-card-0 snd-hda-intel
options snd-hda-intel model=full
alias sound-slot-0 snd-hda-intel

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.14rc1.
Compiled on Jan 12 2007 for kernel 2.6.19.2 (SMP).
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xcfef4000 irq 16
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer
00-00: CMI9880 : CMI9880 : playback 1 : capture 2

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  timer

CPU -------------------------------------------------------
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz         : 3010.848
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
cpu MHz         : 3010.848

RAM -------------------------------------------------------
MemTotal:       508188 kB
SwapTotal:     2000084 kB

2) lspci
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio 
Controller (rev 03)
00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 1043:813d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2
B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <P
ERR-
        Latency: 0, Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at cfef4000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0


If You need more information's, please let me know. I've very limited
access to network so my answers might be delayed.

Best Regards
    Jacek Luczak

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
