From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000648]: aplay -Dspdif produces choppy (beating?) audio from DTS .wav files
Date: Wed, 17 Nov 2004 18:21:31 +0100
Message-ID: <a22ebdb0f0f429ec6e024d8fd5e5e537@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C7A9270
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 18:21:31 +0100 (MET)
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
Last Modified:              11-17-2004 18:21 CET
======================================================================
Summary:                    aplay -Dspdif produces choppy (beating?) audio from
DTS .wav files
Description: 
Sound produced by aplay is not smooth - audio is "chopped up" or appears to
"beat" at about 5Hz.
======================================================================

----------------------------------------------------------------------
 duanev - 11-17-04 07:02 
----------------------------------------------------------------------
Fixed with patch posted to bug 646.

How do I close this?!

----------------------------------------------------------------------
 rlrevell - 11-17-04 18:21 
----------------------------------------------------------------------
Hmm good question.  Takashi-san. can we close this, marking it as a
duplicate of bug 646?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 04:24 duanev         New Issue                                    
11-14-04 04:24 duanev         Distribution              => Mandrake 10.1   
11-14-04 04:24 duanev         Kernel Version            => Preemptable 2.6.8
kernel
11-14-04 04:41 rlrevell       Note Added: 0002406                          
11-14-04 10:02 pzad           Note Added: 0002407                          
11-17-04 07:02 duanev         Note Added: 0002433                          
11-17-04 18:21 rlrevell       Note Added: 0002437                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
