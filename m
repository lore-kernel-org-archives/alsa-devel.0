From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001544]: Crash on missing library in snd_ctl_open_conf
Date: Mon, 14 Nov 2005 11:18:36 +0100
Message-ID: <da03239c95511653514cc3b49b8a51a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABC5CD4
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:18:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1544> 
======================================================================
Reported By:                smagoun
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1544
Category:                   control / hcontrol
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-11-2005 16:25 CET
Last Modified:              11-14-2005 11:18 CET
======================================================================
Summary:                    Crash on missing library in snd_ctl_open_conf
Description: 
alsa-lib 1.0.10rc3 crashes in snd_ctl_open_conf while trying to close a DLL
that was never opened. This patch prevents the dlclose call if the dlopen
failed.
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 11:18 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-05 16:25 smagoun        New Issue                                    
11-11-05 16:25 smagoun        File Added: control.patch                    
11-14-05 11:18 perex          Status                   new => resolved     
11-14-05 11:18 perex          Resolution               open => fixed       
11-14-05 11:18 perex          Assigned To               => perex           
11-14-05 11:18 perex          Note Added: 0006718                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
