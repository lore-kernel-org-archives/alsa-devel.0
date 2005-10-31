From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001504]: Swap Front/Rear Output on SBLive! 5.1
Date: Mon, 31 Oct 2005 07:56:15 +0100
Message-ID: <2c2cb6f876891e657ce83374e8b754a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 159481A0
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 07:56:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1504> 
======================================================================
Reported By:                ripps818
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1504
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             10-25-2005 23:58 CEST
Last Modified:              10-31-2005 07:56 CET
======================================================================
Summary:                    Swap Front/Rear Output on SBLive! 5.1
Description: 
I want to know if it's possible to make my rear output my primary master
output for my soundcard. I use KxDriver in Windows and I want to be able
to keep my setup working in linux as well. I don't too much about
programming and the driver's archetecture, but it seems like it wouldn't
be too complicated to fix.
======================================================================

----------------------------------------------------------------------
 ripps818 - 10-31-05 04:45 
----------------------------------------------------------------------
will that allow "Master" to control my sound now?

----------------------------------------------------------------------
 rlrevell - 10-31-05 07:56 
----------------------------------------------------------------------
No, why would it?  Master controls the front speakers.  That's a completely
separate issue.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 23:58 ripps818       New Issue                                    
10-25-05 23:58 ripps818       Kernel Version            => 2.6.13          
10-25-05 23:58 ripps818       Issue Monitored: ripps818                    
10-31-05 01:26 mikma          Note Added: 0006579                          
10-31-05 01:27 mikma          Note Edited: 0006579                         
10-31-05 04:45 ripps818       Note Added: 0006581                          
10-31-05 07:56 rlrevell       Note Added: 0006585                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
