From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001825]: Latest Update (alsa-utils,
	alsa-lib and system-config-soundcard) causes severe distortion of
	sound output
Date: Tue, 18 Jul 2006 14:30:22 +0200
Message-ID: <de2eba260df6ad31d387b165f4b104c1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6CB22ED
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:30:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1825> 
======================================================================
Reported By:                poylywog
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - utils
Issue ID:                   1825
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             02-06-2006 16:23 CET
Last Modified:              07-18-2006 14:30 CEST
======================================================================
Summary:                    Latest Update (alsa-utils, alsa-lib and
system-config-soundcard) causes severe distortion of sound output
Description: 
Sound card is Creative SB Audigy

Performed YUM update of above and upon performing soundcard detection and
testing of speakers output was extremely distorted (noise and pops)Music
Players were inoperable. Tried various settings (3 listed) of emu-10k1
driver with no effect. 
======================================================================

----------------------------------------------------------------------
 stransky - 02-07-06 09:15 
----------------------------------------------------------------------
It could be a bug in the latest s-c-s update. Please file a new bug on
http://bugzilla.redhat.com and attach the /root/scsound.log.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 16:23 poylywog       New Issue                                    
02-07-06 09:15 stransky       Note Added: 0007955                          
07-18-06 14:30 jcdutton       Status                   new => assigned     
07-18-06 14:30 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
