From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001499]: no MIDI output on line out
Date: Tue, 25 Oct 2005 11:16:53 +0200
Message-ID: <0d9d764294ab23d21c122abff6f1623d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 56959173
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 11:16:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1499> 
======================================================================
Reported By:                comotion
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1499
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.13.2 SMP
======================================================================
Date Submitted:             10-25-2005 11:16 CEST
Last Modified:              10-25-2005 11:16 CEST
======================================================================
Summary:                    no MIDI output on line out
Description: 
MIDI output works on the headphone jack,  but not on the second (line out)
output. 
I should mention that regular PCM output is audible through both jacks. 

This breaks the principle of least surprise, since it is reasonable to
expect that MIDI output is audible through both soundcard outputs.
Attempts were made to re-route the output, however I was told on the
mailing list that this was not possible (see below for list thread).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 11:16 comotion       New Issue                                    
10-25-05 11:16 comotion       Distribution              => debian          
10-25-05 11:16 comotion       Kernel Version            => 2.6.13.2 SMP    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
