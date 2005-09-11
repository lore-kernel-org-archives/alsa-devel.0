From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001412]: resampler hangs in snd_pcm_write_areas
Date: Sun, 11 Sep 2005 04:18:47 +0200
Message-ID: <d94a621deb6bd7aab3ea614adedf9463@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BD75183
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 04:18:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1412> 
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1412
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-11-2005 04:18 CEST
Last Modified:              09-11-2005 04:18 CEST
======================================================================
Summary:                    resampler hangs in snd_pcm_write_areas
Description: 
When trying to create a hardware-independent demonstration for issue
#0001360, I found another problem. For certain resampling parameters, ALSA
hangs in the function snd_pcm_write_areas in file pcm.c (variable "size",
which is used in the termination criterion, remains constant).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 04:18 grabner        New Issue                                    
09-11-05 04:18 grabner        File Added: resampling_bug_demo.tbz               
    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
