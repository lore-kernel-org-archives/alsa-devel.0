From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000844]: init.c forgotten newline in "choose_default_id"
Date: Tue, 25 Jan 2005 15:27:55 +0100
Message-ID: <9e48c42b289a3faa05488903b084f0dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AC0B5263
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 15:27:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=844> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   844
Category:                   OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-23-2005 21:25 CET
Last Modified:              01-25-2005 15:27 CET
======================================================================
Summary:                    init.c forgotten newline in "choose_default_id"
Description: 
The line:

snd_printk(KERN_ERR "unable to choose default card id (%s)", id);

should imho be replaced with:

snd_printk(KERN_ERR "unable to choose default card id (%s)\n", id);


======================================================================

----------------------------------------------------------------------
 tiwai - 01-25-05 15:27 
----------------------------------------------------------------------
Thanks, fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-05 21:25 Henne          New Issue                                    
01-25-05 15:27 tiwai          Status                   new => resolved     
01-25-05 15:27 tiwai          Resolution               open => fixed       
01-25-05 15:27 tiwai          Assigned To               => tiwai           
01-25-05 15:27 tiwai          Note Added: 0003405                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
