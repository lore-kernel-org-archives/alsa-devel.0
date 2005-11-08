From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001366]: 3D control, EQ peaks and EQ controls appear in capture view of alsamixer and they also have capture channels in amixer
Date: Tue, 8 Nov 2005 13:50:02 +0100
Message-ID: <2b4fd69a9308b05a5a1fc873d56f6c4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8E7E1AF
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 13:50:02 +0100 (MET)
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
Last Modified:              11-08-2005 13:50 CET
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

----------------------------------------------------------------------
 Raymond - 11-03-05 14:17 
----------------------------------------------------------------------
The two Sigmatel 3D Depth and Rear Depth controls still appear in the
Capture View of alsamixer v-1.0.10rc2

----------------------------------------------------------------------
 Raymond - 11-08-05 13:50 
----------------------------------------------------------------------
The two Realtek 3D Center and depth control of intel8x0 also appear in the
Capture view of alsamixer-1.0.10rc3 .

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:26 Raymond        New Issue                                    
09-05-05 15:18 Raymond        File Added: Capture.png                      
09-05-05 15:19 Raymond        File Added: alsamixer.png                    
11-03-05 14:17 Raymond        Note Added: 0006603                          
11-08-05 13:50 Raymond        Note Added: 0006620                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
