From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000319]: Cannot control main volume independently for left and right channels
Date: Wed, 17 Nov 2004 19:22:38 +0100
Message-ID: <f03b0d003a8a89e08570042c914406d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A78C71D4
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 19:22:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=319> 
======================================================================
Reported By:                walrus121
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   319
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 1
Kernel Version:             2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
======================================================================
Date Submitted:             05-31-2004 17:46 CEST
Last Modified:              11-17-2004 19:22 CET
======================================================================
Summary:                    Cannot control main volume independently for left
and right channels
Description: 
I have tried with numerous volume control programs, and I get the same
result.  If I try to adjust one channel, the values of the two channels
are averaged in some strange way and are rebalanced to the center.  I know
that this must be a driver-specific issue because I can control the two
channels independently for my Sound Blaster AWE 64 Value card, also in my
computer, and because it doesn't seem to matter which mixer I use.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:22 
----------------------------------------------------------------------
Can you verify the bug with the latest ALSA version. 1.0.7?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 17:46 walrus121      New Issue                                    
05-31-04 17:46 walrus121      File Added: modules.conf                     
05-31-04 17:46 walrus121      Distribution              => Fedora Core 1   
05-31-04 17:46 walrus121      Kernel Version            =>
2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
11-17-04 19:22 rlrevell       Note Added: 0002441                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
