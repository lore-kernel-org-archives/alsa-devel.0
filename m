From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000871]: Distortion in sound output.
Date: Mon, 14 Feb 2005 16:11:13 +0100
Message-ID: <be4ebd8066ffc7d0de4c479af7728e52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BBC5E1FE
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 16:11:13 +0100 (MET)
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
Last Modified:              02-14-2005 16:11 CET
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
 Mutant_Fruit - 02-13-05 17:21 
----------------------------------------------------------------------
Problem fixed using ac97_quirk=hp_only.

This can be closed.

----------------------------------------------------------------------
 tiwai - 02-14-05 16:11 
----------------------------------------------------------------------
OK please provide the output of lspci -nv to set ac97_quirk=hp_only as
default.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:18 Mutant_Fruit   New Issue                                    
01-31-05 21:18 Mutant_Fruit   Distribution              => Debian Sarge    
01-31-05 21:18 Mutant_Fruit   Kernel Version            => 2.6.8           
02-02-05 11:21 tiwai          Note Added: 0003484                          
02-05-05 01:33 Mutant_Fruit   Note Added: 0003517                          
02-13-05 17:21 Mutant_Fruit   Note Added: 0003585                          
02-14-05 16:11 tiwai          Note Added: 0003592                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
