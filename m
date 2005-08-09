From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001296]: isapnp is incompatible with pnpbios and used the wrong ID's
Date: Tue, 9 Aug 2005 12:53:00 +0200
Message-ID: <0b632bcc6a42b0b7f5bad67b8b073ea4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F19BA1BB
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 12:53:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1296> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   1296
Category:                   alsaconf
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-01-2005 13:07 CEST
Last Modified:              08-09-2005 12:53 CEST
======================================================================
Summary:                    isapnp is incompatible with pnpbios and used the
wrong ID's
Description: 
The sysfs path to the device is wrong.
All details are in the patch. 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000879 (snd_)opl3sa2 (isa) doesn't work (fails...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-03-05 14:58 
----------------------------------------------------------------------
Check the cvs version.  It was fixed today.

----------------------------------------------------------------------
 perex - 08-09-05 12:53 
----------------------------------------------------------------------
Fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-05 13:07 Henne          New Issue                                    
08-01-05 13:07 Henne          File Added: aconf.diff                       
08-03-05 14:58 tiwai          Note Added: 0005628                          
08-04-05 08:52 perex          Relationship added       related to 0000879  
08-09-05 12:53 perex          Status                   new => resolved     
08-09-05 12:53 perex          Resolution               open => fixed       
08-09-05 12:53 perex          Assigned To               => perex           
08-09-05 12:53 perex          Note Added: 0005723                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
