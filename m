From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001554]: LADSPA plugin do not work in case of policy NONE. LADSPA plugin usage is not documented propertly.
Date: Mon, 14 Nov 2005 11:32:24 +0100
Message-ID: <f7563d6afdf08a2c9e94869a4b99c195@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 737691A0
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:32:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1554> 
======================================================================
Reported By:                gena2x
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1554
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-13-2005 21:04 CET
Last Modified:              11-14-2005 11:32 CET
======================================================================
Summary:                    LADSPA plugin do not work in case of policy NONE.
LADSPA plugin usage is not documented propertly.
Description: 
This bug make impossible to work with single channel of multichannel
frame.
So I do not find another clear way to filter high frequences out of my
subwoofer.


======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 10:59 
----------------------------------------------------------------------
Could you redo you patch against the current ALSA CVS tree? The locale
problem should be fixed.

----------------------------------------------------------------------
 gena2x - 11-14-05 11:32 
----------------------------------------------------------------------
ok.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 21:04 gena2x         New Issue                                    
11-13-05 21:04 gena2x         File Added: patch.localeANDladspa                 
  
11-14-05 10:59 perex          Note Added: 0006712                          
11-14-05 11:32 gena2x         Note Added: 0006719                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
