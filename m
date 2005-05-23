From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001118]: es1868 - mono recording not working properly
Date: Mon, 23 May 2005 11:39:12 +0200
Message-ID: <89241567acd54e46aea20afa64109996@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6D49F1DF
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 11:39:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1118> 
======================================================================
Reported By:                MStrecke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1118
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.10
======================================================================
Date Submitted:             05-19-2005 23:36 CEST
Last Modified:              05-23-2005 11:39 CEST
======================================================================
Summary:                    es1868 - mono recording not working properly
Description: 
I'm using an old Fujitsu Lifebook E-6570. The on-board sound card is
recognized as "ESS Technology ES1978 Maestro 2E (rev 10)", ID: 125d:1978.

I'm having problems recording mono audio (mic input, line input, etc.).
Only a medium pitched tone is recorded (not a sine waveform, no feed
back).  Stereo recording works without problems (using audacity).

======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-05 11:39 
----------------------------------------------------------------------
Mono capture works fine with my machine (compaq armada M700).
Attach /etc/asound.state to check your mixer configuration.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-19-05 23:36 MStrecke       New Issue                                    
05-19-05 23:36 MStrecke       Distribution              => Ubuntu          
05-19-05 23:36 MStrecke       Kernel Version            => 2.6.10          
05-23-05 11:39 tiwai          Note Added: 0004702                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
