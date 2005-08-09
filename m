From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000897]: test/timer.c malfunctions with snd-rtctimer
Date: Tue, 9 Aug 2005 13:46:32 +0200
Message-ID: <401965a5ac9fb100e767fe5bb68f56e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D1A6C1D6
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:46:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=897> 
======================================================================
Reported By:                phunge
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   897
Category:                   timer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-09-2005 15:45 CET
Last Modified:              08-09-2005 13:46 CEST
======================================================================
Summary:                    test/timer.c malfunctions with snd-rtctimer
Description: 
I'm trying to learn how to use the ALSA timer API for getting a hi-res
interrupt in a program of mine. When I compile test/timer.c, it runs
correctly using the default system timer. However, when I try to specify
the RTC timer by modprobing snd-rtctimer and running

./timer class=1 sclass=0 card=0 device=1 subdevice=0

the program fails (output under "additional information").

/dev/rtc is readable and I can run the RTC test from
http://stommel.tamu.edu/~baum/linux-kernel/rtc.txt
so I think the problem is in alsa.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-11-05 09:42 
----------------------------------------------------------------------
Works fine with 2.6.11, too.

----------------------------------------------------------------------
 perex - 05-30-05 13:30 
----------------------------------------------------------------------
We cannot duplicate and reporter is not active.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 15:45 phunge         New Issue                                    
02-14-05 10:47 Clemens LadischNote Added: 0003587                          
02-14-05 11:35 phunge         Note Added: 0003589                          
02-16-05 12:02 phunge         Note Added: 0003622                          
03-11-05 09:42 Clemens LadischNote Added: 0003882                          
05-30-05 13:30 perex          Status                   new => resolved     
05-30-05 13:30 perex          Resolution               open => unable to
duplicate
05-30-05 13:30 perex          Assigned To               => perex           
05-30-05 13:30 perex          Note Added: 0004810                          
08-09-05 13:46 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
