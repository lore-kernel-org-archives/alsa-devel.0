From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001553]: LADSPA plugins don't work when locale numerical delimiter is not '.'
Date: Sun, 13 Nov 2005 20:50:17 +0100
Message-ID: <d2b3bbb02fb7a1c1ce70170f58e1150e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6776D193
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2005 20:50:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1553> 
======================================================================
Reported By:                gena2x
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1553
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-13-2005 20:50 CET
Last Modified:              11-13-2005 20:50 CET
======================================================================
Summary:                    LADSPA plugins don't work when locale numerical
delimiter is not '.'
Description: 
More intresting problem with LADSPA plugin names. For example name of
plugin
'delay0.01s' is 'delay0.01s' in en_US locale and 'delay0,01s' in
ru_RU.KOI8-R 
locale. You may check listplugins from ladspa-sdk. 

This makes global config in multilangual environment unusable in cases
there 
LADSPA plugins needed.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 20:50 gena2x         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
