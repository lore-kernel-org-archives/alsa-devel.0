From: maillist@superlative.org
Subject: Re: Boss GT-001
Date: Mon, 21 Sep 2015 11:22:18 +0100
Message-ID: <90207636.43oDPcFcXs@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f196.google.com (mail-wi0-f196.google.com
 [209.85.212.196])
 by alsa0.perex.cz (Postfix) with ESMTP id AABD526072A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 12:22:20 +0200 (CEST)
Received: by wicuu12 with SMTP id uu12so21224826wic.0
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 03:22:20 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id jf3sm12702878wic.8.2015.09.21.03.22.19
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Sep 2015 03:22:19 -0700 (PDT)
In-Reply-To: <1481883.Y22cmGKEIB@kamdesktop>
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

On Friday 18 Sep 2015 21:03:15 maillist@superlative.org wrote:
> I recently got access to a Boss GT-001. This is a small USB audio Interface
> for guitar with onboard FX which doesn't work with ALSA under Linux Mint 17
> (running kernel 3.16.0-38-generic).

<SNIP>

Following up on this, here's the output from aadebug:

ALSA Audio Debug v0.2.0 - Mon Sep 21 11:17:55 BST 2015
http://alsa.opensrc.org/aadebug
http://www.gnu.org/licenses/agpl-3.0.txt

Kernel ----------------------------------------------------
Linux KAMDesktop 3.16.0-38-generic #52~14.04.1-Ubuntu SMP Fri May 8 09:43:57 
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
Advanced Linux Sound Architecture Driver Version k3.16.0-38-generic.

Loaded Modules --------------------------------------------
snd_hrtimer            12744  0 
snd_seq_dummy          12762  0 
snd_usb_audio         161870  8 
snd_usbmidi_lib        29828  1 snd_usb_audio
snd_hwdep              17698  1 snd_usb_audio
snd_aloop              23396  0 
snd_pcm               104112  2 snd_usb_audio,snd_aloop
snd_seq_midi           13564  0 
snd_seq_midi_event     14899  1 snd_seq_midi
snd_rawmidi            30876  2 snd_usbmidi_lib,snd_seq_midi
snd_seq                63074  3 snd_seq_midi_event,snd_seq_dummy,snd_seq_midi
snd_seq_device         14497  4 snd_seq,snd_rawmidi,snd_seq_dummy,snd_seq_midi
snd_timer              29562  3 snd_hrtimer,snd_pcm,snd_seq
snd                    79468  25 
snd_usb_audio,snd_aloop,snd_hwdep,snd_timer,snd_pcm,snd_seq,snd_rawmidi,snd_usbmidi_lib,snd_seq_device

Proc Asound -----------------------------------------------
 0 [C920           ]: USB-Audio - HD Pro Webcam C920
                      HD Pro Webcam C920 at usb-0000:00:1d.7-4, high speed
 1 [Loopback       ]: Loopback - Loopback
                      Loopback 1
 2 [VS20           ]: USB-Audio - VS-20
                      Cakewalk VS-20 at usb-0000:00:1a.1-2, full speed
 3 [CODEC          ]: USB-Audio - USB Audio CODEC
                      Burr-Brown from TI USB Audio CODEC at 
usb-0000:00:1a.7-6.4, full speed
 4 [GT001          ]: USB-Audio - GT-001
                      BOSS GT-001 at usb-0000:00:1a.7-1, high speed
  1:        : sequencer
  2: [ 1]   : control
  3: [ 1- 0]: digital audio playback
  4: [ 1- 0]: digital audio capture
  5: [ 1- 1]: digital audio playback
  6: [ 1- 1]: digital audio capture
  7: [ 2]   : control
  8: [ 2- 0]: digital audio playback
  9: [ 2- 0]: digital audio capture
 10: [ 2- 0]: raw midi
 11: [ 0]   : control
 12: [ 0- 0]: digital audio capture
 13: [ 3]   : control
 14: [ 3- 0]: digital audio playback
 15: [ 3- 0]: digital audio capture
 16: [ 4]   : control
 17: [ 4- 0]: digital audio playback
 18: [ 4- 0]: digital audio capture
 19: [ 4- 0]: raw midi
 33:        : timer
00-00: USB Audio : USB Audio : capture 1
01-00: Loopback PCM : Loopback PCM : playback 8 : capture 8
01-01: Loopback PCM : Loopback PCM : playback 8 : capture 8
02-00: USB Audio : USB Audio : playback 1 : capture 1
03-00: USB Audio : USB Audio : playback 1 : capture 1
04-00: USB Audio : USB Audio : playback 1 : capture 1
Client info
  cur  clients : 4
  peak clients : 5
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client  14 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
  Port   1 : "Midi Through Port-1" (RWe-)
  Port   2 : "Midi Through Port-2" (RWe-)
  Port   3 : "Midi Through Port-3" (RWe-)
Client  24 : "VS-20" [Kernel]
  Port   0 : "VS-20 MIDI 1" (RWeX)
  Port   1 : "VS-20 MIDI 2" (RWeX)
Client  32 : "GT-001" [Kernel]
  Port   0 : "GT-001 MIDI 1" (RWeX)
  Port   1 : "GT-001 MIDI 2" (RWeX)
  Port   2 : "GT-001 MIDI 3" (RWeX)

Dev Snd ---------------------------------------------------
total 0
drwxr-xr-x  2 root root      120 Sep 21 11:17 by-id
drwxr-xr-x  2 root root      140 Sep 21 11:17 by-path
crw-rw----+ 1 root audio 116, 11 Sep 18 16:09 controlC0
crw-rw----+ 1 root audio 116,  2 Sep 18 16:09 controlC1
crw-rw----+ 1 root audio 116,  7 Sep 18 16:35 controlC2
crw-rw----+ 1 root audio 116, 13 Sep 18 16:09 controlC3
crw-rw----+ 1 root audio 116, 16 Sep 21 11:17 controlC4
crw-rw----+ 1 root audio 116, 10 Sep 18 16:35 midiC2D0
crw-rw----+ 1 root audio 116, 19 Sep 21 11:17 midiC4D0
crw-rw----+ 1 root audio 116, 12 Sep 21 11:17 pcmC0D0c
crw-rw----+ 1 root audio 116,  4 Sep 21 11:17 pcmC1D0c
crw-rw----+ 1 root audio 116,  3 Sep 21 11:17 pcmC1D0p
crw-rw----+ 1 root audio 116,  6 Sep 21 11:17 pcmC1D1c
crw-rw----+ 1 root audio 116,  5 Sep 21 11:17 pcmC1D1p
crw-rw----+ 1 root audio 116,  9 Sep 21 11:17 pcmC2D0c
crw-rw----+ 1 root audio 116,  8 Sep 21 11:17 pcmC2D0p
crw-rw----+ 1 root audio 116, 15 Sep 21 11:17 pcmC3D0c
crw-rw----+ 1 root audio 116, 14 Sep 21 11:17 pcmC3D0p
crw-rw----+ 1 root audio 116, 18 Sep 21 11:17 pcmC4D0c
crw-rw----+ 1 root audio 116, 17 Sep 21 11:17 pcmC4D0p
crw-rw----+ 1 root audio 116,  1 Sep 18 16:09 seq
crw-rw----+ 1 root audio 116, 33 Sep 18 16:09 timer

CPU -------------------------------------------------------
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964
model name      : Intel(R) Core(TM) i7 CPU         930  @ 2.80GHz
cpu MHz         : 3989.964

RAM -------------------------------------------------------
MemTotal:       18488420 kB
SwapTotal:      12572668 kB

Hardware --------------------------------------------------
03:00.0 VGA compatible controller: NVIDIA Corporation G96GL [Quadro FX 380] 
(rev a1)

Interupts -------------------------------------------------
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       
CPU6       CPU7       
   0:   48811951          0          0          0          0          0          
0          0   IO-APIC-edge      timer
   1:         11          0          0          0          0          0          
0          0   IO-APIC-edge      i8042
   8:          1          0          0          0          0          0          
0          0   IO-APIC-edge      rtc0
   9:          0          0          0          0          0          0          
0          0   IO-APIC-fasteoi   acpi
  12:         16          0          0          0          0          0          
0          0   IO-APIC-edge      i8042
  16:          0          0          0          0          0          0          
0          0   IO-APIC-fasteoi   uhci_hcd:usb3
  18:    5124556     163319     158327     437929          0          0          
0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb8, firewire_ohci
  19:     325267      13896      83955     159958          0          0          
0          0   IO-APIC-fasteoi   uhci_hcd:usb5, uhci_hcd:usb7
  21:    1036201          0     230710          0          0          0          
0          0   IO-APIC-fasteoi   uhci_hcd:usb4
  23:     592782      25702     353849    1661163          0          0          
0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
  66:         30          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  67:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  68:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  69:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  70:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  71:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  72:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  73:          0          0          0          0          0          0          
0          0   PCI-MSI-edge      xhci_hcd
  74:     115203      24153     263642     127794          0          0          
0          0   PCI-MSI-edge      ahci
  75:    2767659    2074057          0          0          0          0          
0          0   PCI-MSI-edge      eth0
  76:    1437112    1710820    1338068    1285065          0          0          
0          0   PCI-MSI-edge      ahci
  77:     250289          0          0          0          0          0          
0          0   PCI-MSI-edge      nvidia
 NMI:        782       3470       3412       3600      25175       1900       
1878       1889   Non-maskable interrupts
 LOC:    4034537   12008543   12954928   12367008    2650742    2731780    
2831859    2820759   Local timer interrupts
 SPU:          0          0          0          0          0          0          
0          0   Spurious interrupts
 PMI:        782       3470       3412       3600      25175       1900       
1878       1889   Performance monitoring interrupts
 IWI:          5          0          2          0          0          0          
0          0   IRQ work interrupts
 RTR:         17         17          0          0          0          0          
0          0   APIC ICR read retries
 RES:     670617     339489     307088     285022     147590     176059     
166329     156676   Rescheduling interrupts
 CAL:      59853      99019      93552     111099      79188     128309      
92115      99425   Function call interrupts
 TLB:     587943     504015     516238     537952     386062     372979     
395382     385494   TLB shootdowns
 TRM:          0          0          0          0          0          0          
0          0   Thermal event interrupts
 THR:          0          0          0          0          0          0          
0          0   Threshold APIC interrupts
 MCE:          0          0          0          0          0          0          
0          0   Machine check exceptions
 MCP:        488        486        486        486        486        486        
486        486   Machine check polls
 HYP:          0          0          0          0          0          0          
0          0   Hypervisor callback interrupts
 ERR:          0
 MIS:          0
