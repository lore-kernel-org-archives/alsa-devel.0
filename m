From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000313]: Compilation error using 2.6.x kernel headers
Date: Fri, 21 Jan 2005 21:18:11 +0100
Message-ID: <4c80a359ce18d1e2030cca2659ee0165@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 537A021B
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 21:18:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=313> 
======================================================================
Reported By:                nimster
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   313
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2004 20:16 CEST
Last Modified:              01-21-2005 21:18 CET
======================================================================
Summary:                    Compilation error using 2.6.x kernel headers
Description: 
In my LFS (http://www.linuxfromscratch.org), I have a 2.6.6 kernel with
2.6.3 kernel headers. Compilation of ALSA-lib fails with (this is actually
1.0.5, but it failed with 1.0.4 too, with the same error).




======================================================================

----------------------------------------------------------------------
 nimster - 01-21-05 11:50 
----------------------------------------------------------------------
I imagine so, considering there's both a new ALSA version and a new kernel
version since then. I might try building it again sometime, and will let
you know definitely (For now I am using a different linux distribution).

Thank you very much,
-Nimster

----------------------------------------------------------------------
 tiwai - 01-21-05 21:18 
----------------------------------------------------------------------
This bug was known and already fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-04 20:16 nimster        New Issue                                    
01-21-05 00:31 jdthood        Note Added: 0003336                          
01-21-05 11:50 nimster        Note Added: 0003342                          
01-21-05 21:18 tiwai          Status                   new => resolved     
01-21-05 21:18 tiwai          Resolution               open => fixed       
01-21-05 21:18 tiwai          Assigned To               => tiwai           
01-21-05 21:18 tiwai          Note Added: 0003360                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
