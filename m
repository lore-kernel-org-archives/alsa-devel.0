From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000730]: 8bit sound is corrupted after asxfload used to load large sound font
Date: Sun, 19 Dec 2004 12:37:06 +0100
Message-ID: <a3373958a679b64839427b2ef55fcab7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EB3112A3
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 12:37:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=730> 
======================================================================
Reported By:                busa_ru
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   730
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-19-2004 12:37 CET
Last Modified:              12-19-2004 12:37 CET
======================================================================
Summary:                    8bit sound is corrupted after asxfload used to load
large sound font
Description: 
When loading large (23mb) sound font using asfxload, 8bit waves are not
played correctly by aplay (garbage in the speakers). But if they are
converted to 16bit everything is ok. Using play/sfxload instead gives the
same result.

Loading smaller (8mb) sound font does not trigger this behaviour. 

awesfx version is 0.5.0b-2.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 12:37 busa_ru        New Issue                                    
12-19-04 12:37 busa_ru        Distribution              => Debian unstable 
12-19-04 12:37 busa_ru        Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
