From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000686]: No surround sound
Date: Sun, 28 Nov 2004 15:45:16 +0100
Message-ID: <f0f8fbb4500a801fa149ab3dc6c74630@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 427B326E
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 15:45:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=686> 
======================================================================
Reported By:                dziegiel
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   686
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.4.26-gentoo-r9
======================================================================
Date Submitted:             11-28-2004 15:45 CET
Last Modified:              11-28-2004 15:45 CET
======================================================================
Summary:                    No surround sound
Description: 
I can`t enable surround sound on my 5.1 speakers.
In xmms with alsa-plugin i get stereo with 2 Front speakers[low-quality
sound] ,but with oss i get 2 Front and Center[they work fine]without
Rear.
In movies[I`ve tried several players] I have the same problem.
When I type:
mplayer -ao alsa1x -channels 6 movie.avi
I get:
...
alsa-init: soundcard set to surround51
ALSA lib pcm.c:1851:(snd_pcm_open_conf) Invalid type for PCM surround51
definition (id: surround51, value: cards.pcm.surround51)
alsa-init: playback open error:
Z&https://bugtrack.alsa-project.org/alsa-bug/view.php?id=322;y argument
...

I`ve tried everything with alsamixer, but with no result.
PS.
Sorry for my English.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 15:45 dziegiel       New Issue                                    
11-28-04 15:45 dziegiel       Distribution              => Gentoo Linux    
11-28-04 15:45 dziegiel       Kernel Version            => 2.4.26-gentoo-r9
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
