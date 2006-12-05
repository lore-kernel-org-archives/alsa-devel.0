From: "Ciprian Sturza" <ciprian.sturza@gmail.com>
Subject: Problems with nVidia Corporation MCP61 High Definition
	Audio
Date: Tue, 5 Dec 2006 11:09:38 +0200
Message-ID: <88e62d960612050109j15a4a41y2b491c9a8e046f47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0992749099=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--===============0992749099==
Content-Type: multipart/alternative;
	boundary="----=_Part_2418_16426258.1165309778942"

------=_Part_2418_16426258.1165309778942
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

     Hello!
     I have a problem installing my soundcard on fedora core 6 (PC, AMD
Sempron 2800+, AsRock AM2NF6G-VSTA - motherboard) .

    The PCI Audio is nVidia Corporation MCP61 High Definition Audio and the
kernel that i just installed is 2.6.18.3

    I have installed the alsa driver (version 1.0.13), the library and  the
utilities (the same version) just like is indicated on your documentation.

    I have created the snd devices and chmod them.

    I have compiled and installed the alsa driver using the following
        configure command options:
           ./configure --with-cards=intel8x0 --with-sequencer=yes;make;make
install

    After everything was successfully installed i have loaded the modules
into the kernel like this:
        modprobe snd-intel8x0;modprobe snd-pcm-oss;modprobe
        snd-mixer-oss;modprobe snd-seq-oss

    The lsmod command shows this:
        Module                  Size  Used by
        snd_intel8x0           37020  0
        snd_ac97_codec        100260  1 snd_intel8x0
        snd_ac97_bus            6656  1 snd_ac97_codec
        snd_seq_oss            39040  0
        snd_seq_midi_event     12032  1 snd_seq_oss
        snd_seq                57840  4 snd_seq_oss,snd_seq_midi_event
        snd_seq_device         12684  2 snd_seq_oss,snd_seq
        snd_pcm_oss            47232  0
        snd_mixer_oss          21120  1 snd_pcm_oss
        snd_pcm                82180  3
        snd_intel8x0,snd_ac97_codec,snd_pcm_oss
        snd_timer              26756  2 snd_seq,snd_pcm
        snd                    59140  9


snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,sn
        d_mixer_oss,snd_pcm,snd_timer soundcore              14176  1 snd
        snd_page_alloc         14344  2 snd_intel8x0,snd_pcm

        I got no error and no card is being detected at this stage
        in /proc/asound/cards

        # ls -lsa /proc/asound/
        total 0
        0 dr-xr-xr-x   4 root root 0 Nov 30 19:50 .
        0 dr-xr-xr-x 120 root root 0 Nov 30  2006 ..
        0 -r--r--r--   1 root root 0 Nov 30 19:50 cards
        0 -r--r--r--   1 root root 0 Nov 30 19:50 devices
        0 -r--r--r--   1 root root 0 Nov 30 19:50 modules
        0 dr-xr-xr-x   2 root root 0 Nov 30 19:50 oss
        0 -r--r--r--   1 root root 0 Nov 30 19:50 pcm
        0 dr-xr-xr-x   2 root root 0 Nov 30 19:50 seq
        0 -r--r--r--   1 root root 0 Nov 30 19:50 timers
        0 -r--r--r--   1 root root 0 Nov 30 19:50 version

        # cat /proc/asound/cards
        --- no soundcards ---

        Here is the lspci output:
        # lspci
        00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev
a1)
        00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)
        00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
        00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev
a2)
        00:01.3 Co-processor: nVidia Corporation MCP61 SMU (rev a2)
        00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev
a2)
        00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev
a2)
        00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1)
        00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio
(rev a2)
        00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2)
        00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
        00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev
a2)
        00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev
a2)
        00:0b.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev
a2)
        00:0c.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev
a2)
        00:0d.0 VGA compatible controller: nVidia Corporation GeForce 6100
        nForce 405 (rev a2)
        00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron]
        HyperTransport Technology Configuration
        00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron]
        Address Map
        00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron]
        DRAM Controller
        00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron]
        Miscellaneous Control

        And the details for the sound card (lspci again):
        # lspci -vvv
        00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio
(rev a2)
                Subsystem: ASRock Incorporation Unknown device 0888
                Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop-ParErr- Stepping- SERR- FastB2B-
                Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
                Latency: 0 (500ns min, 1250ns max)
                Interrupt: pin B routed to IRQ 10
                Region 0: Memory at dfff8000 (32-bit, non-prefetchable)
        [size=16K]
                Capabilities: [44] Power Management version 2
                        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
        PME(D0-,D1-,D2-,D3hot+,D3cold+)
                        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Capabilities: [50] Message Signalled Interrupts: 64bit+
        Queue=0/0 Enable-
                        Address: 0000000000000000  Data: 0000
                Capabilities: [6c] HyperTransport: MSI Mapping

        The alsaconf command says no sound card could be detected on my
system, which seems to be true as /proc/asound has no reference to the sound
     card.

        I need a little help please! I will wait for an answer on this email
address.


        With Regards,
        Ciprian Sturza.

------=_Part_2418_16426258.1165309778942
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;&nbsp;&nbsp;&nbsp; Hello!<br>&nbsp;&nbsp;&nbsp;&nbsp; I have a problem installing my soundcard on fedora core 6 (PC, AMD Sempron 2800+, AsRock AM2NF6G-VSTA - motherboard) .<br><br>&nbsp;&nbsp;&nbsp; The PCI Audio is nVidia Corporation MCP61 High Definition Audio and the kernel that i just installed is 
<a href="http://2.6.18.3">2.6.18.3</a><br><br>&nbsp;&nbsp;&nbsp; I have installed the alsa driver (version 1.0.13), the library and&nbsp; the utilities (the same version) just like is indicated on your documentation.<br><br>&nbsp; &nbsp; I have created the snd devices and chmod them.
<br><br>&nbsp; &nbsp; I have compiled and installed the alsa driver using the following<br>&nbsp; &nbsp; &nbsp; &nbsp; configure command options:<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;./configure --with-cards=intel8x0 --with-sequencer=yes;make;make install<br><br>&nbsp; &nbsp; After everything was successfully installed i have loaded the modules into the kernel like this:
<br>&nbsp; &nbsp; &nbsp; &nbsp; modprobe snd-intel8x0;modprobe snd-pcm-oss;modprobe<br>&nbsp; &nbsp; &nbsp; &nbsp; snd-mixer-oss;modprobe snd-seq-oss<br><br>&nbsp;&nbsp;&nbsp; The lsmod command shows this:<br>&nbsp; &nbsp; &nbsp; &nbsp; Module &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Size &nbsp;Used by<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_intel8x0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 37020 &nbsp;0
<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_ac97_codec &nbsp; &nbsp; &nbsp; &nbsp;100260 &nbsp;1 snd_intel8x0<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_ac97_bus &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;6656 &nbsp;1 snd_ac97_codec<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_seq_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;39040 &nbsp;0<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_seq_midi_event &nbsp; &nbsp; 12032 &nbsp;1 snd_seq_oss<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_seq &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;57840 &nbsp;4 snd_seq_oss,snd_seq_midi_event
<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_seq_device &nbsp; &nbsp; &nbsp; &nbsp; 12684 &nbsp;2 snd_seq_oss,snd_seq<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_pcm_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;47232 &nbsp;0<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_mixer_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;21120 &nbsp;1 snd_pcm_oss<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_pcm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;82180 &nbsp;3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_intel8x0,snd_ac97_codec,snd_pcm_oss
<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_timer &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;26756 &nbsp;2 snd_seq,snd_pcm<br>&nbsp; &nbsp; &nbsp; &nbsp; snd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;59140 &nbsp;9<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,sn<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d_mixer_oss,snd_pcm,snd_timer soundcore &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;14176 &nbsp;1 snd
<br>&nbsp; &nbsp; &nbsp; &nbsp; snd_page_alloc &nbsp; &nbsp; &nbsp; &nbsp; 14344 &nbsp;2 snd_intel8x0,snd_pcm<br><br>&nbsp; &nbsp; &nbsp; &nbsp; I got no error and no card is being detected at this stage<br>&nbsp; &nbsp; &nbsp; &nbsp; in /proc/asound/cards<br><br>&nbsp; &nbsp; &nbsp; &nbsp; # ls -lsa /proc/asound/<br>&nbsp; &nbsp; &nbsp; &nbsp; total 0
<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 dr-xr-xr-x &nbsp; 4 root root 0 Nov 30 19:50 .<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 dr-xr-xr-x 120 root root 0 Nov 30 &nbsp;2006 ..<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 cards<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 devices
<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 modules<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 dr-xr-xr-x &nbsp; 2 root root 0 Nov 30 19:50 oss<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 pcm<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 dr-xr-xr-x &nbsp; 2 root root 0 Nov 30 19:50 seq
<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 timers<br>&nbsp; &nbsp; &nbsp; &nbsp; 0 -r--r--r-- &nbsp; 1 root root 0 Nov 30 19:50 version<br><br>&nbsp; &nbsp; &nbsp; &nbsp; # cat /proc/asound/cards<br>&nbsp; &nbsp; &nbsp; &nbsp; --- no soundcards ---<br><br>&nbsp; &nbsp; &nbsp; &nbsp; Here is the lspci output:
<br>&nbsp; &nbsp; &nbsp; &nbsp; # lspci<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a1)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:01.3 Co-processor: nVidia Corporation MCP61 SMU (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:0b.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:0c.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:0d.0 VGA compatible controller: nVidia Corporation GeForce 6100<br>&nbsp; &nbsp; &nbsp; &nbsp; nForce 405 (rev a2)<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]<br>&nbsp; &nbsp; &nbsp; &nbsp; HyperTransport Technology Configuration
<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]<br>&nbsp; &nbsp; &nbsp; &nbsp; Address Map<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]<br>&nbsp; &nbsp; &nbsp; &nbsp; DRAM Controller<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:
18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]<br>&nbsp; &nbsp; &nbsp; &nbsp; Miscellaneous Control<br><br>&nbsp; &nbsp; &nbsp; &nbsp; And the details for the sound card (lspci again):<br>&nbsp; &nbsp; &nbsp; &nbsp; # lspci -vvv<br>&nbsp; &nbsp; &nbsp; &nbsp; 00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio (rev a2)
<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Subsystem: ASRock Incorporation Unknown device 0888<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-ParErr- Stepping- SERR- FastB2B-<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast
<br>&nbsp;&gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Latency: 0 (500ns min, 1250ns max)<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Interrupt: pin B routed to IRQ 10<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Region 0: Memory at dfff8000 (32-bit, non-prefetchable)
<br>&nbsp; &nbsp; &nbsp; &nbsp; [size=16K]<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Capabilities: [44] Power Management version 2<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA<br>&nbsp; &nbsp; &nbsp; &nbsp; PME(D0-,D1-,D2-,D3hot+,D3cold+)<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Status: D0 PME-Enable- DSel=0 DScale=0 PME-
<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Capabilities: [50] Message Signalled Interrupts: 64bit+<br>&nbsp; &nbsp; &nbsp; &nbsp; Queue=0/0 Enable-<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Address: 0000000000000000 &nbsp;Data: 0000<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Capabilities: [6c] HyperTransport: MSI Mapping
<br><br>&nbsp; &nbsp; &nbsp; &nbsp; The alsaconf command says no sound card could be detected on my system, which seems to be true as /proc/asound has no reference to the sound<br>&nbsp; &nbsp;&nbsp; card.<br><br>&nbsp; &nbsp; &nbsp; &nbsp; I need a little help please! I will wait for an answer on this email address.
<br><br><br>&nbsp; &nbsp; &nbsp; &nbsp; With Regards,<br>&nbsp; &nbsp; &nbsp; &nbsp; Ciprian Sturza.

------=_Part_2418_16426258.1165309778942--


--===============0992749099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0992749099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0992749099==--
