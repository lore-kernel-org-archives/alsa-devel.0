From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000872]: Mixer not functioning correctly
Date: Mon, 31 Jan 2005 21:29:02 +0100
Message-ID: <d4222a4ea9cc7f58a7ff4f0033491aba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EBF9A23C
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 21:29:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=872> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   872
Category:                   CORE OSS - mixer
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Testing (Sarge)
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-31-2005 21:29 CET
Last Modified:              01-31-2005 21:29 CET
======================================================================
Summary:                    Mixer not functioning correctly
Description: 
Some things seem to not be set up correctly in the volume controls in
alsamixer (and therefore possibly everything based on alsamixer).

1) The "Master" volume has no effect when i'm using headphones.

2) If i turn everything off except "Headphones" i still get sound in
headphones when i play music. I would have assumed this wouldn't be the
case, as PCM volume is at zero. However if i mute PCM, i get no sound. The
same is true for when i take out headphones and turn everything off except
the master volume.

3) I'm not sure if this is a bug with the mixer or the intel drivers, so i
posted this as a bug for the drivers... I get severe distortion when the
PCM volume is turned up.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:29 Mutant_Fruit   New Issue                                    
01-31-05 21:29 Mutant_Fruit   Distribution              => Debian Testing
(Sarge)
01-31-05 21:29 Mutant_Fruit   Kernel Version            => 2.6.8           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
