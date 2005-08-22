From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001360]: 16bit mono -> 24bit stereo conversion (plughw) produces noise in right channel
Date: Mon, 22 Aug 2005 22:42:41 +0200
Message-ID: <4547440d15038a1806e47e4bdc5a0c59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DC5223E
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 22:42:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1360> 
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1360
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-22-2005 22:42 CEST
Last Modified:              08-22-2005 22:42 CEST
======================================================================
Summary:                    16bit mono -> 24bit stereo conversion (plughw)
produces noise in right channel
Description: 
The sample conversion from 16bit mono format to 24bit stereo format (using
plughw:n) produces the correct signal in the left channel, but only noise
in the right channel.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 22:42 grabner        New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
