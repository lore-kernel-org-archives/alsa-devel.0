From: Carsten Koch <Carsten.Koch@icem.com>
Subject: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 13:28:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F532D5E.6040300@icem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi,

I have an Abit NF7 nforce2 main board, which has an optical SPDIF output
controlled by the on-board sound.

With nvida's "nvsound" driver, the optical output works.

With alsa, I have been unable to get any sound out of it so far.
I tried the alsa-0.9.0.cvs20030217-23 alsa drivers that came with
my SuSE 8.2 system, the release 0.9.6 drivers and last Friday's CVS.

lspci reports the device as:

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
         Subsystem: ABIT Computer Corp.: Unknown device 1c02
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at d800 [size=256]
         Region 1: I/O ports at dc00 [size=128]
         Region 2: Memory at ef001000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Alsamixer says "Card: NVidia nForce2", "Chip: Realtek ALC650 rev 3" and offers
these four IEC958 items: "Item: IEC958" (on/off), "Item: IEC958 Input Monitor" (on/off),
"Item: IEC958 Playback AC97-SPSA" (3 level control), "Analog to IEC958 Output" (on/off).

I was expecting that "Item: IEC958" would turn the optical SPDIF output on/off,
but the light is always on and the sound is always off, no matter how I set
that switch.

I was also expecting that "Item: IEC958 Input Monitor" would route the SPDIF
sound from my DVB card (whose output I have connected to the SPDIF input on
the main board) to the optical SPDIF output when I set that switch to on, but
again toggling that switch does nothing: the light is always on and the sound
is always off.

Is there anything I overlooked or does SPDIF output simply not work with this driver?

Here is my lsmod output:

Module                  Size  Used by    Tainted: P
dvb-ttpci             302512   7
evdev                   4192   0  (unused)
input                   3264   0  [dvb-ttpci evdev]
ves1820                 3900   0
stv0299                 7188   1
grundig_29504-491       3620   0
grundig_29504-401       3820   0
alps_tdlb7              4336   0
alps_tdmb7              4008   0
alps_bsrv2              3932   2
dvb-core               39832  43  [dvb-ttpci ves1820 stv0299 grundig_29504-491 grundig_29504-401 alps_tdlb7 alps_tdmb7 alps_bsrv2]
videodev                6176   2  [dvb-ttpci]
lirc_serial             7680   1  (autoclean)
nvidia               1628576  11  (autoclean)
nfsd                   84144   4  (autoclean)
ipv6                  145108  -1  (autoclean)
snd-intel8x0           21924   0
snd-pcm                74116   0  [snd-intel8x0]
snd-timer              17724   0  [snd-pcm]
snd-ac97-codec         44920   0  [snd-intel8x0]
snd-page-alloc          7316   0  [snd-intel8x0 snd-pcm]
snd-mpu401-uart         4192   0  [snd-intel8x0]
snd-rawmidi            16096   0  [snd-mpu401-uart]
snd-seq-device          4816   0  [snd-rawmidi]
snd                    40164   0  [snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3748   0  [snd]
nvnet                  26240   1
xfs                   575738   4


Any ideas what else I could try?

Many thanks in advance for your help!

Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
