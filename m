From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Thu, 18 Nov 2004 15:56:17 +0100
Message-ID: <f8ccdc3e364d60b06cb3fc499ba87f40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 862F5219
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 15:56:17 +0100 (MET)
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
Last Modified:              11-18-2004 15:56 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 c0ldevil - 11-18-04 15:46 
----------------------------------------------------------------------
I made a diff os the dump files before and after the loading/unloading of
the OSS module and there were no differences.

Here are the dumps:

--> AFTER FRESH BOOT, snd-ymfpci loaded:

YMFPCI

0000: 0002
0004: 100000
0008: 0000
000c: 0000
0010: 0000
0014: 0000
0018: 0000
001c: 8200
0020: 8200
0024: 8200
0028: 80008200
002c: 0000
0030: 0000
0034: 0004
0038: 0000
003c: 000c
0040: 0000
0044: 0000
0048: 0000
004c: 0000
0050: 0000
0054: ff00ff
0058: 555500ff
005c: 0000
0060: 2a0001
0064: 2a0001
0068: 80000000
006c: 0000
0070: 0002
0074: 0000
0078: 0000
007c: 0000
0080: 3fff3fff
0084: 3fff3fff
0088: 3fff3fff
008c: 0000
0090: 0000
0094: 0000
0098: 0000
009c: 0000
00a0: 0000
00a4: 3fff3fff
00a8: 3fff3fff
00ac: 3fff3fff
00b0: 0000
00b4: 0000
00b8: 0000
00bc: 0000
00c0: 0000
00c4: 0000
00c8: 0000
00cc: 0000
00d0: 0000
00d4: 0000
00d8: 0000
00dc: 0000
00e0: 0000
00e4: 0000
00e8: 0000
00ec: 0000
00f0: 0000
00f4: 0000
00f8: 0000
00fc: 0000
0100: 0000
0104: 0000
0108: 0000
010c: 0000
0110: 0000
0114: 0001
0118: 0000
011c: 0000
0120: 0000
0124: 0000
0128: 0000
012c: 0000
0130: 0000
0134: 0000
0138: 0000
013c: 0000
0140: 001e
0144: 0004
0148: 0004
014c: 0100
0150: 0000
0154: 0018
0158: c5e8000
015c: c5ebe00
0160: c5ebf00
0164: c5ec000

----------------------------------------------------------------------
 c0ldevil - 11-18-04 15:56 
----------------------------------------------------------------------
oh... i'll just upload the dumps

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
