From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001069]: Scratchy sound through AC3 passthrough with userspace version 1.0.9rc2
Date: Thu, 21 Apr 2005 21:46:43 +0200
Message-ID: <c6520b420b0cf376651c16150ceb795e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5121186
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2005 21:46:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1069> 
======================================================================
Reported By:                Creideiki
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1069
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-21-2005 21:46 CEST
Last Modified:              04-21-2005 21:46 CEST
======================================================================
Summary:                    Scratchy sound through AC3 passthrough with
userspace version 1.0.9rc2
Description: 
I have an Audigy 2 ZS sound card connected via S/PDIF to a Logitech Z-680
decoder/speaker system. After upgrading ALSA userspace (alsa-headers,
alsa-lib) to 1.0.9rc2, with no configuration changes, all I got when
trying to play DVD:s using AC3 passthrough was scratchy noises, and the
external decoder indicated that it did not think it was getting AC3 data.
Software decoding worked, but not hardware passthrough. Both Xine and
MPlayer had this problem. I am not running aRts, or any other sound
server, and have no ~/.asoundrc file.

Downgrading to userspace version 1.0.8 made it work again.

I have no idea how to debug ALSA problems, so please let me know how to
generate any extra information you might require.

By the way, the "Product Version" field in Mantis doesn't let me select
any version higher than 1.0.8.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 21:46 Creideiki      New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
