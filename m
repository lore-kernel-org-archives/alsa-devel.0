From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001324]: ALSA apps that use both playback and capture segfaults with plug:jack
Date: Sat, 10 Sep 2005 17:59:22 +0200
Message-ID: <04c330543575762971f316a28bc4adcb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E5D215D
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 17:59:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1324> 
======================================================================
Reported By:                b0ef
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1324
Category:                   PCM - jack
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-09-2005 21:36 CEST
Last Modified:              09-10-2005 17:59 CEST
======================================================================
Summary:                    ALSA apps that use both playback and capture
segfaults with plug:jack
Description: 
I have applied realtime-preempt-2.6.13-rc4-RT-V0.7.51-38

ALSA apps that use both playback and capture segfaults with plug:jack

I have tested with several applications, primarily asterisk. 

I have not found any app that uses both playback and capture that works
with plug:jack. Normal playback and capture separate with plug:jack works
great. 
======================================================================

----------------------------------------------------------------------
 b0ef - 08-28-05 18:58 
----------------------------------------------------------------------
I also tested this with kphone which is also a voip application. 

I gave it the plug:jack audio device in it's alsa configuration. 

It brought down jack and immediately exited.

Please, if any apps are known to work with both playback and capture,
please scream out.



----------------------------------------------------------------------
 b0ef - 09-10-05 17:59 
----------------------------------------------------------------------
I would like to request that this bug be closed because I have added a new
bug (0001411) report to mantis that is more general and would allow for
updating information which is hardcoded in this bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-09-05 21:36 b0ef           New Issue                                    
08-09-05 21:40 b0ef           Note Added: 0005736                          
08-09-05 21:42 b0ef           Note Added: 0005737                          
08-09-05 21:45 b0ef           Note Added: 0005738                          
08-09-05 21:49 b0ef           Note Added: 0005739                          
08-09-05 22:05 b0ef           Issue Monitored: b0ef                        
08-10-05 16:01 b0ef           Note Added: 0005749                          
08-10-05 16:07 b0ef           Note Added: 0005750                          
08-20-05 17:32 b0ef           Note Deleted: 0005736                        
08-20-05 17:32 b0ef           Note Deleted: 0005737                        
08-20-05 17:32 b0ef           Note Deleted: 0005739                        
08-20-05 17:36 b0ef           Note Deleted: 0005750                        
08-20-05 17:36 b0ef           Note Edited: 0005738                         
08-28-05 18:58 b0ef           Note Edited: 0005749                         
09-04-05 02:42 b0ef           Note Edited: 0005738                         
09-04-05 02:42 b0ef           Note Edited: 0005738                         
09-04-05 02:43 b0ef           Note Edited: 0005738                         
09-04-05 02:55 b0ef           Note Edited: 0005738                         
09-09-05 18:43 mtaht          Issue Monitored: mtaht                       
09-10-05 17:59 b0ef           Note Added: 0006122                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
