From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000883]: Odd Mixer Controls with i810 on Fujitsu S6210
Date: Fri, 4 Feb 2005 12:35:18 +0100
Message-ID: <1ba97714ca3287156dd03a15c6a76fef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CB76E215
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 12:35:18 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=883> 
======================================================================
Reported By:                tonym
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   883
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-04-2005 12:35 CET
Last Modified:              02-04-2005 12:35 CET
======================================================================
Summary:                    Odd Mixer Controls with i810 on Fujitsu S6210
Description: 
I have some very odd mixer controls with my integrated i810 audio
lspci -v -n -s 00:1f.5
0000:00:1f.5 Class 0401: 8086:24c5 (rev 03)
        Subsystem: 10cf:1253
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 1c00
        I/O ports at 18c0 [size=64]
        Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
        Memory at d0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2


List of controls and what they do:
control.2 Master Playback Volume - no effect (so l/r doesn't work either)
control.4 Headphone Playback Volume - controls all vol, headphones and
speakers
control.6 Master Mono Playback Volume - no effect
control.8 PC Speaker Playback Volume - no effect
control.23 PCM Playback Volume - Works as should
control.33 External Amplifier - disables the builtin speakers, headphones
still work

Other controls I deemed irrelevent...

I suspect this is just a quirk of this laptop, but I don't know what info
you need, so please ask me.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-05 12:35 tonym          New Issue                                    
02-04-05 12:35 tonym          Distribution              => Gentoo          
02-04-05 12:35 tonym          Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
