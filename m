From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001517]: No sound on hda-intel on Acer TravelMate 4061NLMi
Date: Mon, 31 Oct 2005 00:19:58 +0100
Message-ID: <198e4883bf1c6b7862215e9e4df2e5fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4E44179
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 00:19:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1517> 
======================================================================
Reported By:                er-ku
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1517
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-9-686
======================================================================
Date Submitted:             10-31-2005 00:19 CET
Last Modified:              10-31-2005 00:19 CET
======================================================================
Summary:                    No sound on hda-intel on Acer TravelMate 4061NLMi
Description: 
This will be very much like other reports around.

Just bought a new laptop and installed Ubuntu Linux on it, and updated it.
Sound modules load silently, no complainments, alsamixer works and
channels are unmuted, but I get absolutely no sound from speakers of
headphones.

I'm not the only one having this issue
(http://ubuntuforums.org/showthread.php?p=450628), however, all the info I
managed to google either didn't help me, or was simply unfinished (like
forum questions that aren't answered).

I tried the stock drivers provided by the Ubuntu kernel, then I tried
1.0.10rc2, and cvs builds i made myself (created them as .debs though). In
all cases the result was the same - absolute silence.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 00:19 er-ku          New Issue                                    
10-31-05 00:19 er-ku          Distribution              => Ubuntu Breezy   
10-31-05 00:19 er-ku          Kernel Version            => 2.6.12-9-686    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
