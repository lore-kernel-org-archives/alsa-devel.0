From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000871]: Distortion in sound output.
Date: Wed, 2 Feb 2005 11:21:13 +0100
Message-ID: <4ef973e2f6f474b1a9f6bd28502439ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 37B6B211
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 11:21:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=871> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   871
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-31-2005 21:18 CET
Last Modified:              02-02-2005 11:21 CET
======================================================================
Summary:                    Distortion in sound output.
Description: 
There is distortion in the sound output. This occurs in two ways.

1) When the volume in the mixers gets set to high (i.e. into the red)
there is severe distortion in the sound.

2) Occasionally i notice a distortion in the right channel. Not too sure
how to describe it other than its like an intermittant buzz, and isn't
supposed to be in the music.

If you need any more info, gimme a shout. I'm new at this.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-02-05 11:21 
----------------------------------------------------------------------
Attach the output of /proc/asound/card0/codec97#0/* files.
My rough guess is that your codec chip applys gain over 80% master/pcm
volume up to +12dB. resulting in overload.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:18 Mutant_Fruit   New Issue                                    
01-31-05 21:18 Mutant_Fruit   Distribution              => Debian Sarge    
01-31-05 21:18 Mutant_Fruit   Kernel Version            => 2.6.8           
02-02-05 11:21 tiwai          Note Added: 0003484                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
