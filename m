From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000764]: ABIT VA-20 works with dxs_support=1
Date: Fri, 4 Feb 2005 18:04:13 +0100
Message-ID: <0bea9d8077695944ee8de420d88c8694@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D07DF1ED
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 18:04:13 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=764> 
======================================================================
Reported By:                tomhughes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   764
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-31-2004 12:41 CET
Last Modified:              02-04-2005 18:04 CET
======================================================================
Summary:                    ABIT VA-20 works with dxs_support=1
Description: 
My ABIT VA-20 motherboard is not currently recognised by the dxs_support
whitelist in the via82xx driver but I have tested it with a 44.1kHz sound
file and dxs_support=1 and it appears to work correctly. The lspci output
for the device is:

  00:11.5 Class 0401: 1106:3059 (rev 60)
          Subsystem: 147b:1411
          Flags: medium devsel, IRQ 10
          I/O ports at bc00 [size=256]
          Capabilities: <available only to root>

======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 20:13 
----------------------------------------------------------------------
Thanks for the info.  The entry was added to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 12:41 tomhughes      New Issue                                    
12-31-04 12:41 tomhughes      Distribution              => Fedora Core 3   
12-31-04 12:41 tomhughes      Kernel Version            => 2.6.9           
01-03-05 20:13 tiwai          Status                   new => resolved     
01-03-05 20:13 tiwai          Resolution               open => fixed       
01-03-05 20:13 tiwai          Assigned To               => tiwai           
01-03-05 20:13 tiwai          Note Added: 0003073                          
01-03-05 20:13 tiwai          Assigned To              tiwai =>            
02-04-05 18:04 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
