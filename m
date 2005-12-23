From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001674]: Audigy 2 ZS after suspend no sound line in
Date: Fri, 23 Dec 2005 20:07:59 +0100
Message-ID: <77c6844d7902406a5515ef3599f9d5fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B21E116B
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2005 20:07:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1674> 
======================================================================
Reported By:                andreid1303
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1674
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-22-2005 21:41 CET
Last Modified:              12-23-2005 20:07 CET
======================================================================
Summary:                    Audigy 2 ZS after suspend no sound line in
Description: 
Finally I have got sound working after suspend with alsa 1.0.11rc1
installed but only line in is silent. PCM and Mic is OK
======================================================================

----------------------------------------------------------------------
 pzad - 12-23-05 20:07 
----------------------------------------------------------------------
Probably some register recovery is missing.

To be sure, it is not ac97 could you attach file

/proc/asound/your card/codec97#0/ac97#0-0+regs

before and after suspend ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 21:41 andreid1303    New Issue                                    
12-23-05 20:07 pzad           Note Added: 0007137                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
