From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000648]: aplay -Dspdif produces choppy (beating?) audio from DTS .wav files
Date: Sun, 14 Nov 2004 10:02:07 +0100
Message-ID: <d4fe7ecfbd430c899a704ec8c4b878e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D91F526D
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2004 10:02:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=648> 
======================================================================
Reported By:                duanev
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   648
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.1
Kernel Version:             Preemptable 2.6.8 kernel
======================================================================
Date Submitted:             11-14-2004 04:24 CET
Last Modified:              11-14-2004 10:02 CET
======================================================================
Summary:                    aplay -Dspdif produces choppy (beating?) audio from
DTS .wav files
Description: 
Sound produced by aplay is not smooth - audio is "chopped up" or appears to
"beat" at about 5Hz.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-14-04 04:41 
----------------------------------------------------------------------
duplicate of bug 646

----------------------------------------------------------------------
 pzad - 11-14-04 10:02 
----------------------------------------------------------------------
AFAIK SB Live support only 48 kHz spdif output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 04:24 duanev         New Issue                                    
11-14-04 04:24 duanev         Distribution              => Mandrake 10.1   
11-14-04 04:24 duanev         Kernel Version            => Preemptable 2.6.8
kernel
11-14-04 04:41 rlrevell       Note Added: 0002406                          
11-14-04 10:02 pzad           Note Added: 0002407                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
