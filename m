From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000867]: There's no Mic Bias in mixer settings
Date: Mon, 31 Jan 2005 11:59:37 +0100
Message-ID: <524e6b059b6a95bd75da650c05658b79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EC51E158
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 11:59:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=867> 
======================================================================
Reported By:                coder111
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   867
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-31-2005 11:59 CET
Last Modified:              01-31-2005 11:59 CET
======================================================================
Summary:                    There's no Mic Bias in mixer settings
Description: 
Hi,

I just wanted to report that for some reason on my Creative SB PCI Compact
there is no mic bias settings, which means I cannot get my capacitor based
mic to work.
I tried listing alsactl settings, and mic bias is not there, i don't think
driver recognises that this card has a mic bias, and it should.

If you need additional testing or info, feel free to mail me.

Teofilis
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 11:59 coder111       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
