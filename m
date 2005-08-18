From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001348]: On compaq persario v2311us external Amp needs to be turned on by defalt
Date: Thu, 18 Aug 2005 05:20:41 +0200
Message-ID: <79f69f2d348bd8c0405ddfdc02294216@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 21989130
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 05:20:42 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1348> 
======================================================================
Reported By:                J5
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1348
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora
Kernel Version:             2.6.12
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-17-2005 16:49 CEST
Last Modified:              08-18-2005 05:20 CEST
======================================================================
Summary:                    On compaq persario v2311us external Amp needs to be
turned on by defalt
Description: 
The External Amplifier channel needs to be turned on or no sound will come
fom the speakers or headphones.

Let me know if you need any more details.
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-18-05 05:20 
----------------------------------------------------------------------
Not a bug.  ALSA does not and cannot provide mixer settings that "work by
default" because it's not possible to determine a priori what that would
be, so all mixer elements must be muted by default.

File a bug report with your distro.

----------------------------------------------------------------------
 rlrevell - 08-18-05 05:20 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-17-05 16:49 J5             New Issue                                    
08-17-05 16:49 J5             Distribution              => Fedora          
08-17-05 16:49 J5             Kernel Version            => 2.6.12          
08-18-05 05:20 rlrevell       Note Added: 0005840                          
08-18-05 05:20 rlrevell       Status                   assigned => closed  
08-18-05 05:20 rlrevell       Note Added: 0005841                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
