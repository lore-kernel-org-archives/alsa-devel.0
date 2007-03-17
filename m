From: Huw Hawkins <huwrh@yahoo.com.au>
Subject: Recently committed change to kernel 2.6.20.2 breaks
	snd-hda-intel on AOpen EZ482
Date: Sat, 17 Mar 2007 18:05:04 +1100 (EST)
Message-ID: <697313.33968.qm@web53613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi,
  The change under kernel 2.4.20.2 which reduced the
number of codexs (as in the below bit of the patch
files) from 4 to 3 stops the sound card properly
initialising (failed with an error about not finding
codecs). Bumping it back up to 4 gets me my sound
devices back again.

--------------------------------------------------

diff --git a/sound/pci/hda/hda_intel.c
b/sound/pci/hda/hda_intel.c
index 1a7e821..77f8ec7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -199,7 +199,7 @@ enum { SDI0, SDI1, SDI2, SDI3,
SDO0, SDO1, SDO2, SDO3 };

 /* STATESTS int mask: SD2,SD1,SD0 */
 #define STATESTS_INT_MASK      0x07
-#define AZX_MAX_CODECS         4
+#define AZX_MAX_CODECS         3

-----------------------------------------------

OUtput os lspci -vv is as follows:

00:14.2 Audio device: ATI Technologies Inc SB450 HDA
Audio (rev 01)
        Subsystem: AOPEN Inc. Unknown device 0569
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at fe024000 (64-bit,
non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [60] Message Signalled
Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

----------------------------------------------

  I'm not on this list so please CC me in any reply,
or if more info is required. I couldn't see this in
the bugtrack, although admittedly I didn't look too
hard so appologies if it is known.

Thanks

Huw

huwrh at yahoo dot com dot au

Send instant messages to your online friends http://au.messenger.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
