From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000837]: Mute LED for the HP/Compaq nc8000
Date: Wed, 2 Feb 2005 10:48:32 +0100
Message-ID: <f36ad5e5624621e660c5c08a956b601a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 15A32217
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 10:48:33 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=837> 
======================================================================
Reported By:                linus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   837
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-19-2005 20:15 CET
Last Modified:              02-02-2005 10:48 CET
======================================================================
Summary:                    Mute LED for the HP/Compaq nc8000
Description: 
I noticed that the quirk introduced for HP/Compaq nc6000 among
others isn't applied for HP/Compaq nc8000 (most probably because
you don't have the PCI ID. By the way both the model nc6000
and nc8000 should be with small letters (not that it matters to
anyone else than the logo designer)

So I've had a user obtain the PCI ID. The subsystem is: 103c:088c

Long lspci -v and -v -n here:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Hewlett-Packard Company: Unknown device 088c

0000:00:1f.5 0401: 8086:24c5 (rev 03)
	Subsystem: 103c:088c
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 3000 [size=256]
	I/O ports at 3880 [size=64]
	Memory at a0100000 (32-bit, non-prefetchable) [size=512]
	Memory at a0180000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>
======================================================================

----------------------------------------------------------------------
 linus - 02-01-05 10:16 
----------------------------------------------------------------------
I saw this has been fixed in the CVS! Thanks.

----------------------------------------------------------------------
 tiwai - 02-02-05 10:48 
----------------------------------------------------------------------
--> FIXED

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-05 20:15 linus          New Issue                                    
01-19-05 20:15 linus          Distribution              => Fedora Core 3   
01-19-05 20:15 linus          Kernel Version            => 2.6.10          
01-19-05 21:06 orange         Issue Monitored: orange                      
02-01-05 10:16 linus          Note Added: 0003460                          
02-02-05 10:48 tiwai          Status                   new => resolved     
02-02-05 10:48 tiwai          Resolution               open => fixed       
02-02-05 10:48 tiwai          Assigned To               => tiwai           
02-02-05 10:48 tiwai          Note Added: 0003478                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
