From: noreply@alsa-project.org
Subject: [ALSA - tools 0000342]: Output sample rate hardcoded to 48000 Hz, patch available.
Date: Fri, 16 Jul 2004 12:52:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105216.B199226008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4F36C150
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:52:17 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000342
======================================================================
Reported By:                mikma
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Bug ID:                     342
Category:                   ac3dec
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             06-21-2004 23:24 CEST
Last Modified:              07-16-2004 12:52 CEST
======================================================================
Summary:                    Output sample rate hardcoded to 48000 Hz, patch available.
Description: 
An output sample rate of 48000 Hz is always used regardless of the sample
rate in the sound file.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-22-2004 18:39 CEST 
----------------------------------------------------------------------
Thanks, the patch was applied to CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-21-04 23:24 mikma          New Bug                                      
06-21-04 23:24 mikma          File Added: alsa-tools-1.0.5-ac3dec-20040621.diff                    
06-22-04 18:39 tiwai          Bugnote Added: 0001330                       
06-22-04 18:39 tiwai          Resolution               open => fixed       
06-22-04 18:39 tiwai          Status                   assigned => resolved
07-16-04 12:52 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
