From: Noel Bush <noel@x-31.com>
Subject: no sound with 1.0.0 release
Date: Thu, 11 Dec 2003 23:04:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071201843.1980.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I am using the planetccrma-core distribution.  Recently I tried
upgrading, via that distro, to the alsa 1.0.0 packages.  I found that
after this upgrade, I was unable to hear any sound when using any app
(simplest test, using aplay on a wav file).  I did make sure that all
relevant controls were unmuted.  I found that all alsa modules were
indeed loaded.  There were no error messages when starting the alsasound
service, and no error messages when running any sound apps (alsamixer,
aplay, ecasound, etc.)  Using ecasignalview showed the meter bouncing up
and down...no sound.  I was only able to regain sound by downgrading to
the 0.9.8 version.

Here I will try to provide all relevant info; please let me know what
else I can provide to help.

The packages to which I upgraded:

# rpm -qa | grep ^alsa
alsa-firmware-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-driver-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-lib-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsaplayer-0.99.75-1.rhfc1.ccrma
alsa-utils-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-tools-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-kernel-2.4.23-1.ll.rhfc1.ccrma-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-lib-devel-1.0.0-1.rc2.cvs.rhfc1.ccrma

The kernel I was using:

# uname -r
2.4.23-1.ll.rhfc1.ccrma

Output from lspci about my soundcard:

# lspci -v -v
[...]
01:0a.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at c400 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[...]

The packages to which I downgraded in order to get sound:

alsa-lib-devel-0.9.8-2.cvs.rhfc1.ccrma
alsa-driver-0.9.8-2.cvs.rhfc1.ccrma
alsa-utils-0.9.8-2.cvs.rhfc1.ccrma
alsa-tools-0.9.8-2.cvs.rhfc1.ccrma
alsa-lib-0.9.8-2.cvs.rhfc1.ccrma

I should note that, even with these packages installed, I cannot get
sound if I boot with the 2.4.23-1.ll.rhfc1.ccrma kernel.  Currently I am
using:

# uname -r
2.4.21-1.ll.acpi

Right now, all of the following alsa-kernel packages are installed (and
I am scared to remove any of them!):

# rpm -qa | grep ^alsa-kernel
alsa-kernel-2.4.23-1.ll.rhfc1.ccrma-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-kernel-2.4.22-1.2129.nptl.caps.rhfc1.ccrma-1.0.0-1.rc2.cvs.rhfc1.ccrma
alsa-kernel-2.4.22-1.2115.nptl.caps.rhfc1.ccrma-0.9.8-2.cvs.rhfc1.ccrma
alsa-kernel-2.4.21-1.ll.acpi-0.9.4-2.cvs

Hope this is useful, and let me know if I can provide more info.






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
