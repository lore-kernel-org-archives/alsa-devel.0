From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001674]: Audigy 2 ZS after suspend no sound line in
Date: Tue, 27 Dec 2005 21:51:44 +0100
Message-ID: <9f3d8e1d539678bf4dae6b88df9477d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD360181
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 21:51:44 +0100 (MET)
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
Last Modified:              12-27-2005 21:51 CET
======================================================================
Summary:                    Audigy 2 ZS after suspend no sound line in
Description: 
Finally I have got sound working after suspend with alsa 1.0.11rc1
installed but only line in is silent. PCM and Mic is OK
======================================================================

----------------------------------------------------------------------
 pzad - 12-27-05 21:01 
----------------------------------------------------------------------
It is helpfull.

02 is master volume for ac97 - and this is cause of problem. Output from
ac97 is connected to ADC.
0000 - master volume is set to max -  this is default.
9f1f - this is probably mute.

CD in - this is same problem as Line in, because they are mixed together
in ac97 and digitalized in ADC.

----------------------------------------------------------------------
 pzad - 12-27-05 21:51 
----------------------------------------------------------------------
Could you try attached patch (pm.patch) ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 21:41 andreid1303    New Issue                                    
12-23-05 20:07 pzad           Note Added: 0007137                          
12-27-05 20:47 andreid1303    Note Added: 0007169                          
12-27-05 20:49 andreid1303    Note Edited: 0007169                         
12-27-05 21:01 pzad           Note Added: 0007170                          
12-27-05 21:38 pzad           File Added: pm.patch                         
12-27-05 21:51 pzad           Note Added: 0007172                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
