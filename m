From: fab <fab@gnux.info>
Subject: intel-hda on medion laptop
Date: Thu, 5 May 2005 23:09:32 +0200
Message-ID: <20050505210932.GA8016@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,
I own a brand new medion laptop with an ICH6 family sound card.
The laptop owns 2 internal speakers.
The side panel offers 1 headphones output jack + 1 mic input jack.
The bottom panel offers 4 outputs:
- Front
- Surround
- Center
- SPDIF
and 1 line in jack.

With the latest alsa-drivers (cvs) I get no sound on speakers nor
headphones output. The 3 bottom outputs works depending on the "model"
option but have *very* low sound of *very* bad quality on them
(generally, only the Front & Center works).

I contacted Medion to get informations but I had nothing in return...
I'm coder but I have no experience in drivers, I kept winXP to sniff
some things if needed...
Can someone point me the way I could make it works ?
I'ld love sound on my laptop :P

Best Regards.
Fabien Devaux.

PS: lspci -vv output :
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at 80000000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
