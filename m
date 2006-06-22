From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002089]: Audio capture does not work
Date: Thu, 22 Jun 2006 05:05:48 +0200
Message-ID: <ec117a9f0296a22ee06a18a12843ec33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CD7321C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jun 2006 05:05:49 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2089> 
======================================================================
Reported By:                stepasha
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2089
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper Drake
Kernel Version:             Linux version 2.6.15-21-386
======================================================================
Date Submitted:             05-01-2006 16:42 CEST
Last Modified:              06-22-2006 05:05 CEST
======================================================================
Summary:                    Audio capture does not work
Description: 
Audio capture for the Intel ICH6 audio controller (Realtek ALC260 mixer)
does not work in Dapper Drake (nor in Breezy from my testing).

My applications have no problems sharing sound, but I have come across the
following symptoms:

1.  I can record using several programs including sound-recorder, but only
silence is recorded.
2.  Audacity gives me no option to choose my capture device (mic, etc.)
======================================================================

----------------------------------------------------------------------
 stepasha - 06-22-06 05:05 
----------------------------------------------------------------------
I am using a Quanta KN1 series notebook.  I'm also including the result of
"cat /proc/asound/card0/codec#0"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-01-06 16:42 stepasha       New Issue                                    
05-01-06 16:42 stepasha       File Added: dmesg.txt                        
05-01-06 16:42 stepasha       Distribution              => Ubuntu Dapper Drake
05-01-06 16:42 stepasha       Kernel Version            => Linux version
2.6.15-21-386
06-22-06 05:05 stepasha       Note Added: 0010415                          
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
