From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000258]: Recording from line-in produces noise
Date: Wed, 17 Nov 2004 19:21:19 +0100
Message-ID: <2fa1abe9c74c4c27e60ca366dd09b5b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E9D51D2
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 19:21:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=258> 
======================================================================
Reported By:                Fancia
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   258
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.22
======================================================================
Date Submitted:             05-06-2004 22:03 CEST
Last Modified:              11-17-2004 19:21 CET
======================================================================
Summary:                    Recording from line-in produces noise
Description: 
Attempting to record audio from the sound card's line-in port causes
audible pops and crackle in the resulting recording, regardless of
recording software used. These artefacts are not present in the input
itself and are not audible during the recording itself, but are present in
the resulting recording. I've tried recording from several different
devices on the same line-in port, and the noise is consistent. I've spoken
to several other AmigaOne owners with the same sound card, all of whom can
reproduce the problem.
Attached is a recording from my Roland MT-32 synthesizer module. Aside
from normalization, it's unaltered from the original recording.
======================================================================

----------------------------------------------------------------------
 Fancia - 05-06-04 22:14 
----------------------------------------------------------------------
Uploading seems to be causing some trouble; here's a link to the recording
on my university webspace:
http://is2.dal.ca/~br263779/testtune3.ogg

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:21 
----------------------------------------------------------------------
Can you verify this bug still exists with latest ALSA version, 1.0.7?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 22:03 Fancia         New Issue                                    
05-06-04 22:03 Fancia         Distribution              => Debian          
05-06-04 22:03 Fancia         Kernel Version            => 2.4.22          
05-06-04 22:05 Fancia         Issue Monitored: Fancia                      
05-06-04 22:06 Fancia         Issue End Monitor: Fancia                    
05-06-04 22:14 Fancia         Note Added: 0001064                          
11-17-04 19:21 rlrevell       Note Added: 0002440                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
