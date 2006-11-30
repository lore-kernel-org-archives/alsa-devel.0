From: Sturza Ciprian <cip_stu@yahoo.com>
Subject: Problems with nVidia Corporation MCP61 High Definition
	Audio
Date: Thu, 30 Nov 2006 10:03:21 -0800 (PST)
Message-ID: <515338.22692.qm@web50615.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1833744418=="
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

--===============1833744418==
Content-Type: multipart/alternative; boundary="0-243691035-1164909801=:22692"
Content-Transfer-Encoding: 7bit

--0-243691035-1164909801=:22692
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello!=20
 I have a problem installing my soundcard on fedora core 6 (PC, AMD
 Sempron 2800+, AsRock AM2NF6G-VSTA - motherboard) .
=20
 The PCI Audio is nVidia Corporation MCP61 High Definition Audio and the
 kernel that i just installed is 2.6.18.3
=20
 I have installed the alsa driver (version 1.0.13), the library and the
 utilities (the same version) just like is indicated on your
 documentation.
=20
 I have created the snd devices and chmod them.
=20
 I have compiled and installed the alsa driver using the following
 configure command options:=20
    ./configure --with-cards=3Dintel8x0 --with-sequencer=3Dyes;make;make
 install =20
=20
 After everything was successfully installed i have loaded the modules
 into the kernel like this:
 modprobe snd-intel8x0;modprobe snd-pcm-oss;modprobe
 snd-mixer-oss;modprobe snd-seq-oss
=20
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
 snd_pcm                82180  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
 snd_timer              26756  2 snd_seq,snd_pcm
 snd                    59140  9
 snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_o=
ss,snd_mixer_oss,snd_pcm,snd_timer
 soundcore              14176  1 snd
 snd_page_alloc         14344  2 snd_intel8x0,snd_pcm
=20
 I got no error and no card is being detected at this stage
 in /proc/asound/cards
=20
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
=20
 # cat /proc/asound/cards
 --- no soundcards ---
=20
 Here is the lspci output:
 # lspci
 00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a1)
 00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)
 00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
 00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a2)
 00:01.3 Co-processor: nVidia Corporation MCP61 SMU (rev a2)
 00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)
 00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)
 00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1)
 00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio
 (rev a2)
 00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2)
 00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
 00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)
 00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
 00:0b.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
 00:0c.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
 00:0d.0 VGA compatible controller: nVidia Corporation GeForce 6100
 nForce 405 (rev a2)
 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
 HyperTransport Technology Configuration
 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
 Address Map
 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
 DRAM Controller
 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
 Miscellaneous Control
=20
 And the details for the sound card (lspci again):
 # lspci -vvv
 00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio
 (rev a2)
         Subsystem: ASRock Incorporation Unknown device 0888
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at dfff8000 (32-bit, non-prefetchable)
 [size=3D16K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
 PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
         Capabilities: [50] Message Signalled Interrupts: 64bit+
 Queue=3D0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [6c] HyperTransport: MSI Mapping
=20
 The alsaconf command says no sound card could be detected on my system,
 which seems to be true as /proc/asound has no reference to the sound
 card.
=20
 I need a little help please! I will wait for an answer on this email
 address.=20
=20
=20
 With Regards,=20
 Ciprian Sturza.=20
=20
---------------------------------
Check out the all-new Yahoo! Mail beta - Fire up a more powerful email an=
d get things done faster.
--0-243691035-1164909801=:22692
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<tt>Hello! </tt><br> <tt>I have a problem installing my soundcard on fedo=
ra core 6 (PC, AMD</tt><br> <tt>Sempron 2800+, AsRock AM2NF6G-VSTA - moth=
erboard) .</tt><br> <br> <tt>The PCI Audio is nVidia Corporation MCP61 Hi=
gh Definition Audio and the</tt><br> <tt>kernel that i just installed is =
2.6.18.3</tt><br> <br> <tt>I have installed the alsa driver (version 1.0.=
13), the library and the</tt><br> <tt>utilities (the same version) just l=
ike is indicated on your</tt><br> <tt>documentation.</tt><br> <br> <tt>I =
have created the snd devices and chmod them.</tt><br> <br> <tt>I have com=
piled and installed the alsa driver using the following</tt><br> <tt>conf=
igure command options: </tt><br> <tt>&nbsp;&nbsp; ./configure --with-card=
s=3Dintel8x0 --with-sequencer=3Dyes;make;make</tt><br> <tt>install&nbsp; =
</tt><br> <br> <tt>After everything was successfully installed i have loa=
ded the modules</tt><br> <tt>into the kernel like this:</tt><br> <tt>modp=
robe snd-intel8x0;modprobe
 snd-pcm-oss;modprobe</tt><br> <tt>snd-mixer-oss;modprobe snd-seq-oss</tt=
><br> <br> <tt>The lsmod command shows this:</tt><br> <tt>Module&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by</tt><br> <tt>snd_intel8x0&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37020&nbsp; 0</tt><b=
r> <tt>snd_ac97_codec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100260&nb=
sp; 1 snd_intel8x0</tt><br> <tt>snd_ac97_bus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6656&nbsp; 1 snd_ac97_codec</tt><br=
> <tt>snd_seq_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 39040&nbsp; 0</tt><br> <tt>snd_seq_midi_event&nbsp;&nbsp;&nbsp=
;&nbsp; 12032&nbsp; 1 snd_seq_oss</tt><br> <tt>snd_seq&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5=
7840&nbsp; 4 snd_seq_oss,snd_seq_midi_event</tt><br>
 <tt>snd_seq_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12684=
&nbsp; 2 snd_seq_oss,snd_seq</tt><br> <tt>snd_pcm_oss&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 47232&nbsp; 0</tt><br> <tt=
>snd_mixer_oss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2112=
0&nbsp; 1 snd_pcm_oss</tt><br> <tt>snd_pcm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 82180&nbsp; 3=
 snd_intel8x0,snd_ac97_codec,snd_pcm_oss</tt><br> <tt>snd_timer&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2675=
6&nbsp; 2 snd_seq,snd_pcm</tt><br> <tt>snd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 59140&nbsp; 9</tt><br> <tt>snd_intel8x0,snd_ac97_codec,snd_seq=
_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer</=
tt><br> <tt>soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 14176&nbsp;
 1 snd</tt><br> <tt>snd_page_alloc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 14344&nbsp; 2 snd_intel8x0,snd_pcm</tt><br> <br> <tt>I got no e=
rror and no card is being detected at this stage</tt><br> <tt>in /proc/as=
ound/cards</tt><br> <br> <tt># ls -lsa /proc/asound/</tt><br> <tt>total 0=
</tt><br> <tt>0 dr-xr-xr-x&nbsp;&nbsp; 4 root root 0 Nov 30 19:50 .</tt><=
br> <tt>0 dr-xr-xr-x 120 root root 0 Nov 30&nbsp; 2006 ..</tt><br> <tt>0 =
-r--r--r--&nbsp;&nbsp; 1 root root 0 Nov 30 19:50 cards</tt><br> <tt>0 -r=
--r--r--&nbsp;&nbsp; 1 root root 0 Nov 30 19:50 devices</tt><br> <tt>0 -r=
--r--r--&nbsp;&nbsp; 1 root root 0 Nov 30 19:50 modules</tt><br> <tt>0 dr=
-xr-xr-x&nbsp;&nbsp; 2 root root 0 Nov 30 19:50 oss</tt><br> <tt>0 -r--r-=
-r--&nbsp;&nbsp; 1 root root 0 Nov 30 19:50 pcm</tt><br> <tt>0 dr-xr-xr-x=
&nbsp;&nbsp; 2 root root 0 Nov 30 19:50 seq</tt><br> <tt>0 -r--r--r--&nbs=
p;&nbsp; 1 root root 0 Nov 30 19:50 timers</tt><br> <tt>0 -r--r--r--&nbsp=
;&nbsp; 1 root root 0 Nov 30 19:50
 version</tt><br> <br> <tt># cat /proc/asound/cards</tt><br> <tt>--- no s=
oundcards ---</tt><br> <br> <tt>Here is the lspci output:</tt><br> <tt># =
lspci</tt><br> <tt>00:00.0 RAM memory: nVidia Corporation MCP61 Memory Co=
ntroller (rev a1)</tt><br> <tt>00:01.0 ISA bridge: nVidia Corporation MCP=
61 LPC Bridge (rev a2)</tt><br> <tt>00:01.1 SMBus: nVidia Corporation MCP=
61 SMBus (rev a2)</tt><br> <tt>00:01.2 RAM memory: nVidia Corporation MCP=
61 Memory Controller (rev a2)</tt><br> <tt>00:01.3 Co-processor: nVidia C=
orporation MCP61 SMU (rev a2)</tt><br> <tt>00:02.0 USB Controller: nVidia=
 Corporation MCP61 USB Controller (rev a2)</tt><br> <tt>00:02.1 USB Contr=
oller: nVidia Corporation MCP61 USB Controller (rev a2)</tt><br> <tt>00:0=
4.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1)</tt><br> <tt=
>00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio</tt=
><br> <tt>(rev a2)</tt><br> <tt>00:06.0 IDE interface: nVidia Corporation=
 MCP61 IDE (rev a2)</tt><br>
 <tt>00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)</tt><br> =
<tt>00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev =
a2)</tt><br> <tt>00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express=
 bridge (rev a2)</tt><br> <tt>00:0b.0 PCI bridge: nVidia Corporation MCP6=
1 PCI Express bridge (rev a2)</tt><br> <tt>00:0c.0 PCI bridge: nVidia Cor=
poration MCP61 PCI Express bridge (rev a2)</tt><br> <tt>00:0d.0 VGA compa=
tible controller: nVidia Corporation GeForce 6100</tt><br> <tt>nForce 405=
 (rev a2)</tt><br> <tt>00:18.0 Host bridge: Advanced Micro Devices [AMD] =
K8 [Athlon64/Opteron]</tt><br> <tt>HyperTransport Technology Configuratio=
n</tt><br> <tt>00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athl=
on64/Opteron]</tt><br> <tt>Address Map</tt><br> <tt>00:18.2 Host bridge: =
Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]</tt><br> <tt>DRAM Cont=
roller</tt><br> <tt>00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 =
[Athlon64/Opteron]</tt><br>
 <tt>Miscellaneous Control</tt><br> <br> <tt>And the details for the soun=
d card (lspci again):</tt><br> <tt># lspci -vvv</tt><br> <tt>00:05.0 Audi=
o device: nVidia Corporation MCP61 High Definition Audio</tt><br> <tt>(re=
v a2)</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: =
ASRock Incorporation Unknown device 0888</tt><br> <tt>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=
 VGASnoop-</tt><br> <tt>ParErr- Stepping- SERR- FastB2B-</tt><br> <tt>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Cap+ 66MHz+ UDF- FastB2B+=
 ParErr- DEVSEL=3Dfast &gt;TAbort-</tt><br> <tt>&lt;TAbort- &lt;MAbort- &=
gt;SERR- &lt;PERR-</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Latency: 0 (500ns min, 1250ns max)</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Interrupt: pin B routed to IRQ 10</tt><br> <tt>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Region 0: Memory at dfff8000 (32-bit=
, non-prefetchable)</tt><br>
 <tt>[size=3D16K]</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Capabilities: [44] Power Management version 2</tt><br> <tt>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA</tt><br> <tt>PME(D0-,D1=
-,D2-,D3hot+,D3cold+)</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: D0 PME-Enabl=
e- DSel=3D0 DScale=3D0 PME-</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Capabilities: [50] Message Signalled Interrupts: 64bit+</tt><b=
r> <tt>Queue=3D0/0 Enable-</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 000000=
0000000000&nbsp; Data: 0000</tt><br> <tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Capabilities: [6c] HyperTransport: MSI Mapping</tt><br> <br> <=
tt>The alsaconf command says no sound card could be detected on my system=
,</tt><br> <tt>which seems to be true as
 /proc/asound has no reference to the sound</tt><br> <tt>card.</tt><br> <=
br> <tt>I need a little help please! I will wait for an answer on this em=
ail</tt><br> <tt>address. </tt><br> <br> <br> <tt>With Regards, </tt><br>=
 <tt>Ciprian Sturza.</tt> <p>&#32;

<hr size=3D1>Check out <a href=3D"http://us.rd.yahoo.com/evt=3D43257/*htt=
p://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta</=
a> - Fire up a more powerful email and get things done faster.
--0-243691035-1164909801=:22692--


--===============1833744418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1833744418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1833744418==--
