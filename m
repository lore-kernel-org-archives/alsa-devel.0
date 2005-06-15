From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001189]: Aureon 7.1 Universe needs manual rate in .asoundrc when changing internal clock
Date: Wed, 15 Jun 2005 14:39:02 +0200
Message-ID: <c58470af8d85b5f20e2ecfbc69abce1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1425F17E
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 14:39:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1189> 
======================================================================
Reported By:                BrianMeidell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1189
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11-gentoo-r3
======================================================================
Date Submitted:             06-13-2005 22:33 CEST
Last Modified:              06-15-2005 14:39 CEST
======================================================================
Summary:                    Aureon 7.1 Universe needs manual rate in .asoundrc
when changing internal clock
Description: 
When changing the master internal clock rate on my aureon 7.1 universe, I
also need to manually set the rate in .asoundrc for the device and match
it to the alsamixer setting, otherwise it defaults to what sounds like
44.1 KHz.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 14:39 
----------------------------------------------------------------------
Turn off "Multi Track Rate Locking" switch if it's on?  Otherwise the
hardware won't follow the sample rate the app sets.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-05 22:33 BrianMeidell   New Issue                                    
06-13-05 22:33 BrianMeidell   Distribution              => Gentoo          
06-13-05 22:33 BrianMeidell   Kernel Version            => 2.6.11-gentoo-r3
06-13-05 22:35 BrianMeidell   Issue Monitored: BrianMeidell                    
06-15-05 14:39 tiwai          Note Added: 0005025                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
