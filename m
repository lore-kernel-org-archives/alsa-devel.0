From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000764]: ABIT VA-20 works with dxs_support=1
Date: Mon, 3 Jan 2005 20:13:45 +0100
Message-ID: <27696cf49d02f5ece93894506aa17e9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C29E1297
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 20:13:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=764> 
======================================================================
Reported By:                tomhughes
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   764
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-31-2004 12:41 CET
Last Modified:              01-03-2005 20:13 CET
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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
