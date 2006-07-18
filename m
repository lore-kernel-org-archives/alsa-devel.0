From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000730]: 8bit sound is corrupted after
	asxfload used to load large sound font
Date: Tue, 18 Jul 2006 20:28:21 +0200
Message-ID: <225d13696f36bd0017c48e035f771caa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67290242
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:28:21 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=730> 
======================================================================
Reported By:                busa_ru
Assigned To:                jcdutton
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
Last Modified:              07-18-2006 20:28 CEST
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
07-18-06 20:22 pzad           Assigned To              pzad =>             
07-18-06 20:28 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
