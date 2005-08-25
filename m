From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001352]: 5.1 support in alsa 1.0.9a
Date: Thu, 25 Aug 2005 19:20:44 +0200
Message-ID: <cbe75955fef74f0f2de801ea46497aba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0711B206
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 19:20:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1352> 
======================================================================
Reported By:                saa_1973
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1352
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.9
======================================================================
Date Submitted:             08-21-2005 14:51 CEST
Last Modified:              08-25-2005 19:20 CEST
======================================================================
Summary:                    5.1 support in alsa 1.0.9a
Description: 
How do i get 5.1 audio support through alsa drivers. This is the
information of my audio hardware.

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)

Please advise.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 08-22-05 13:08 
----------------------------------------------------------------------
5.1 support depends on the codec.

What are the contents of /proc/asound/cards?

----------------------------------------------------------------------
 saa_1973 - 08-25-05 19:20 
----------------------------------------------------------------------
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with AD1985 at 0xffa7f800, irq 3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 14:51 saa_1973       New Issue                                    
08-21-05 14:51 saa_1973       Kernel Version            => 2.6.9           
08-22-05 13:08 Clemens LadischNote Added: 0005894                          
08-22-05 13:08 Clemens LadischStatus                   new => feedback     
08-25-05 19:20 saa_1973       Note Added: 0005943                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
