From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001357]: Add a Capture setting
Date: Tue, 23 Aug 2005 16:53:36 +0200
Message-ID: <0789b74aa2eab5a2d406ee0a7af2fd04@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 046A8261
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 16:53:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1357> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1357
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r6
======================================================================
Date Submitted:             08-22-2005 09:37 CEST
Last Modified:              08-23-2005 16:53 CEST
======================================================================
Summary:                    Add a Capture setting
Description: 
In order to record with an Audiotrak Prodigy 7.1 (snd-1724), I have to
first set the IGAIN setting using aumix. Also I have to use aumix to set
what input I want to capture from. Then I can record with any program. I
would like to a way to set what input to be use for capture and a setting
for the capture level accessible through alsamixer, so it can be changed,
stored, restored. I could use aumix to load the save settings but
sometimes it screws up and only the left channel is recorded.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-23-05 16:53 
----------------------------------------------------------------------
Everything you can do through OSS mixer can be done via alsamixer, too.
You must have missed something in alsamixer (e.g. didn't change the view
mode).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 09:37 Electro        New Issue                                    
08-22-05 09:37 Electro        Distribution              => Gentoo          
08-22-05 09:37 Electro        Kernel Version            => 2.6.12-gentoo-r6
08-23-05 16:53 tiwai          Note Added: 0005911                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
