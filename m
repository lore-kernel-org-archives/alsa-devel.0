From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000846]: Can't hear sound from one of the surround speaker, while other is working (speakers are functional).
Date: Tue, 25 Jan 2005 15:18:59 +0100
Message-ID: <d09ed9260337d2af05992070b1eea3ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 65A8B263
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 15:18:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=846> 
======================================================================
Reported By:                Envel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   846
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-24-2005 13:44 CET
Last Modified:              01-25-2005 15:18 CET
======================================================================
Summary:                    Can't hear sound from one of the surround speaker,
while other is working (speakers are functional).
Description: 
With options "Line-In as surround" and "Duplicate front" the right surround
speaker is not working, while others are functional. After uninstalling
ALSA 1.0.8 and installing againg ALSA 1.0.7 with the same mixer
configuration the error is not occures. SoundCard: nForce2 Audio Codec,
Driver: snd-intel8x0, 4 speakers.
p.s. sorry for my English.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-25-05 15:18 
----------------------------------------------------------------------
The combination of "Line-In As Surround" and "Duplicate Front" is already
weird.

Attach /etc/asound.state and /proc/asound/card0/codec97#0/* files for
debugging.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-05 13:44 Envel          New Issue                                    
01-24-05 13:44 Envel          Kernel Version            => 2.6.8.1         
01-25-05 15:18 tiwai          Note Added: 0003402                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
