From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Thu, 18 Nov 2004 21:05:58 +0100
Message-ID: <b7af96feff6b06f883c007a9aeb77c4c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 83702263
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 21:05:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=384> 
======================================================================
Reported By:                bryanb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo dev sources
Kernel Version:             2.6
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              11-18-2004 21:05 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-18-04 19:44 
----------------------------------------------------------------------
Hmm, strnage.  After loading OSS ymfpci, snd-ymfpci starts working fine?

----------------------------------------------------------------------
 c0ldevil - 11-18-04 21:05 
----------------------------------------------------------------------
No, I think it doesn't. I haven't tried that this time but I have already
tried it before and it didn't work

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:28 bryanb         New Issue                                    
07-13-04 19:28 bryanb         Distribution              => Gentoo dev sources
07-13-04 19:28 bryanb         Kernel Version            => 2.6             
07-29-04 22:43 codefathers    Note Added: 0001485                          
07-29-04 22:45 codefathers    Issue Monitored: codefathers                    
09-03-04 03:37 Derek_Burdick  Issue Monitored: Derek_Burdick                    
09-03-04 03:40 Derek_Burdick  Note Added: 0001684                          
10-23-04 23:24 c0ldevil       Note Added: 0002257                          
10-23-04 23:27 c0ldevil       Note Edited: 0002257                         
10-23-04 23:55 c0ldevil       Note Added: 0002259                          
10-23-04 23:56 c0ldevil       Note Added: 0002260                          
11-10-04 12:48 tiwai          Note Added: 0002369                          
11-17-04 18:14 c0ldevil       Note Added: 0002436                          
11-17-04 20:33 c0ldevil       Note Added: 0002442                          
11-17-04 20:39 rlrevell       Note Added: 0002443                          
11-18-04 14:30 tiwai          Note Added: 0002445                          
11-18-04 15:46 c0ldevil       Note Added: 0002446                          
11-18-04 15:56 c0ldevil       Note Added: 0002447                          
11-18-04 15:59 c0ldevil       File Added: dumps.zip                        
11-18-04 16:00 c0ldevil       Note Added: 0002448                          
11-18-04 19:44 tiwai          Note Added: 0002465                          
11-18-04 21:05 c0ldevil       Note Added: 0002471                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
