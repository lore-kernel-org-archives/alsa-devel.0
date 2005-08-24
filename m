From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001366]: 3D control, EQ peaks and EQ controls appear in capture view of alsamixer and they also have capture channels in amixer
Date: Wed, 24 Aug 2005 09:26:01 +0200
Message-ID: <a080a6afdc5a2b4494b748177b5d793e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1405C246
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 09:26:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1366> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1366
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-24-2005 09:26 CEST
Last Modified:              08-24-2005 09:26 CEST
======================================================================
Summary:                    3D control, EQ peaks and EQ controls appear in
capture view of alsamixer and they also have capture channels in amixer
Description: 
3D control (Depth and Rear Depth) appear in capture view of alsamixer.

amixer display these controls have capture channels.



EQ peaks

alsamixer cannot display 10-bands EQ peaks properly.

amixer display the wrong channel name for EQ peaks (Feature request).

Refer to 5.2.3.4.2.6 Graphical Equalizer Controls in USB audio
http://www.usb.org/developers/devclass_docs/audio10.pdf

Is it feasible to adopt the naming convention of the EQ center frequency
in amixer/alsamixer ?



10-bands stereo EQ controls

alsamixer display 10-bands stereo EQ controls in capture view.

amixer display the 10 EQ controls have capture channels.

In theory, the EQ controls can be connected to regulate the capture audio
from AC97, but this will need a rewrite of the existing driver to support
dynamic disconnect of the equalizer from the playback device and connect
the capture device and vice versa.

Most au8810/au8830 users perfer to use the Equalizer to control playback
only.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:26 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
