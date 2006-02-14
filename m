From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001572]: Simultaneous sound from speakers and headphone
Date: Tue, 14 Feb 2006 05:37:44 +0100
Message-ID: <cc1dadee446f459e76a45a10f039113c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDDCF15A
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 05:37:44 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1572> 
======================================================================
Reported By:                mjsb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1572
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.1.13-gentoo-r3
======================================================================
Date Submitted:             11-17-2005 16:31 CET
Last Modified:              02-14-2006 05:37 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone
Description: 
I cannot ear headphones without having sound from front speakers
simultaneously.
Volume of headphones is adjusted by front speakers and when muting front
speakers also mutes headphones.
(in MS Windows, inserting headphones automatically disables sound from
front speakers)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001663 LW20 bugs with headphone input, realtek...
======================================================================

----------------------------------------------------------------------
 blackr2d - 01-25-06 12:36 
----------------------------------------------------------------------
Similar problems here, mixer controls not picked up correctly for ALC880:

Laptop: Medion WIM 2040 (MD96500)
Kernel: 2.6.14-gentoo-r5
Alsa: 1.0.9b from Realtek, 1.0.9a from Medion, 1.0.10 from Gentoo,
1.0.11_rc2 from Alsa themselves, 1.0.11_rc2 from Gentoo with ~x86

lspci -vv:
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
        Subsystem: Wistron Corp. Unknown device 201a
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at c0000000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

lspci -nvv:
00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 17c0:201a
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at c0000000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

I've tried different alsa versions and then models from realtek patch, but
to no avail. Same problems - switching between headphones and laptop
speakers. Option "test" gives the most complete controls, so it seems
other models simply don't match my hardware.

Since it's 10 years last time I coded anything - could somebody point me
in the right direction, I would be more than happy to help.



----------------------------------------------------------------------
 richardfish - 02-14-06 05:37 
----------------------------------------------------------------------
I have the same issue with a Sigmatel STAC9200.  While playing around with
the code, I sumbled across a (too simple) fix:

Index: patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.17
diff -u -r1.17 patch_sigmatel.c
--- patch_sigmatel.c    25 Jan 2006 19:20:50 -0000      1.17
+++ patch_sigmatel.c    14 Feb 2006 04:06:15 -0000
@@ -901,6 +906,9 @@
        if ((err = stac92xx_auto_create_analog_input_ctls(codec,
&spec->autocfg)) < 0)
                return err;

+       if ((err = stac92xx_auto_create_hp_ctls(codec, &spec->autocfg)) <
0)
+               return err;
+
        if (spec->autocfg.dig_out_pin) {
                spec->multiout.dig_out_nid = 0x05;
                stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_out_pin,
AC_PINCTL_OUT_EN);


This works in that if I insert headphones after the driver is loaded, the
speakers are correctly muted, and sound comes from the headphones.  If I
remove the headphones, sound comes from the speakers again.

The problem with the above fix is that I end up with both master and
headphone controls in alsamixer.  Muting either will mute the headphones
or speakers depending upon which is active.  Adjusting the volume of
either also affects both outputs.

Any advice on how to properly avoid the calls that generate the extra
headphone controls for my hardware would be appreciated.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 16:31 mjsb           New Issue                                    
11-17-05 16:31 mjsb           Distribution              => Gentoo Linux    
11-17-05 16:31 mjsb           Kernel Version            => 2.1.13-gentoo-r3
11-17-05 16:33 mjsb           Issue Monitored: mjsb                        
12-08-05 21:23 mjsb           Note Added: 0006962                          
01-16-06 11:19 mjsb           Note Added: 0007685                          
01-19-06 18:27 rlrevell       Relationship added       has duplicate 0001663
01-21-06 03:24 mjsb           Note Added: 0007730                          
01-21-06 03:25 mjsb           File Added: HPoff-speakeron                    
01-21-06 03:25 mjsb           File Added: HPon-speakeroff                    
01-21-06 03:30 mjsb           Note Edited: 0007730                         
01-25-06 11:47 blackr2d       Issue Monitored: blackr2d                    
01-25-06 11:56 blackr2d       Note Added: 0007778                          
01-25-06 11:59 blackr2d       Note Edited: 0007778                         
01-25-06 12:00 blackr2d       Note Edited: 0007778                         
01-25-06 12:36 blackr2d       Note Edited: 0007778                         
02-14-06 05:36 richardfish    Issue Monitored: richardfish                    
02-14-06 05:37 richardfish    Note Added: 0008069                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
