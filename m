From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001404]: (Apparently) no microphone support
Date: Sat, 10 Sep 2005 10:46:48 +0200
Message-ID: <90aae61308f86c1b83edebef9720cf93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 646C91CD
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 10:46:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1404> 
======================================================================
Reported By:                Twey
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1404
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.13-homegrown
======================================================================
Date Submitted:             09-08-2005 18:40 CEST
Last Modified:              09-10-2005 10:46 CEST
======================================================================
Summary:                    (Apparently) no microphone support
Description: 
My SB Live! 24-Bit has no microphone-related channels.  Using any mixer
(tried: alsamixer, kmix, gnome-volume-control), it seems not to support
microphones.
Audacity shows very small (pixel-size) distortions in the recording graph
at times.  I presume this means that the input is being received, but is
too miniscule to make a difference.  I can't do anything about this; there
are no appropriate sliders or "mic boost" in any mixer application.
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:41 
----------------------------------------------------------------------
alsa-driver must be compiled with the same version of GCC as the kernel.
Please compile and install your own kernel and then try alsa-driver again.

----------------------------------------------------------------------
 Twey - 09-10-05 10:46 
----------------------------------------------------------------------
I already compiled my own kernel.  An FC4 .13 binary is not yet available.
I found a mention of this in another thread, and have reported it as a
seperate issue (0001409).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-05 18:40 Twey           New Issue                                    
09-08-05 18:40 Twey           Distribution              => Fedora Core 4   
09-08-05 18:40 Twey           Kernel Version            => 2.6.13-homegrown
09-08-05 18:43 Twey           Issue Monitored: Twey                        
09-08-05 18:46 rlrevell       Note Added: 0006074                          
09-08-05 18:55 Twey           Note Added: 0006075                          
09-08-05 19:11 Twey           Note Added: 0006079                          
09-10-05 10:41 jcdutton       Note Added: 0006110                          
09-10-05 10:41 jcdutton       Status                   assigned => feedback
09-10-05 10:46 Twey           Note Added: 0006112                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
