From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000567]: "Loudness" and "Sim. stereo" controls missing in mixer
Date: Wed, 22 Mar 2006 04:06:16 +0100
Message-ID: <cb0133fcf238b72a7016f16898d75a30@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D542118C
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 04:06:16 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=567> 
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   567
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-05-2004 17:47 CEST
Last Modified:              03-22-2006 04:06 CET
======================================================================
Summary:                    "Loudness" and "Sim. stereo" controls missing in
mixer
Description: 
Since 1.0.4 (somewhere around there), the S/PDIF-controls have disappeared
from the mixer... It has been there before and there IS one on my
soundcard (Terratec DMX Xfire 1024, cs46xx)
======================================================================

----------------------------------------------------------------------
 pmatil - 03-29-05 17:47 
----------------------------------------------------------------------
'"Duplicate Front" should work. How did you test it?'
-I suppose it should work something like copying the front channel audio
to the rear channel? So when my soundcard has 4 outputs, front channel
should be on the rear channel too?

'I have no idea about your mixer save/restore problem. It sounds like a
problem of installation... '
-As you see from earlier notes, the problem was solved by adding
--with-cards=cs46xx-new-dsp to the configure options. Now when this has
been removed, mixer settings won't save. However, the IEC958 controls are
present. This may be a Debian specifig bug, because I get ALSA from apt
directly (source and then make-kpkg modules_image).

----------------------------------------------------------------------
 rlrevell - 03-22-06 04:06 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:47 pmatil         New Issue                                    
10-05-04 17:47 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:47 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:13 tiwai          Note Added: 0002018                          
10-07-04 18:06 pmatil         File Added: asound.state                     
10-07-04 18:20 pmatil         File Added: codec97#0                        
10-07-04 18:23 pmatil         Note Added: 0002037                          
10-11-04 14:07 tiwai          Note Added: 0002077                          
10-11-04 14:08 tiwai          File Added: cs4298-spdif.diff                    
10-13-04 13:05 pmatil         Note Added: 0002122                          
10-13-04 15:50 tiwai          Note Added: 0002123                          
10-14-04 13:11 pmatil         File Added: prev_+reg                        
10-14-04 13:11 pmatil         File Added: current_+reg                     
10-14-04 13:13 pmatil         Note Added: 0002143                          
10-14-04 13:14 pmatil         Note Edited: 0002143                         
10-14-04 14:27 tiwai          Note Added: 0002145                          
10-14-04 14:39 tiwai          Note Added: 0002146                          
10-14-04 16:20 pmatil         Note Added: 0002153                          
10-14-04 16:31 tiwai          Note Added: 0002155                          
10-14-04 18:08 pmatil         Note Added: 0002157                          
10-15-04 13:53 pmatil         Note Edited: 0002157                         
10-18-04 17:44 tiwai          Note Added: 0002196                          
10-20-04 21:32 pmatil         Note Added: 0002219                          
03-28-05 04:19 jdthood        Summary                  S/PDIF control missing in
mixer => "Loudness" and "Sim. stereo" controls missing in mixer
03-28-05 11:46 pmatil         Note Added: 0004237                          
03-29-05 17:23 tiwai          Note Added: 0004249                          
03-29-05 17:47 pmatil         Note Added: 0004252                          
03-22-06 04:06 rlrevell       Status                   new => closed       
03-22-06 04:06 rlrevell       Note Added: 0008838                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
