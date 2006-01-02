From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000758]: Full duplex is not working in OSS emulation.
Date: Mon, 2 Jan 2006 09:12:04 +0100
Message-ID: <d4a687b4ea370662ec0bb3eec6b9a08c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76D57E8
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 09:12:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=758> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   758
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 7.2
Kernel Version:             2.4.7
======================================================================
Date Submitted:             12-29-2004 10:15 CET
Last Modified:              01-02-2006 09:12 CET
======================================================================
Summary:                    Full duplex is not working in OSS emulation.
Description: 
If I play something with one player, I am unable to record something on the
same device.
The same thing ispossible with the other cards I have.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000521 Jack + Alsa not working in full duplex,...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:08 
----------------------------------------------------------------------
This really seems like an application bug.

Any improvement in later ALSA release or with newer apps?

----------------------------------------------------------------------
 croiset - 01-02-06 09:12 
----------------------------------------------------------------------
My last test was made with alsa 1.0.10rc1 and it was not working also. I
didn't try yet with a newer release.

The same application is working well with all other sound cards I tested.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 10:15 croiset        New Issue                                    
12-29-04 10:15 croiset        Distribution              => Redhat 7.2      
12-29-04 10:15 croiset        Kernel Version            => 2.4.7           
12-29-04 14:17 tiwai          Note Added: 0002998                          
12-29-04 14:54 croiset        Note Added: 0003000                          
12-29-04 17:39 tiwai          Note Added: 0003004                          
12-29-04 17:56 croiset        Note Added: 0003005                          
12-29-04 17:59 croiset        Note Added: 0003006                          
12-29-04 18:05 croiset        Note Edited: 0003006                         
12-29-04 18:18 croiset        Note Edited: 0003006                         
01-03-05 16:30 croiset        Note Added: 0003067                          
09-14-05 16:16 jdthood        Relationship added       related to 0000521  
12-30-05 23:08 rlrevell       Note Added: 0007278                          
01-02-06 09:12 croiset        Note Added: 0007368                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
