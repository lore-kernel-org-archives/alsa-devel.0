From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001009]: NVidia CK8S 8ch: a center speaker is always silent in native alsa mode (through alsa-lib), works with oss emulation though
Date: Tue, 22 Mar 2005 22:34:33 +0100
Message-ID: <9ef5672e0304b5e848acd083ec458518@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6D656286
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:34:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1009> 
======================================================================
Reported By:                modax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1009
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.11.5 with self-compiled alsa-driver
1.0.9rc1
======================================================================
Date Submitted:             03-22-2005 22:34 CET
Last Modified:              03-22-2005 22:34 CET
======================================================================
Summary:                    NVidia CK8S 8ch: a center speaker is always silent
in native alsa mode (through alsa-lib), works with oss emulation though
Description: 
A center speaker stays quiet while playing 5.1 audio directly through
alsa-lib (eg. with kaffeine (xine) or mplayer using alsa plugin). As a
result, I'm unable to hear what people are speaking in movies because the
speech is usually sent to the center speaker (correct me if i'm wrong. i'm
new to all this 5.1 business). Anyway, adjusting the volume,
muting/unmuting "Center" section, enabling/disabling "Mic As Center/LFE"
doesn't have any effect on the center speaker. It stays silent. However,
as I noted in the summary, the center speaker works with oss audio driver
of xine/mplayer (using oss emulation). However, that mode is not perfect
as the center speaker plays the role of left surround and vice versa. In
addition, a right surround speaker stays always silent (i guess that's
because the RS channel needs to be swapped with LFE; at least I got this
impression by having a look at
/usr/share/alsa/cards/NForce.conf:surround51). To sum up, my problem is
that I can't get the center speaker (which, I guess, is channel 2 on my
hardware) working with native alsa apps playing ac3/5.1 audio.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 22:34 modax          New Issue                                    
03-22-05 22:34 modax          Distribution              => Debian unstable 
03-22-05 22:34 modax          Kernel Version            => vanilla 2.6.11.5 with
self-compiled alsa-driver 1.0.9rc1
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
