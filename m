From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000615]: AC'97 broken on SB Live 24 bit
Date: Fri, 29 Oct 2004 12:34:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <7b4b27d30ecdefde7c1d3fa5fc3f7a43@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 25503265
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2004 12:34:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=615> 
======================================================================
Reported By:                MRB
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   615
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.7-gentoo-r1
======================================================================
Date Submitted:             10-29-2004 12:34 CEST
Last Modified:              10-29-2004 12:34 CEST
======================================================================
Summary:                    AC'97 broken on SB Live 24 bit
Description: 
The Creative Sound Blaster 24bit is using an Audigy chip according to its
PCI ID. The driver audigyls doesn't work because AC'97 does not respond
and AC'97 0 access is not valid. When you remove the error checking the
audigyls module can be loaded but there's no sound output. See attached
file for details. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 12:34 MRB            New Issue                                    
10-29-04 12:34 MRB            File Added: details.txt                      
10-29-04 12:34 MRB            Distribution              => Gentoo Linux    
10-29-04 12:34 MRB            Kernel Version            => 2.6.7-gentoo-r1 
======================================================================




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
