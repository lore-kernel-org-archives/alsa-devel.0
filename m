From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000868]: I can't find a Intel HD sound subsystem (supously realtek alc860) alsa driver.
Date: Mon, 31 Jan 2005 18:53:00 +0100
Message-ID: <1ccc6c004b52acd46ee54d5e5c93e8be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A6AA22E
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 18:53:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=868> 
======================================================================
Reported By:                Luis Durán
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   868
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake 10.1
Kernel Version:             2.6.8.1.24
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-31-2005 16:47 CET
Last Modified:              01-31-2005 18:52 CET
======================================================================
Summary:                    I can't find a Intel HD sound subsystem (supously
realtek alc860) alsa driver.
Description: 
My hardware has installed an intel hd sound subsystem, this is the built-in
sound card on intel 915gav mobo, intel's website drivers doesn't work,
they even break your GNU/Linux installation even changing your root
password (pretty weird). intel's website said intel hd sound subsystem
chip is based on realtek alc860 or something like that. I will really
appreciate if you know something, please answer me.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-31-05 18:52 
----------------------------------------------------------------------
Use ALSA 1.0.8.  1.0.6a is way too old.
The driver for your device is snd-azx.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 16:47 Luis Durán     New Issue                                    
01-31-05 16:47 Luis Durán     Distribution              => Mandrake 10.1   
01-31-05 16:47 Luis Durán     Kernel Version            => 2.6.8.1.24      
01-31-05 18:52 tiwai          Status                   new => resolved     
01-31-05 18:52 tiwai          Resolution               open => not an issue
01-31-05 18:52 tiwai          Assigned To               => tiwai           
01-31-05 18:52 tiwai          Note Added: 0003451                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
