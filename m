From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001554]: LADSPA plugin do not work in case of policy NONE. LADSPA plugin usage is not documented propertly.
Date: Tue, 13 Dec 2005 15:13:56 +0100
Message-ID: <16679f57bac9bed6ccd7861f27144b55@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 414481CA
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 15:13:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1554> 
======================================================================
Reported By:                gena2x
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1554
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-13-2005 21:04 CET
Last Modified:              12-13-2005 15:13 CET
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
 perex - 12-05-05 14:46 
----------------------------------------------------------------------
gena2x: any progress?

----------------------------------------------------------------------
 perex - 12-13-05 15:13 
----------------------------------------------------------------------
I rewrote the LADSPA plugin in CVS, so this issue is fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 21:04 gena2x         New Issue                                    
11-13-05 21:04 gena2x         File Added: patch.localeANDladspa                 
  
11-14-05 10:59 perex          Note Added: 0006712                          
11-14-05 11:32 gena2x         Note Added: 0006719                          
11-21-05 18:31 jdthood        Note Added: 0006772                          
11-22-05 09:01 perex          Note Added: 0006786                          
12-05-05 14:46 perex          Note Added: 0006911                          
12-05-05 14:46 perex          Note Added: 0006912                          
12-05-05 14:57 perex          Note Deleted: 0006912                        
12-13-05 15:13 perex          Status                   new => resolved     
12-13-05 15:13 perex          Resolution               open => fixed       
12-13-05 15:13 perex          Assigned To               => perex           
12-13-05 15:13 perex          Note Added: 0007017                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
