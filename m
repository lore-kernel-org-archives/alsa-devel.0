From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001361]: sound choppy when resuming alsa client process
Date: Tue, 23 Aug 2005 12:39:43 +0200
Message-ID: <97609b767caf4750abbde283dc246b97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD3AD25C
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 12:39:43 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1361> 
======================================================================
Reported By:                mbwardle
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1361
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             08-23-2005 12:39 CEST
Last Modified:              08-23-2005 12:39 CEST
======================================================================
Summary:                    sound choppy when resuming alsa client process
Description: 
If I start an ALSA client process from a terminal, begin playback of a
song, suspend the process, then resume the process, the playback becomes
choppy (has many intermittent periods of silence per second).

A possibly related similar problem seems to occur if there is a runaway
process on the system which starves the ALSA client of CPU time.  Even
after the client gets a good slice of CPU time, the sound remains choppy.

This issue was originally reported as a bug in Ubuntu Linux
<http://bugzilla.ubuntu.com/show_bug.cgi?id=13003>.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-23-05 12:39 mbwardle       New Issue                                    
08-23-05 12:39 mbwardle       File Added: asound.conf                      
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
