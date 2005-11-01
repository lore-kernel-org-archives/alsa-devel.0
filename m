From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001173]: No sound from rear channels
Date: Tue, 1 Nov 2005 15:42:17 +0100
Message-ID: <6bfd3990ac3a0eb12405e3bd5f86157b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E749B15C
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:42:17 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001501.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1173> 
======================================================================
Reported By:                rraptorr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1173
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.6.11.11
======================================================================
Date Submitted:             06-08-2005 21:19 CEST
Last Modified:              11-01-2005 15:42 CET
======================================================================
Summary:                    No sound from rear channels
Description: 
I was trying to get my surround setup working under Linux. Everything is
working fine under Windows so hardware is OK. But under Linux I was unable
to get any sound from Center/LFE. And the rear channels where controlled
by Center/LFE mixer. After changing routing in ICH4.conf (as in 1.0.8) I
have sound from Center/LFE which is controlled by correct mixer but now I
don't get any sound from Rear speakers. I've even tried some random mixer
settings (due to the fact, that oryginally Rear was controlled by Center)
but with no luck.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001501 intel8x0 surround channels missing and ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 21:19 rraptorr       New Issue                                    
06-08-05 21:19 rraptorr       Distribution              => Slackware       
06-08-05 21:19 rraptorr       Kernel Version            => 2.6.11.11       
11-01-05 15:42 jdthood        Relationship added       related to 0001501  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
