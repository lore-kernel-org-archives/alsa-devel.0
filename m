From: "J. Scott Amort" <jsamort@shaw.ca>
Subject: Problem loading module snd-emu10k1
Date: Thu, 06 Nov 2003 21:30:10 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1068183010.16578.15.camel@enlightenment.baobobmusic.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
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

I can't get module emu10k1 to load with 0.9.8.  It compiles fine, but
when I try modprobe snd-emu10k1, I get:

/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
insmod
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o
failed
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
insmod snd-emu10k1 failed

Here is the insmod output:

Using
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol snd_hwdep_new_R87e4a6ea
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol snd_util_memhdr_new_R86b9ead1
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol __snd_util_mem_alloc_Raf5d58ef
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol __snd_util_memblk_new_R970b7c65
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol __snd_util_mem_free_R74f21f45
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/emu10k1/snd-emu10k1.o:
unresolved symbol snd_util_memhdr_free_Rd52ead8c

And of course, the device does exist, here is lspci -vv:

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
Running Fedora Core 1.  Any guidance would be appreciated!

Thanks,

Scott



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
