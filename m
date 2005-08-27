From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001374]: unplug usb audio device while streaming will lock up the usb kernel
Date: Sat, 27 Aug 2005 23:53:58 +0200
Message-ID: <ed91f993f2e26f1e27d00e4553170fab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F24021DB
	for <alsa-devel@alsa-project.org>; Sat, 27 Aug 2005 23:53:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1374> 
======================================================================
Reported By:                byuan
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1374
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-27-2005 23:53 CEST
Last Modified:              08-27-2005 23:53 CEST
======================================================================
Summary:                    unplug usb audio device while streaming will lock up
the usb kernel
Description: 
unplug usb audio device while streaming will lock up the usb kernel, the
snd_pcm_close() doesn't help, unless the process that called the
snd_pcm_open be closed.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-27-05 23:53 byuan          New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
