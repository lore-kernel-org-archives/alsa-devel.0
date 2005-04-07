From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001038]: SPDIF output dont work well, is crack and play to high tone
Date: Thu, 7 Apr 2005 15:00:31 +0200
Message-ID: <564cfd668f9d17de40c42f60851275ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ECCDE228
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 15:00:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1038> 
======================================================================
Reported By:                konczalski
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1038
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-07-2005 15:00 CEST
Last Modified:              04-07-2005 15:00 CEST
======================================================================
Summary:                    SPDIF output dont work well, is crack and play to
high tone
Description: 
soundcard: Terratec Aureon Space 7.1
output: SPDIF (optical)
problem: this soundcard supports only S32_LE format over SPDIF output, so
i specificy this in the Aureon71.conf (pleas check if this is right so to
use a plug)

i replaced in section <confdir:pcm/iec958.conf>

############################################
slave.pcm {
	type hw
	card $CARD
	device 1
}
############################################

with

############################################
slave.pcm {
	type plug
	slave {
		pcm "hw:0,1"
		format S32_LE
	}
}
############################################

perhaps must by the end of <confdir:pcm/iec958.conf> repleced to ???

############################################
capture.pcm {
	type hw
	card $CARD
	device 1
}
############################################

with

############################################
capture.pcm {
	type plug
	slave {
		pcm "hw:0,1"
		format S32_LE
	}
}
############################################

with this setting works the soundcard fine ;-)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-05 15:00 konczalski     New Issue                                    
04-07-05 15:00 konczalski     File Added: Aureon71.conf                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
