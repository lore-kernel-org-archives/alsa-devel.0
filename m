From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000852]: alsa driver do not work on IBM thinkpad T42
Date: Wed, 2 Feb 2005 16:20:07 +0100
Message-ID: <627f9786a3ebc814abe4deab42d58a52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E870F212
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 16:20:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=852> 
======================================================================
Reported By:                lithium7456
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   852
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-28-2005 05:26 CET
Last Modified:              02-02-2005 16:20 CET
======================================================================
Summary:                    alsa driver do not work on IBM thinkpad T42
Description: 
After the installation of slackware linux 10 ,I found that the alsa driver
1.05(with slackware linux )do not work: when i run "alsamixer" it shows
that "no mixer elems". So I downloaded driver 1.08 and had it installed.
now I can run alsamixer without any error message but my computer does not
play any sound at all(I have run alsaconf and it detected the soundcard as
snd-intel8x0)
What steps shall I
take&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=65311;
please Re to lithium7456@sohu.com
Thank you
======================================================================

----------------------------------------------------------------------
 tiwai - 01-28-05 17:47 
----------------------------------------------------------------------
Turn off 'Headphone Jack Sense' and 'Line Jack Sense' mixer switches if
they are on.

----------------------------------------------------------------------
 lithium7456 - 02-02-05 16:20 
----------------------------------------------------------------------
oh..it works....now I can hear music in linux now 
Thank you very much!!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 05:26 lithium7456    New Issue                                    
01-28-05 17:47 tiwai          Note Added: 0003430                          
02-02-05 16:20 lithium7456    Note Added: 0003489                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
