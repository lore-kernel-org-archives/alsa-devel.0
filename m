From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001494]: Intel HDA audio "scratchy" on Fujitsu S7020D unless position_fix=1 used
Date: Sat, 22 Oct 2005 19:03:48 +0200
Message-ID: <d630e7e1d56351d6bcd50c0ede81c58d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9541F125
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2005 19:03:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1494> 
======================================================================
Reported By:                Paul Walmsley
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1494
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Red Hat Fedora Core 4
Kernel Version:             2.6.13-1.1532_FC4 with ALSA drivers from CVS head
13-Oct-2005
======================================================================
Date Submitted:             10-22-2005 19:03 CEST
Last Modified:              10-22-2005 19:03 CEST
======================================================================
Summary:                    Intel HDA audio "scratchy" on Fujitsu S7020D unless
position_fix=1 used
Description: 
Audio on a Fujitsu Lifebook S7020D (snd-hda-intel with a Realtek ALC260) is
distorted and choppy unless position_fix=1 is used as a module parameter. 
This should be the default for this particular configuration.

By the way, Jonathan Woithe's mixer changes in patch-realtek.c CVS rev
1.26 work well on this platform for playback.  (I have not yet tested
recording.) 




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-22-05 19:03 Paul Walmsley  New Issue                                    
10-22-05 19:03 Paul Walmsley  Distribution              => Red Hat Fedora Core 4
10-22-05 19:03 Paul Walmsley  Kernel Version            => 2.6.13-1.1532_FC4
with ALSA drivers from CVS head 13-Oct-2005
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
