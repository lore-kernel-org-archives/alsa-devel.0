From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000258]: Recording from line-in produces noise
Date: Wed, 23 Mar 2005 15:29:46 +0100
Message-ID: <cedb9bfa1dc15e3d0489727bb1a53c71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 17FAC26B
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:29:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=258> 
======================================================================
Reported By:                Fancia
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   258
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.22
======================================================================
Date Submitted:             05-06-2004 22:03 CEST
Last Modified:              03-23-2005 15:29 CET
======================================================================
Summary:                    Recording from line-in produces noise
Description: 
Attempting to record audio from the sound card's line-in port causes
audible pops and crackle in the resulting recording, regardless of
recording software used. These artefacts are not present in the input
itself and are not audible during the recording itself, but are present in
the resulting recording. I've tried recording from several different
devices on the same line-in port, and the noise is consistent. I've spoken
to several other AmigaOne owners with the same sound card, all of whom can
reproduce the problem.
Attached is a recording from my Roland MT-32 synthesizer module. Aside
from normalization, it's unaltered from the original recording.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:21 
----------------------------------------------------------------------
Can you verify this bug still exists with latest ALSA version, 1.0.7?

----------------------------------------------------------------------
 jdthood - 03-23-05 15:29 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue in later ALSA
releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 22:03 Fancia         New Issue                                    
05-06-04 22:03 Fancia         Distribution              => Debian          
05-06-04 22:03 Fancia         Kernel Version            => 2.4.22          
05-06-04 22:05 Fancia         Issue Monitored: Fancia                      
05-06-04 22:06 Fancia         Issue End Monitor: Fancia                    
05-06-04 22:14 Fancia         Note Added: 0001064                          
11-17-04 19:21 rlrevell       Note Added: 0002440                          
03-23-05 15:29 jdthood        Note Added: 0004161                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
